DROP TABLE IF EXISTS leads;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS status;

CREATE TABLE status (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(7)
);

CREATE TABLE companies (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  date_added timestamptz NOT NULL DEFAULT now(),
  industry VARCHAR(255),
  contact TEXT
);

CREATE TABLE leads (
  id SERIAL4 PRIMARY KEY,
  company_id INT4 REFERENCES companies(id) ON DELETE CASCADE,
  status_id INT4 REFERENCES status(id),
  date_added timestamptz NOT NULL DEFAULT now(),
  name VARCHAR(255),
  link VARCHAR(255),
  summary TEXT,
  comments TEXT
);

SET TIME ZONE 'Europe/London';
