DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `id`             INT(10) UNSIGNED        NOT NULL AUTO_INCREMENT,
  `nick`           VARCHAR(255)
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Sub-dominio',
  `implementation` VARCHAR(255)
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Nombre del tipo de Implementación',
  `created_at`     TIMESTAMP               NULL     DEFAULT NULL,
  `updated_at`     TIMESTAMP               NULL     DEFAULT NULL,
  `deleted_at`     TIMESTAMP               NULL     DEFAULT NULL,
  `full_name`      VARCHAR(255)
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Nombre completo de la institución',
  `code`           VARCHAR(255)
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Numero/Código de cliente',
  `short_name`     VARCHAR(255)
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Nombre corto de la escuela',
  `contact`        TEXT
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Datos de contacto',
  `contract`       TEXT
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Datos de contrato',
  `billing`        TEXT
                   COLLATE utf8_unicode_ci NOT NULL
  COMMENT 'Configuración de facturación',
  `config`         TEXT
                   COLLATE utf8_unicode_ci COMMENT 'Configuración de general',
  `database`       TEXT
                   COLLATE utf8_unicode_ci COMMENT 'Configuración de base de datos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_nick_unique` (`nick`),
  KEY `customers_nick_index` (`nick`),
  KEY `customers_implementation_index` (`implementation`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  COMMENT = 'Definición de instalaciones/clientes';



SELECT groups.name, permissions.name
FROM groups
LEFT JOIN group_permission ON groups.id = group_permission.group_id
LEFT JOIN permissions ON permissions.id = group_permission.permission_id
WHERE groups.id =  11;


ALTER TABLE invoices AUTO_INCREMENT = 25;
