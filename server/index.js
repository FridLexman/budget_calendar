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

class ValidationError extends Error {
  constructor(message, status = 400) {
    super(message);
    this.status = status;
  }
}

function parseDate(input) {
  if (!input) return null;
  const d = new Date(input);
  return Number.isNaN(d.getTime()) ? null : d;
}

function toDateOnly(input) {
  const d = parseDate(input);
  if (!d) return null;
  const yr = d.getUTCFullYear();
  const mo = String(d.getUTCMonth() + 1).padStart(2, '0');
  const day = String(d.getUTCDate()).padStart(2, '0');
  return `${yr}-${mo}-${day}`;
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
      toDateOnly(b.start_date),
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
      toDateOnly(b.due_date),
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
      toDateOnly(s.start_date),
      toDateOnly(s.anchor_date),
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
      toDateOnly(i.date),
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

async function ensureRefsExist(conn, householdId, categoryIds = [], templateIds = [], sourceIds = []) {
  const missing = { categories: [], templates: [], incomeSources: [] };

  if (categoryIds.length) {
    const [rows] = await conn.query(
      'SELECT id FROM categories WHERE household_id=? AND id IN (?)',
      [householdId, categoryIds]
    );
    const found = new Set(rows.map((r) => r.id));
    missing.categories = categoryIds.filter((id) => !found.has(id));
  }

  if (templateIds.length) {
    const [rows] = await conn.query(
      'SELECT id FROM bill_templates WHERE household_id=? AND id IN (?)',
      [householdId, templateIds]
    );
    const found = new Set(rows.map((r) => r.id));
    missing.templates = templateIds.filter((id) => !found.has(id));
  }

  if (sourceIds.length) {
    const [rows] = await conn.query(
      'SELECT id FROM income_sources WHERE household_id=? AND id IN (?)',
      [householdId, sourceIds]
    );
    const found = new Set(rows.map((r) => r.id));
    missing.incomeSources = sourceIds.filter((id) => !found.has(id));
  }

  return missing;
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

    // Validate category refs for templates before inserting them
    const templateCategoryIds = (upserts.bill_templates || [])
      .map((t) => normalizeString(t.category_id))
      .filter(Boolean);
    if (templateCategoryIds.length) {
      const missing = await ensureRefsExist(conn, ctx.householdId, templateCategoryIds);
      if (missing.categories.length) {
        throw new ValidationError(`Missing categories for templates: ${missing.categories.join(',')}`);
      }
    }

    await upsertBillTemplates(conn, upserts.bill_templates, ctx);

    // Validate refs for bill instances: templates + categories
    const instanceTemplateIds = (upserts.bill_instances || [])
      .map((i) => normalizeString(i.template_id))
      .filter(Boolean);
    const instanceCategoryIds = (upserts.bill_instances || [])
      .map((i) => normalizeString(i.category_id))
      .filter(Boolean);
    const instanceMissing = await ensureRefsExist(conn, ctx.householdId, instanceCategoryIds, instanceTemplateIds);
    if (instanceMissing.categories.length || instanceMissing.templates.length) {
      throw new ValidationError(
        `Missing refs for bill_instances: categories=[${instanceMissing.categories.join(',')}] templates=[${instanceMissing.templates.join(',')}]`
      );
    }

    await upsertBillInstances(conn, upserts.bill_instances, ctx);

    // Validate refs for income instances: income_sources
    const incomeSourceIds = (upserts.income_instances || [])
      .map((i) => normalizeString(i.source_id))
      .filter(Boolean);
    const incomeMissing = await ensureRefsExist(conn, ctx.householdId, [], [], incomeSourceIds);
    if (incomeMissing.incomeSources.length) {
      throw new ValidationError(
        `Missing refs for income_instances: income_sources=[${incomeMissing.incomeSources.join(',')}]`
      );
    }

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
    console.error('sync/push failed', e);
    const status = e instanceof ValidationError ? e.status : 500;
    res.status(status).json({ error: e.message });
  } finally {
    conn.release();
  }
});

async function sendFullSnapshot(req, res) {
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
}

// Bootstrap (full snapshot) – for first-time clients; prefer /changes afterward.
app.get('/api/v1/sync/bootstrap', sendFullSnapshot);
// Backwards-compatibility alias
app.get('/api/v1/sync/full', sendFullSnapshot);

app.get('/api/v1/export', (req, res) => {
  res
    .status(410)
    .json({ error: 'DANGEROUS legacy export/import disabled. Use /api/v1/sync/bootstrap or /api/v1/sync/changes.' });
});

app.post('/api/v1/import', (req, res) => {
  res
    .status(410)
    .json({ error: 'DANGEROUS legacy import (table overwrite) disabled. Use /api/v1/sync/push for incremental writes.' });
});
