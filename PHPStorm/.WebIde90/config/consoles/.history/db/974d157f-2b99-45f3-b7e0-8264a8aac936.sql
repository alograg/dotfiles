SELECT version()
;-- -. . -..- - / . -. - .-. -.--
SELECT UPDATE_TIME FROM information_schema.tables WHERE TABLE_SCHEMA = 'throttle' AND TABLE_NAME = 'throttle'
;-- -. . -..- - / . -. - .-. -.--
SELECT UPDATE_TIME FROM information_schema.tables WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'throttle'
;-- -. . -..- - / . -. - .-. -.--
SELECT UPDATE_TIME FROM information_schema.tables WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'users'
;-- -. . -..- - / . -. - .-. -.--
SELECT UPDATE_TIME FROM information_schema.tables
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM information_schema.tables
;-- -. . -..- - / . -. - .-. -.--
SELECT UPDATE_TIME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'users'
;-- -. . -..- - / . -. - .-. -.--
UPDATE information_schema.tables SET UPDATE_TIME=NOW()
WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'users'
;-- -. . -..- - / . -. - .-. -.--
SHOW TABLE STATUS
;-- -. . -..- - / . -. - .-. -.--
SHOW TABLES
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.STATISTICS
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT TABLE_SCHEMA , TABLE_NAME
FROM
  information_schema.TABLES
WHERE UPDATE_TIME IS NOT NULL
      AND
      UPDATE_TIME > NOW() - INTERVAL 7 DAY
      AND
      TABLE_SCHEMA  <> 'information_schema'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.innodb_table_stats
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.INNODB_METRICS
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.INNODB_SYS_TABLES
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.INNODB_SYS_TABLESTATS
;-- -. . -..- - / . -. - .-. -.--
SHOW TABLES FROM information_schema
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.TABLE_STATISTICS
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking' AND TABLE_NAME = 'users'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
SELECT TABLE_NAME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO las_updates ('table_name')
SELECT TABLE_NAME
FROM information_schema.tables
WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO las_updates ('table_name') VALUES
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO las_updates (table_name) VALUES
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO las_updates (table_name)
  SELECT TABLE_NAME
  FROM information_schema.tables
  WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
SELECT TABLE_NAME
  FROM information_schema.tables
  WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
SELECT 
  FROM information_schema.tables
  WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM information_schema.tables
  WHERE TABLE_SCHEMA = 'thinking'
;-- -. . -..- - / . -. - .-. -.--
SELECT time
;-- -. . -..- - / . -. - .-. -.--
SELECT getDate()
;-- -. . -..- - / . -. - .-. -.--
SELECT GETDATE()
;-- -. . -..- - / . -. - .-. -.--
SELECT CURRENT_TIME
;-- -. . -..- - / . -. - .-. -.--
SELECT NOW()
;-- -. . -..- - / . -. - .-. -.--
SELECT @@global.time_zone, @@session.time_zone
;-- -. . -..- - / . -. - .-. -.--
SELECT
    concat_ws(' ', email, '(Validado)') AS email,
    created_at,
    updated_at,
    deleted_at,
    last_login,
    password,
    first_name,
    last_name,
    permissions
  FROM users
;-- -. . -..- - / . -. - .-. -.--
CREATE VIEW users_view AS
  SELECT
    concat_ws(' ', email, '(Validado)') AS email,
    created_at,
    updated_at,
    deleted_at,
    last_login,
    password,
    first_name,
    last_name,
    permissions
  FROM users
;-- -. . -..- - / . -. - .-. -.--
DROP VIEW users_view
;-- -. . -..- - / . -. - .-. -.--
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
  FROM users
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM users
LEFT JOIN activations ON id=user_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM users
LEFT JOIN activations ON users.id=activations.user_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM activations
LEFT JOIN users ON users.id=activations.user_id
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE mutagenos ADD `sortOrder` INT(3) DEFAULT 0 NOT NULL