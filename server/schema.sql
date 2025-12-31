-- Drop old tables so the sync-safe schema is enforced. This will reset data; export first if needed.
DROP TABLE IF EXISTS income_instances;
DROP TABLE IF EXISTS income_sources;
DROP TABLE IF EXISTS bill_instances;
DROP TABLE IF EXISTS bill_templates;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS sync_settings;

CREATE TABLE IF NOT EXISTS categories (
  household_id VARCHAR(64) NOT NULL,
  id CHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(32),
  icon VARCHAR(64),
  sort_order INT DEFAULT 0,
  device_id VARCHAR(64),
  client_updated_at BIGINT,
  updated_at_server BIGINT NOT NULL,
  deleted_at_server BIGINT DEFAULT NULL,
  PRIMARY KEY (household_id, id),
  UNIQUE KEY idx_categories_name (household_id, name),
  INDEX idx_categories_updated (household_id, updated_at_server),
  INDEX idx_categories_deleted (household_id, deleted_at_server)
);

CREATE TABLE IF NOT EXISTS bill_templates (
  household_id VARCHAR(64) NOT NULL,
  id CHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  category_id CHAR(36),
  default_amount_cents INT NOT NULL,
  start_date DATE,
  active TINYINT(1) DEFAULT 1,
  recurrence_rule TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  device_id VARCHAR(64),
  client_updated_at BIGINT,
  updated_at_server BIGINT NOT NULL,
  deleted_at_server BIGINT DEFAULT NULL,
  PRIMARY KEY (household_id, id),
  INDEX idx_bill_templates_updated (household_id, updated_at_server),
  INDEX idx_bill_templates_deleted (household_id, deleted_at_server),
  CONSTRAINT fk_bill_template_category FOREIGN KEY (household_id, category_id) REFERENCES categories(household_id, id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bill_instances (
  household_id VARCHAR(64) NOT NULL,
  id CHAR(36) NOT NULL,
  template_id CHAR(36),
  title_snapshot VARCHAR(255) NOT NULL,
  amount_cents INT NOT NULL,
  due_date DATE NOT NULL,
  status VARCHAR(32) DEFAULT 'scheduled',
  paid_amount_cents INT NULL,
  paid_at DATETIME NULL,
  notes TEXT,
  category_id CHAR(36),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  device_id VARCHAR(64),
  client_updated_at BIGINT,
  updated_at_server BIGINT NOT NULL,
  deleted_at_server BIGINT DEFAULT NULL,
  PRIMARY KEY (household_id, id),
  INDEX idx_bill_instances_updated (household_id, updated_at_server),
  INDEX idx_bill_instances_deleted (household_id, deleted_at_server),
  CONSTRAINT fk_bill_instance_template FOREIGN KEY (household_id, template_id) REFERENCES bill_templates(household_id, id) ON DELETE CASCADE,
  CONSTRAINT fk_bill_instance_category FOREIGN KEY (household_id, category_id) REFERENCES categories(household_id, id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS income_sources (
  household_id VARCHAR(64) NOT NULL,
  id CHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  amount_cents INT NOT NULL,
  frequency VARCHAR(32) NOT NULL,
  start_date DATE,
  anchor_date DATE,
  active TINYINT(1) DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  device_id VARCHAR(64),
  client_updated_at BIGINT,
  updated_at_server BIGINT NOT NULL,
  deleted_at_server BIGINT DEFAULT NULL,
  PRIMARY KEY (household_id, id),
  INDEX idx_income_sources_updated (household_id, updated_at_server),
  INDEX idx_income_sources_deleted (household_id, deleted_at_server)
);

CREATE TABLE IF NOT EXISTS income_instances (
  household_id VARCHAR(64) NOT NULL,
  id CHAR(36) NOT NULL,
  source_id CHAR(36),
  title_snapshot VARCHAR(255) NOT NULL,
  amount_cents INT NOT NULL,
  date DATE NOT NULL,
  status VARCHAR(32) DEFAULT 'expected',
  received_at DATETIME NULL,
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  device_id VARCHAR(64),
  client_updated_at BIGINT,
  updated_at_server BIGINT NOT NULL,
  deleted_at_server BIGINT DEFAULT NULL,
  PRIMARY KEY (household_id, id),
  INDEX idx_income_instances_updated (household_id, updated_at_server),
  INDEX idx_income_instances_deleted (household_id, deleted_at_server),
  CONSTRAINT fk_income_instance_source FOREIGN KEY (household_id, source_id) REFERENCES income_sources(household_id, id) ON DELETE CASCADE
);
