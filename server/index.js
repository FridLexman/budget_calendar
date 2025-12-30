const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');

dotenv.config();

const PORT = process.env.PORT || 8080;
const API_KEY = process.env.API_KEY;

const app = express();
app.use(cors());
app.use(express.json({ limit: '2mb' }));

function requireApiKey(req, res, next) {
  if (!API_KEY) return res.status(500).json({ error: 'Server API key not configured' });
  const key = req.headers['x-api-key'];
  if (key !== API_KEY) return res.status(401).json({ error: 'Invalid API key' });
  next();
}

async function createPool() {
  const pool = mysql.createPool({
    host: process.env.MYSQL_HOST || 'localhost',
    port: process.env.MYSQL_PORT ? Number(process.env.MYSQL_PORT) : 3306,
    user: process.env.MYSQL_USER || 'root',
    password: process.env.MYSQL_PASSWORD || '',
    database: process.env.MYSQL_DATABASE || 'budget_calendar',
    waitForConnections: true,
    connectionLimit: 10,
    ssl: process.env.MYSQL_SSL === 'true' ? { rejectUnauthorized: false } : undefined,
  });
  return pool;
}

async function ensureSchema(pool) {
  const schemaPath = path.join(__dirname, 'schema.sql');
  const sql = fs.readFileSync(schemaPath, 'utf8');
  await pool.query(sql);
}

let pool;
createPool()
  .then(async (p) => {
    pool = p;
    await ensureSchema(pool);
    app.listen(PORT, () => {
      console.log(`Budget Calendar API listening on ${PORT}`);
    });
  })
  .catch((err) => {
    console.error('Failed to start server', err);
    process.exit(1);
  });

app.get('/health', (req, res) => {
  res.json({ ok: true, ts: new Date().toISOString() });
});

app.use(requireApiKey);

app.get('/api/v1/export', async (req, res) => {
  const conn = await pool.getConnection();
  try {
    const [categories] = await conn.query('SELECT * FROM categories');
    const [billTemplates] = await conn.query('SELECT * FROM bill_templates');
    const [billInstances] = await conn.query('SELECT * FROM bill_instances');
    const [incomeSources] = await conn.query('SELECT * FROM income_sources');
    const [incomeInstances] = await conn.query('SELECT * FROM income_instances');
    res.json({ categories, billTemplates, billInstances, incomeSources, incomeInstances });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  } finally {
    conn.release();
  }
});

app.post('/api/v1/import', async (req, res) => {
  const { categories = [], billTemplates = [], billInstances = [], incomeSources = [], incomeInstances = [] } = req.body || {};
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    await conn.query('DELETE FROM bill_instances');
    await conn.query('DELETE FROM bill_templates');
    await conn.query('DELETE FROM income_instances');
    await conn.query('DELETE FROM income_sources');
    await conn.query('DELETE FROM categories');

    if (categories.length) {
      await conn.query(
        'INSERT INTO categories (id, name, color, icon, sort_order) VALUES ?',
        [categories.map((c) => [c.id || null, c.name, c.color, c.icon, c.sort_order || 0])]
      );
    }
    if (billTemplates.length) {
      await conn.query(
        'INSERT INTO bill_templates (id, name, category, default_amount_cents, start_date, active, recurrence_rule, created_at) VALUES ?',
        [billTemplates.map((b) => [
          b.id || null,
          b.name,
          b.category || null,
          b.default_amount_cents,
          b.start_date || null,
          b.active ? 1 : 0,
          b.recurrence_rule || null,
          b.created_at || new Date(),
        ])]
      );
    }
    if (billInstances.length) {
      await conn.query(
        'INSERT INTO bill_instances (id, template_id, title_snapshot, amount_cents, due_date, status, paid_amount_cents, paid_at, notes, category, created_at) VALUES ?',
        [billInstances.map((b) => [
          b.id || null,
          b.template_id || null,
          b.title_snapshot,
          b.amount_cents,
          b.due_date,
          b.status || 'scheduled',
          b.paid_amount_cents || null,
          b.paid_at || null,
          b.notes || null,
          b.category || null,
          b.created_at || new Date(),
        ])]
      );
    }
    if (incomeSources.length) {
      await conn.query(
        'INSERT INTO income_sources (id, name, amount_cents, frequency, start_date, anchor_date, active, created_at) VALUES ?',
        [incomeSources.map((s) => [
          s.id || null,
          s.name,
          s.amount_cents,
          s.frequency,
          s.start_date || null,
          s.anchor_date || null,
          s.active ? 1 : 0,
          s.created_at || new Date(),
        ])]
      );
    }
    if (incomeInstances.length) {
      await conn.query(
        'INSERT INTO income_instances (id, source_id, title_snapshot, amount_cents, date, status, received_at, notes, created_at) VALUES ?',
        [incomeInstances.map((i) => [
          i.id || null,
          i.source_id || null,
          i.title_snapshot,
          i.amount_cents,
          i.date,
          i.status || 'expected',
          i.received_at || null,
          i.notes || null,
          i.created_at || new Date(),
        ])]
      );
    }

    await conn.commit();
    res.json({ ok: true });
  } catch (e) {
    await conn.rollback();
    console.error(e);
    res.status(500).json({ error: e.message });
  } finally {
    conn.release();
  }
});
