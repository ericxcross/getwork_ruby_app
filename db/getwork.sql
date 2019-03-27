DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS leads;

SET TIME ZONE 'Europe/London';

-- MVP
CREATE TABLE status (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(255),
  archive BOOLEAN
);

CREATE TABLE leads (
  id SERIAL4 PRIMARY KEY,
  company_name VARCHAR(255),
  last_updated TIMESTAMPTZ,

  name VARCHAR(255),
  link VARCHAR(255),
  summary TEXT,
  archive BOOLEAN DEFAULT false
);

CREATE TABLE actions (
  id SERIAL4 PRIMARY KEY,
  status_id INT4 REFERENCES status(id),
  lead_id INT4 REFERENCES leads(id) ON DELETE CASCADE,
  date_completed TIMESTAMPTZ,
  summary TEXT,
  completed BOOLEAN DEFAULT false
);
