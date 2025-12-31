const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const { v4: uuidv4 } = require('uuid');

dotenv.config();

const PORT = process.env.PORT || 8080;
const API_KEY = process.env.API_KEY;

const app = express();
app.use(cors());
app.use(express.json({ limit: '5mb' }));

function deriveHouseholdId(key) {
  return crypto.createHash('sha256').update(key).digest('hex');
}

function requireApiKey(req, res, next) {
  if (!API_KEY) return res.status(500).json({ error: 'Server API key not configured' });
  const key = req.headers['x-api-key'];
  if (!key || key !== API_KEY) return res.status(401).json({ error: 'Invalid API key' });
  req.apiKey = key;
  req.householdId = deriveHouseholdId(key);
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
    multipleStatements: true,
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

const TABLES = ['categories', 'bill_templates', 'bill_instances', 'income_sources', 'income_instances'];

function parseDate(input) {
  if (!input) return null;
  const d = new Date(input);
  return Number.isNaN(d.getTime()) ? null : d;
}

function normalizeString(input) {
  if (input === undefined || input === null) return null;
  return String(input);
}

async function upsertCategories(conn, items, ctx) {
  if (!items || !items.length) return;
  const rows = items.map((c) => {
    const id = c.id || uuidv4();
    const name = normalizeString(c.name) || 'Uncategorized';
    return [
      ctx.householdId,
      id,
      name,
      normalizeString(c.color),
      normalizeString(c.icon),
      c.sort_order ?? 0,
      normalizeString(c.device_id || ctx.deviceId),
      c.client_updated_at ?? ctx.clientNow ?? null,
      ctx.serverNow,
      null,
    ];
  });
  await conn.query(
    `INSERT INTO categories (household_id, id, name, color, icon, sort_order, device_id, client_updated_at, updated_at_server, deleted_at_server)
     VALUES ?
     ON DUPLICATE KEY UPDATE
       name=VALUES(name),
       color=VALUES(color),
       icon=VALUES(icon),
       sort_order=VALUES(sort_order),
       device_id=VALUES(device_id),
       client_updated_at=VALUES(client_updated_at),
       updated_at_server=VALUES(updated_at_server),
       deleted_at_server=NULL`,
    [rows]
  );
}

async function upsertBillTemplates(conn, items, ctx) {
  if (!items || !items.length) return;
  const rows = items.map((b) => {
    const id = b.id || uuidv4();
    const name = normalizeString(b.name) || 'Untitled Template';
    const amount = Number.isFinite(b.default_amount_cents) ? b.default_amount_cents : 0;
    return [
      ctx.householdId,
      id,
      name,
      normalizeString(b.category_id),
      amount,
      b.start_date || null,
      b.active ? 1 : 0,
      normalizeString(b.recurrence_rule),
      parseDate(b.created_at) || new Date(),
      normalizeString(b.device_id || ctx.deviceId),
      b.client_updated_at ?? ctx.clientNow ?? null,
      ctx.serverNow,
      null,
    ];
  });
  await conn.query(
    `INSERT INTO bill_templates (household_id, id, name, category_id, default_amount_cents, start_date, active, recurrence_rule, created_at, device_id, client_updated_at, updated_at_server, deleted_at_server)
     VALUES ?
     ON DUPLICATE KEY UPDATE
       name=VALUES(name),
       category_id=VALUES(category_id),
       default_amount_cents=VALUES(default_amount_cents),
       start_date=VALUES(start_date),
       active=VALUES(active),
       recurrence_rule=VALUES(recurrence_rule),
       created_at=VALUES(created_at),
       device_id=VALUES(device_id),
       client_updated_at=VALUES(client_updated_at),
       updated_at_server=VALUES(updated_at_server),
       deleted_at_server=NULL`,
    [rows]
  );
}

async function upsertBillInstances(conn, items, ctx) {
  if (!items || !items.length) return;
  const rows = items.map((b) => {
    const id = b.id || uuidv4();
    const title = normalizeString(b.title_snapshot) || 'Bill';
    const amount = Number.isFinite(b.amount_cents) ? b.amount_cents : 0;
    return [
      ctx.householdId,
      id,
      normalizeString(b.template_id),
      title,
      amount,
      b.due_date,
      normalizeString(b.status || 'scheduled'),
      b.paid_amount_cents ?? null,
      parseDate(b.paid_at),
      normalizeString(b.notes),
      normalizeString(b.category_id),
      parseDate(b.created_at) || new Date(),
      normalizeString(b.device_id || ctx.deviceId),
      b.client_updated_at ?? ctx.clientNow ?? null,
      ctx.serverNow,
      null,
    ];
  });
  await conn.query(
    `INSERT INTO bill_instances (household_id, id, template_id, title_snapshot, amount_cents, due_date, status, paid_amount_cents, paid_at, notes, category_id, created_at, device_id, client_updated_at, updated_at_server, deleted_at_server)
     VALUES ?
     ON DUPLICATE KEY UPDATE
       template_id=VALUES(template_id),
       title_snapshot=VALUES(title_snapshot),
       amount_cents=VALUES(amount_cents),
       due_date=VALUES(due_date),
       status=VALUES(status),
       paid_amount_cents=VALUES(paid_amount_cents),
       paid_at=VALUES(paid_at),
       notes=VALUES(notes),
       category_id=VALUES(category_id),
       created_at=VALUES(created_at),
       device_id=VALUES(device_id),
       client_updated_at=VALUES(client_updated_at),
       updated_at_server=VALUES(updated_at_server),
       deleted_at_server=NULL`,
    [rows]
  );
}

async function upsertIncomeSources(conn, items, ctx) {
  if (!items || !items.length) return;
  const rows = items.map((s) => {
    const id = s.id || uuidv4();
    const name = normalizeString(s.name) || 'Income';
    const amount = Number.isFinite(s.amount_cents) ? s.amount_cents : 0;
    const frequency = normalizeString(s.frequency) || 'monthly';
    return [
      ctx.householdId,
      id,
      name,
      amount,
      frequency,
      s.start_date || null,
      s.anchor_date || null,
      s.active ? 1 : 0,
      parseDate(s.created_at) || new Date(),
      normalizeString(s.device_id || ctx.deviceId),
      s.client_updated_at ?? ctx.clientNow ?? null,
      ctx.serverNow,
      null,
    ];
  });
  await conn.query(
    `INSERT INTO income_sources (household_id, id, name, amount_cents, frequency, start_date, anchor_date, active, created_at, device_id, client_updated_at, updated_at_server, deleted_at_server)
     VALUES ?
     ON DUPLICATE KEY UPDATE
       name=VALUES(name),
       amount_cents=VALUES(amount_cents),
       frequency=VALUES(frequency),
       start_date=VALUES(start_date),
       anchor_date=VALUES(anchor_date),
       active=VALUES(active),
       created_at=VALUES(created_at),
       device_id=VALUES(device_id),
       client_updated_at=VALUES(client_updated_at),
       updated_at_server=VALUES(updated_at_server),
       deleted_at_server=NULL`,
    [rows]
  );
}

async function upsertIncomeInstances(conn, items, ctx) {
  if (!items || !items.length) return;
  const rows = items.map((i) => {
    const id = i.id || uuidv4();
    const title = normalizeString(i.title_snapshot) || 'Income';
    const amount = Number.isFinite(i.amount_cents) ? i.amount_cents : 0;
    return [
      ctx.householdId,
      id,
      normalizeString(i.source_id),
      title,
      amount,
      i.date,
      normalizeString(i.status || 'expected'),
      parseDate(i.received_at),
      normalizeString(i.notes),
      parseDate(i.created_at) || new Date(),
      normalizeString(i.device_id || ctx.deviceId),
      i.client_updated_at ?? ctx.clientNow ?? null,
      ctx.serverNow,
      null,
    ];
  });
  await conn.query(
    `INSERT INTO income_instances (household_id, id, source_id, title_snapshot, amount_cents, date, status, received_at, notes, created_at, device_id, client_updated_at, updated_at_server, deleted_at_server)
     VALUES ?
     ON DUPLICATE KEY UPDATE
       source_id=VALUES(source_id),
       title_snapshot=VALUES(title_snapshot),
       amount_cents=VALUES(amount_cents),
       date=VALUES(date),
       status=VALUES(status),
       received_at=VALUES(received_at),
       notes=VALUES(notes),
       created_at=VALUES(created_at),
       device_id=VALUES(device_id),
       client_updated_at=VALUES(client_updated_at),
       updated_at_server=VALUES(updated_at_server),
       deleted_at_server=NULL`,
    [rows]
  );
}

async function softDelete(conn, table, ids, householdId, serverNow) {
  if (!ids || !ids.length) return;
  const filtered = ids.filter((v) => Boolean(v));
  if (!filtered.length) return;
  await conn.query(
    `UPDATE ${table} SET deleted_at_server=?, updated_at_server=? WHERE household_id=? AND id IN (?)`,
    [serverNow, serverNow, householdId, filtered]
  );
}

app.get('/api/v1/sync/changes', async (req, res) => {
  const since = req.query.since ? Number(req.query.since) : 0;
  const householdId = req.householdId;
  const conn = await pool.getConnection();
  try {
    const changes = {};
    for (const table of TABLES) {
      const [rows] = await conn.query(
        `SELECT * FROM ${table} WHERE household_id=? AND (updated_at_server > ? OR deleted_at_server > ?)`,
        [householdId, since, since]
      );
      changes[table] = rows;
    }
    res.json({ server_now: Date.now(), changes });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  } finally {
    conn.release();
  }
});

app.post('/api/v1/sync/push', async (req, res) => {
  const { upserts = {}, deletes = {}, device_id: deviceId, client_now: clientNow } = req.body || {};
  const serverNow = Date.now();
  const ctx = { householdId: req.householdId, deviceId, clientNow, serverNow };
  const conn = await pool.getConnection();
  try {
    await conn.beginTransaction();
    await upsertCategories(conn, upserts.categories, ctx);
    await upsertBillTemplates(conn, upserts.bill_templates, ctx);
    await upsertBillInstances(conn, upserts.bill_instances, ctx);
    await upsertIncomeSources(conn, upserts.income_sources, ctx);
    await upsertIncomeInstances(conn, upserts.income_instances, ctx);

    await softDelete(conn, 'categories', deletes.categories?.map((c) => c.id), ctx.householdId, serverNow);
    await softDelete(conn, 'bill_templates', deletes.bill_templates?.map((c) => c.id), ctx.householdId, serverNow);
    await softDelete(conn, 'bill_instances', deletes.bill_instances?.map((c) => c.id), ctx.householdId, serverNow);
    await softDelete(conn, 'income_sources', deletes.income_sources?.map((c) => c.id), ctx.householdId, serverNow);
    await softDelete(conn, 'income_instances', deletes.income_instances?.map((c) => c.id), ctx.householdId, serverNow);

    await conn.commit();
    res.json({ server_now: serverNow });
  } catch (e) {
    await conn.rollback();
    console.error(e);
    res.status(500).json({ error: e.message });
  } finally {
    conn.release();
  }
});

app.get('/api/v1/sync/full', async (req, res) => {
  const householdId = req.householdId;
  const conn = await pool.getConnection();
  try {
    const snapshot = {};
    for (const table of TABLES) {
      const [rows] = await conn.query(
        `SELECT * FROM ${table} WHERE household_id=?`,
        [householdId]
      );
      snapshot[table] = rows;
    }
    res.json({ server_now: Date.now(), data: snapshot });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message });
  } finally {
    conn.release();
  }
});

app.get('/api/v1/export', (req, res) => {
  res.status(410).json({ error: 'Legacy export/import has been replaced by sync endpoints. Use /api/v1/sync/full and /api/v1/sync/changes.' });
});

app.post('/api/v1/import', (req, res) => {
  res.status(410).json({ error: 'Legacy import that overwrote tables has been disabled. Use /api/v1/sync/push for incremental writes.' });
});
