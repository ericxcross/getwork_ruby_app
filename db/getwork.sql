DROP TABLE IF EXISTS leads;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS actions;
DROP TABLE IF EXISTS status;

CREATE TABLE status (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  color VARCHAR(7)
);

CREATE TABLE actions (
  id SERIAL4 PRIMARY KEY,
  status_id INT4 REFERENCES status(id),
  due_date DATE,
  summary TEXT,
);

CREATE TABLE companies (
  id SERIAL4 PRIMARY KEY,
  date_added timestamptz NOT NULL DEFAULT now(),
  last_updated timestamptz NOT NULL ON UPDATE now(),

  name VARCHAR(255) NOT NULL,
  industry VARCHAR(255),
  contact TEXT,
  info TEXT
);

CREATE TABLE leads (
  id SERIAL4 PRIMARY KEY,
  company_id INT4 REFERENCES companies(id) ON DELETE CASCADE,
  action_id INT4 REFERENCES action(id),
  date_added timestamptz NOT NULL DEFAULT now(),
  last_updated timestamptz NOT NULL ON UPDATE now(),

  name VARCHAR(255),
  link VARCHAR(255),
  summary TEXT,
  comments TEXT
);

SET TIME ZONE 'Europe/London';
