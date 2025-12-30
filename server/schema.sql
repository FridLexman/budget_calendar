CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  color VARCHAR(32),
  icon VARCHAR(64),
  sort_order INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS bill_templates (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  category VARCHAR(255),
  default_amount_cents INT NOT NULL,
  start_date DATE,
  active TINYINT(1) DEFAULT 1,
  recurrence_rule TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bill_instances (
  id INT AUTO_INCREMENT PRIMARY KEY,
  template_id INT NULL,
  title_snapshot VARCHAR(255) NOT NULL,
  amount_cents INT NOT NULL,
  due_date DATE NOT NULL,
  status VARCHAR(32) DEFAULT 'scheduled',
  paid_amount_cents INT NULL,
  paid_at DATETIME NULL,
  notes TEXT,
  category VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX (template_id),
  CONSTRAINT fk_bill_template FOREIGN KEY (template_id) REFERENCES bill_templates(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS income_sources (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  amount_cents INT NOT NULL,
  frequency VARCHAR(32) NOT NULL,
  start_date DATE,
  anchor_date DATE,
  active TINYINT(1) DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS income_instances (
  id INT AUTO_INCREMENT PRIMARY KEY,
  source_id INT NULL,
  title_snapshot VARCHAR(255) NOT NULL,
  amount_cents INT NOT NULL,
  date DATE NOT NULL,
  status VARCHAR(32) DEFAULT 'expected',
  received_at DATETIME NULL,
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  INDEX (source_id),
  CONSTRAINT fk_income_source FOREIGN KEY (source_id) REFERENCES income_sources(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS sync_settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  use_remote TINYINT(1) DEFAULT 0,
  base_url VARCHAR(512),
  api_key VARCHAR(512),
  mode VARCHAR(32) DEFAULT 'local_only',
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
