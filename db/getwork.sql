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
  industry VARCHAR(255),
  contact_details TEXT
);

CREATE TABLE leads (
  id SERIAL4 PRIMARY KEY,
  company_id INT4 REFERENCES companies(id) ON DELETE CASCADE,
  status_id INT4 REFERENCES status(id),
  date_added timestamptz NOT NULL DEFAULT now(),
  name VARCHAR(255),
  url VARCHAR(255),
  summary TEXT,
  application_details TEXT
);

SET TIME ZONE 'Europe/London';
