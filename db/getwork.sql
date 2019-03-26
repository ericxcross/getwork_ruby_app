DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS leads;
DROP TABLE IF EXISTS companies;


SET TIME ZONE 'Europe/London';

CREATE TABLE companies (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  industry VARCHAR(255),
  contact TEXT,
  summary TEXT
);

CREATE TABLE status (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(7)
);

CREATE TABLE leads (
  id SERIAL4 PRIMARY KEY,
  company_id INT4 REFERENCES companies(id) ON DELETE CASCADE,
  last_updated DATE,

  name VARCHAR(255),
  link VARCHAR(255),
  summary TEXT
);

CREATE TABLE actions (
  id SERIAL4 PRIMARY KEY,
  status_id INT4 REFERENCES status(id),
  lead_id INT4 REFERENCES leads(id),
  due_date DATE,
  summary TEXT,
  completed BOOLEAN DEFAULT false
);
