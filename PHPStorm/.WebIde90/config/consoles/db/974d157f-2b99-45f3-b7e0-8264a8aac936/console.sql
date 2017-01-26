SELECT version();
SELECT *
FROM information_schema.tables;
SELECT UPDATE_TIME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'dbname' AND TABLE_NAME = 'tabname';
;
SELECT UPDATE_TIME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'users';
UPDATE information_schema.tables
SET UPDATE_TIME = NOW()
WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'users';
SHOW TABLE STATUS;
SHOW TABLES;
SELECT *
FROM information_schema.STATISTICS;
SELECT DISTINCT
  TABLE_SCHEMA,
  TABLE_NAME
FROM
  information_schema.TABLES
WHERE UPDATE_TIME IS NOT NULL
      AND
      UPDATE_TIME > NOW() - INTERVAL 7 DAY
      AND
      TABLE_SCHEMA <> 'information_schema';

SELECT *
FROM information_schema.innodb_table_stats;
SHOW TABLES FROM information_schema;
SELECT *
FROM information_schema.TABLE_STATISTICS;
# INSERT INTO las_updates (table_name)
SELECT *
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking';

SELECT NOW();
SELECT
  @@global.time_zone,
  @@session.time_zone;

SELECT
  @@global.time_zone,
  @@session.time_zone;

DROP VIEW users_view;
CREATE VIEW users_view AS
  SELECT
    id,
    concat_ws(' ', email, '(Validado)') AS email,
    created_at,
    updated_at,
    deleted_at,
    last_login,
    password,
    first_name,
    last_name,
    permissions
  FROM users;

SELECT *
FROM activations
LEFT JOIN users ON users.id=activations.user_id;


ALTER TABLE mutagenos ADD `sortOrder` INT(3) DEFAULT 0 NOT NULL;
