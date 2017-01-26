ALTER TABLE `400001_personal`.promises DROP FOREIGN KEY promises_ibfk_1;
ALTER TABLE `400001_personal`.promises DROP FOREIGN KEY promises_ibfk_2;
ALTER TABLE `400001_personal`.categories DROP FOREIGN KEY categories_ibfk_1;
ALTER TABLE `400001_personal`.accounts DROP FOREIGN KEY accounts_ibfk_1;
DROP TABLE `400001_personal`.promises;
DROP TABLE `400001_personal`.categories;
DROP TABLE `400001_personal`.accounts;
DROP TABLE `400001_personal`.budgets;
DROP TABLE `400001_personal`.banks;
CREATE TABLE budgets (
  id         INT          NOT NULL AUTO_INCREMENT,
  name       VARCHAR(250) NOT NULL,
  percentage DOUBLE(5, 2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY unique_budget (name)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
CREATE TABLE banks (
  id   INT          NOT NULL AUTO_INCREMENT,
  name VARCHAR(250) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY unique_banks (name)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
CREATE TABLE categories (
  id         INT          NOT NULL AUTO_INCREMENT,
  budget_id  INT          NOT NULL,
  name       VARCHAR(250) NOT NULL,
  percentage DOUBLE(5, 2) NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY unique_category (name),
  INDEX budget_idx (budget_id),
  FOREIGN KEY (budget_id)
  REFERENCES budgets (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
CREATE TABLE accounts (
  id      INT          NOT NULL AUTO_INCREMENT,
  bank_id INT          NOT NULL,
  name    VARCHAR(250) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY unique_account (name),
  INDEX bank_idx (bank_id),
  FOREIGN KEY (bank_id)
  REFERENCES banks (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;
CREATE TABLE promises (
  id          INT NOT NULL  AUTO_INCREMENT,
  account_id  INT NOT NULL,
  category_id INT NOT NULL,
  fortnight   TINYINT,
  amount      DOUBLE(10, 2) DEFAULT 0,
  detail      VARCHAR(250),
  PRIMARY KEY (id),
  INDEX account_idx (account_id),
  FOREIGN KEY (account_id)
  REFERENCES accounts (id),
  INDEX category_idx (category_id),
  FOREIGN KEY (category_id)
  REFERENCES categories (id)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8;

INSERT INTO budgets (name, percentage) VALUES
  ('Consumos', 25),
  ('Deuda', 20),
  ('Diversion', 8),
  ('Impuestos', 16),
  ('Otros', 6),
  ('Proyecto', 25);

INSERT INTO banks (name) VALUES
  ('Santander'),
  ('Banorte'),
  ('HSBC'),
  ('Invex'),
  ('Banamex'),
  ('OAFondos'),
  ('Actinver');

INSERT INTO categories (budget_id, name, percentage) VALUES
  (1, 'Agua', 0.30),
  (1, 'Comida', 5.00),
  (1, 'Comunicaciones', 0.75),
  (1, 'Gas', 0.75),
  (1, 'Luz', 0.20),
  (1, 'Renta', 15.50),
  (1, 'Transporte', 2.50),
  (2, 'Deudas', 25.00),
  (3, 'Diversión', 4.50),
  (4, 'IVA', 3.00),
  (5, 'Otros', 6.00),
  (6, 'Ahorro', 10.00),
  (6, 'Retiro', 10.00),
  (6, 'Salud', 10.00),
  (6, 'Seguros', 3.00),
  (6, 'Educación', 3.50);

INSERT INTO accounts (bank_id, name) VALUES
  (7, 'Personal-A'),
  (5, 'Clásica-494'),
  (5, 'Inversión'),
  (5, 'Oro-395'),
  (5, 'Perfiles-134'),
  (5, 'Platino-992'),
  (2, 'GFNT-MD SERIE F 0'),
  (2, 'GFNT-MD SERIE F4 0'),
  (2, 'Enlace-6784'),
  (2, 'Nomina-677'),
  (3, 'Fondo-D2 BFS'),
  (3, 'Nomina-391'),
  (3, 'TC-3306'),
  (6, 'Familiar'),
  (6, 'Personal-OA'),
  (1, 'Free-3998'),
  (1, 'Nomina-308');

INSERT INTO promises (account_id, category_id, fortnight, amount, detail) VALUES
  (3, 1, NULL, 102.92, NULL),
  (1, 13, NULL, 200.00, NULL),
  (14, 12, NULL, 2000.00, 'Proyecto Francia'),
  (3, 12, NULL, 500.00, 'Emergencias Al instante'),
  (7, 12, NULL, 200.00, 'Personal'),
  (8, 12, NULL, 200.00, 'Personal'),
  (11, 12, NULL, 500.00, 'Emergencias 24hrs'),
  (15, 13, NULL, 200.00, NULL),
  (6, 2, NULL, NULL, NULL),
  (4, 3, 2, 240.00, 'Telcel'),
  (4, 8, 2, 1354.00, 'Celular Roxanna (MotoG)'),
  (6, 8, 2, 222.17, 'Celular Henry'),
  (6, 8, 2, 262.42, 'Celular Roxanna (ZTE)'),
  (6, 8, 2, 605.01, 'PPP'),
  (4, 9, 2, 333.00, 'Cine'),
  (16, 9, 2, 99.00, 'Netflix'),
  (12, 16, NULL, 800.00, 'Frances'),
  (3, 4, NULL, 254.52, NULL),
  (5, 10, 2, 63.80, NULL),
  (6, 10, 2, 928.00, 'Contador'),
  (3, 5, NULL, 51.00, NULL),
  (6, 8, 2, 300.00, 'Collar'),
  (6, 11, 2, 1610.90, 'RaspBerrys'),
  (17, 6, 2, 5250.00, NULL),
  (10, 13, 2, 1150.00, 'IMSS'),
  (10, 14, 2, 1150.00, 'IMSS'),
  (2, 15, 2, 150.00, 'Libra plus'),
  (4, 15, 2, 150.00, 'Libra plus'),
  (9, 15, 2, 81.20, 'Seguro de Vida'),
  (13, 15, 1, 110.20, 'Asistencia premium'),
  (13, 15, 1, 122.36, 'Seguro de vida'),
  (16, 15, 2, 95.83, 'Seguro'),
  (12, 7, 1, 630.00, 'Camiones'),
  (13, 7, 1, NULL, 'Uber');

CREATE VIEW resume_q AS
  SELECT
    category_id,
    account_id,
    SUM(IF(fortnight = 1, amount, IF(fortnight IS NULL, amount / 2, 0))) AS Q1,
    SUM(IF(fortnight = 2, amount, IF(fortnight IS NULL, amount / 2, 0))) AS Q2
  FROM promises
  GROUP BY account_id, category_id;


CREATE VIEW used_in_categories AS
  SELECT
    categories.budget_id,
    SUM(IFNULL(amount,0)) AS per_month
  FROM promises
    LEFT JOIN categories ON promises.category_id = categories.id
  GROUP BY categories.budget_id;

CREATE VIEW categories_pond AS
SELECT
  used_in_categories.budget_id,
  per_month / (percentage / 100) AS budget_max
FROM used_in_categories
  LEFT JOIN budgets ON used_in_categories.budget_id = id;

CREATE VIEW bank_percentages AS
SELECT accounts.bank_id,
  SUM(IF(fortnight = 1, IFNULL(amount/budget_max,0), IF(fortnight IS NULL, IFNULL(amount/budget_max,0) / 2, 0))) AS Q1,
  SUM(IF(fortnight = 2, IFNULL(amount/budget_max,0), IF(fortnight IS NULL, IFNULL(amount/budget_max,0) / 2, 0))) AS Q2
FROM promises
  LEFT JOIN categories ON promises.category_id = categories.id
  LEFT JOIN categories_pond ON categories_pond.budget_id = categories.budget_id
LEFT JOIN accounts ON accounts.id = promises.account_id
LEFT JOIN banks ON banks.id = accounts.bank_id
GROUP BY accounts.bank_id;

SELECT banks.name, Q1,Q2
FROM banks
LEFT JOIN bank_percentages ON banks.id=bank_id
