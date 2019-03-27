DROP TABLE IF EXISTS actions_log;
DROP TABLE IF EXISTS leads;
DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS status;

SET TIME ZONE 'Europe/London';

-- MVP
CREATE TABLE status (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(255)
);

CREATE TABLE actions (
  id SERIAL4 PRIMARY KEY,
  status_id INT4 REFERENCES status(id),
  due_date DATE,
  summary TEXT
);

CREATE TABLE leads (
  id SERIAL4 PRIMARY KEY,
  company_name VARCHAR(255),
  action_id INT4 REFERENCES actions(id),
  last_updated DATE,

  name VARCHAR(255),
  link VARCHAR(255),
  summary TEXT
);

CREATE TABLE actions_log (
  id SERIAL4 PRIMARY KEY,
  status_id INT4 REFERENCES status(id),
  lead_id INT4 REFERENCES leads(id),
  date_completed DATE,
  summary TEXT
);
