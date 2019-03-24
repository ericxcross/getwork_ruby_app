DROP TABLE IF EXISTS lead;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS status;

CREATE TABLE status (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

CREATE TABLE company (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  industry VARCHAR(255),
  contact_details TEXT
);

CREATE TABLE lead (
  id SERIAL4 PRIMARY KEY,
  company_id INT4 REFERENCES company(id) ON DELETE CASCADE,
  status_id INT4 REFERENCES status(id),
  date_added timestamptz NOT NULL DEFAULT now(),
  name VARCHAR(255),
  url VARCHAR(255),
  summary TEXT,
  application_details TEXT
);

SET TIME ZONE 'Europe/London';
