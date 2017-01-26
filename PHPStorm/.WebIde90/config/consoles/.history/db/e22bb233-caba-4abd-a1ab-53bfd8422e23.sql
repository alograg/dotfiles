SELECT DISTINCT
  messages.id,
  student_registration.student_id AS person_id,
  student_registration.student_id,
  messages.only_new_entry,
  messages.from,
  messages.transcribed_by,
  messages.type,
  messages.signature_required,
  messages.notifications,
  messages.created_at,
  messages.updated_at,
  messages.deleted_at,
  messages.start_at,
  messages.remember_at,
  messages.end_at,
  messages.subtype,
  messages.subject,
  messages.message,
  messages.data
FROM student_registration
  LEFT JOIN messages ON (target_type = 'Orama\\Models\\People' AND student_id = target_id)
                        OR (target_type = 'Orama\\Models\\SchoolStructure' AND
                            FIND_IN_SET(target_id, CONCAT_WS(',',
                                                             schoolyear_id,
                                                             site_id,
                                                             level_id,
                                                             degree_id,
                                                             group_id)))
WHERE now() BETWEEN IFNULL(messages.start_at, messages.created_at)
      AND IFNULL(messages.end_at, adddate(now(), 1))
      AND messages.deleted_at IS NULL
      AND messages.id IS NOT NULL
      AND messages.only_new_entry = IFNULL(students_inscriptions.tuition_type='inscription', 0)
  HAVING student_id IN (2168,
  2169,
  2771,
  3166)
ORDER BY student_id, IFNULL(messages.start_at, messages.created_at) DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  messages.id,
  student_registration.student_id AS person_id,
  student_registration.student_id,
  messages.only_new_entry,
  messages.from,
  messages.transcribed_by,
  messages.type,
  messages.signature_required,
  messages.notifications,
  messages.created_at,
  messages.updated_at,
  messages.deleted_at,
  messages.start_at,
  messages.remember_at,
  messages.end_at,
  messages.subtype,
  messages.subject,
  messages.message,
  messages.data
FROM student_registration
  LEFT JOIN messages ON (target_type = 'Orama\\Models\\People' AND student_id = target_id)
                        OR (target_type = 'Orama\\Models\\SchoolStructure' AND
                            FIND_IN_SET(target_id, CONCAT_WS(',',
                                                             schoolyear_id,
                                                             site_id,
                                                             level_id,
                                                             degree_id,
                                                             group_id)))
WHERE now() BETWEEN IFNULL(messages.start_at, messages.created_at)
      AND IFNULL(messages.end_at, adddate(now(), 1))
      AND messages.deleted_at IS NULL
      AND messages.id IS NOT NULL
  HAVING student_id IN (2168,
  2169,
  2771,
  3166)
ORDER BY student_id, IFNULL(messages.start_at, messages.created_at) DESC
;-- -. . -..- - / . -. - .-. -.--
CREATE OR REPLACE VIEW oramalocal.students_inscriptions AS
  SELECT
    `student_registration`.*,
    `student_tuition_detail`.`tuition_type`  AS `tuition_type`
  FROM (`oramalocal`.`student_registration`
    LEFT JOIN `oramalocal`.`student_tuition_detail`
      ON (((`student_registration`.`student_id` = `student_tuition_detail`.`student_id`) AND
           (`student_registration`.`schoolyear_id` = `student_tuition_detail`.`schoolyear_id`))))
  WHERE (`student_tuition_detail`.`tuition_type` = 'inscription')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id) AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)        AS schoolyear_id,
  MAX(student_payment_detail.degree_id)            AS degree_id,
  MAX(student_payment_detail.group_id)             AS group_id,
  MAX(student_payment_detail.type)                 AS type,
  MAX(student_payment_detail.tuition_id)           AS tuition_id,
  MAX(student_payment_detail.payment_index)        AS payment_index,
  MAX(student_payment_detail.payment_time)         AS payment_time,
  MAX(student_payment_detail.expected_at)          AS expected_at,
  MAX(student_payment_detail.student_tuition_id)   AS student_tuition_id,
  MAX(student_payment_detail.payment_id)           AS payment_id,
  MAX(student_payment_detail.invoice_id)           AS invoice_id,
  MAX(student_payment_detail.id)                   AS id,
  MAX(student_payment_detail.created_at)           AS created_at,
  MAX(student_payment_detail.updated_at)           AS updated_at,
  MAX(student_payment_detail.deleted_at)           AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at) AS expected_at,
  SUM(student_payment_detail.amount)               AS amount
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN ? AND ?
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
LIMIT 100
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id) AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)        AS schoolyear_id,
  MAX(student_payment_detail.degree_id)            AS degree_id,
  MAX(student_payment_detail.group_id)             AS group_id,
  MAX(student_payment_detail.type)                 AS type,
  MAX(student_payment_detail.tuition_id)           AS tuition_id,
  MAX(student_payment_detail.payment_index)        AS payment_index,
  MAX(student_payment_detail.payment_time)         AS payment_time,
  MAX(student_payment_detail.expected_at)          AS expected_at,
  MAX(student_payment_detail.student_tuition_id)   AS student_tuition_id,
  MAX(student_payment_detail.payment_id)           AS payment_id,
  MAX(student_payment_detail.invoice_id)           AS invoice_id,
  MAX(student_payment_detail.id)                   AS id,
  MAX(student_payment_detail.created_at)           AS created_at,
  MAX(student_payment_detail.updated_at)           AS updated_at,
  MAX(student_payment_detail.deleted_at)           AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at) AS expected_at,
  SUM(student_payment_detail.amount)               AS amount
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN ? AND ?
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
LIMIT 100
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
`payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id) AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)        AS schoolyear_id,
  MAX(student_payment_detail.degree_id)            AS degree_id,
  MAX(student_payment_detail.group_id)             AS group_id,
  MAX(student_payment_detail.type)                 AS type,
  MAX(student_payment_detail.tuition_id)           AS tuition_id,
  MAX(student_payment_detail.payment_index)        AS payment_index,
  MAX(student_payment_detail.payment_time)         AS payment_time,
  MAX(student_payment_detail.expected_at)          AS expected_at,
  MAX(student_payment_detail.student_tuition_id)   AS student_tuition_id,
  MAX(student_payment_detail.payment_id)           AS payment_id,
  MAX(student_payment_detail.invoice_id)           AS invoice_id,
  MAX(student_payment_detail.id)                   AS id,
  MAX(student_payment_detail.created_at)           AS created_at,
  MAX(student_payment_detail.updated_at)           AS updated_at,
  MAX(student_payment_detail.deleted_at)           AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at) AS expected_at,
  SUM(student_payment_detail.amount)               AS amount
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016' AND '2016'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
LIMIT 100
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
`payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id) AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)        AS schoolyear_id,
  MAX(student_payment_detail.degree_id)            AS degree_id,
  MAX(student_payment_detail.group_id)             AS group_id,
  MAX(student_payment_detail.type)                 AS type,
  MAX(student_payment_detail.tuition_id)           AS tuition_id,
  MAX(student_payment_detail.payment_index)        AS payment_index,
  MAX(student_payment_detail.payment_time)         AS payment_time,
  MAX(student_payment_detail.expected_at)          AS expected_at,
  MAX(student_payment_detail.student_tuition_id)   AS student_tuition_id,
  MAX(student_payment_detail.payment_id)           AS payment_id,
  MAX(student_payment_detail.invoice_id)           AS invoice_id,
  MAX(student_payment_detail.id)                   AS id,
  MAX(student_payment_detail.created_at)           AS created_at,
  MAX(student_payment_detail.updated_at)           AS updated_at,
  MAX(student_payment_detail.deleted_at)           AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at) AS expected_at,
  SUM(student_payment_detail.amount)               AS amount
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016' AND '2016'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
`payment_id` ASC, `type` ASC, `payment_index` ASC
LIMIT 100
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN ? AND ?
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016' AND '2016'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-01-16' AND '2016-06-17'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-01-17' AND '2016-06-18'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-01-17 00:00:00' AND '2016-06-18 00:00:00'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-01-17 00:00:00' AND '2016-06-18 00:00:00'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` > '2016-01-17'
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE incoice_id > 48900
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE invoices.id > 48900
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE student_payment_detail.invoice_id > 48900
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  payments.type,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE student_payment_detail.invoice_id > 4800
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.people_id NOT IN (
  SELECT DISTINCT student_id
  FROM student_tuitions
  WHERE tuition_id IN (
    SELECT id
    FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
    WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
  )
)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT student_id
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
  WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
  SELECT DISTINCT student_id
  FROM student_tuitions
  WHERE tuition_id IN (
    SELECT id
    FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
    WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
  )
)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT *
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
  WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT *
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
  WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
  AND tuitions.type = 'tuition'
)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
  
WHERE heritages.ancestor = 34 OR tuitions.structure_id = 34
                                 AND tuitions.type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
  
WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
                                 AND tuitions.type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT *
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
  WHERE( heritages.ancestor = 34 OR tuitions.structure_id = 34)
  AND tuitions.type = 'tuition'
)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
  SELECT DISTINCT student_id
  FROM student_tuitions
  WHERE tuition_id IN (
    SELECT id
    FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
    WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
          AND tuitions.type = 'tuition'
  )
)
AND registrations.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id

WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
                                 AND tuitions.type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id

WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
  SELECT DISTINCT student_id
  FROM student_tuitions
  WHERE tuition_id IN (
    SELECT id
    FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
    WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
          AND tuitions.type = 'tuition'
  )
)
AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
  SELECT DISTINCT student_id
  FROM student_tuitions
  WHERE tuition_id IN (
    SELECT id
    FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id=heritages.structure_id
    WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
          AND tuitions.type = 'tuition'
  )
)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT *
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
  WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
        AND tuitions.type = 'tuition'
)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT student_id, *
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
  WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
        AND tuitions.type = 'tuition'
)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
    SELECT DISTINCT student_id
    FROM student_tuitions
    WHERE tuition_id IN (
      SELECT id
      FROM tuitions
        LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
      WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
            AND tuitions.type = 'tuition'
    )
  )
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT student_id, student_tuitions.*
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
  WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
        AND tuitions.type = 'tuition'
)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM heritages
WHERE heritages.ancestor = 34
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT student_tuitions.student_id, student_tuitions.*
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
  WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
        AND tuitions.type = 'tuition'
)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT student_tuitions.student_id, student_tuitions.*
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
  WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
        AND tuitions.type = 'tuition'
)
GROUP BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT student_tuitions.student_id, student_tuitions.*
FROM student_tuitions
WHERE tuition_id IN (
  SELECT id
  FROM tuitions
    LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
  WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
        AND tuitions.type = 'tuition'
)
GROUP BY student_tuitions.student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
      AND tuitions.type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM tuitions
  LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
    SELECT DISTINCT student_tuitions.student_id
    FROM student_tuitions
    WHERE tuition_id IN (
      SELECT id
      FROM tuitions
        LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
      WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
            AND tuitions.type = 'tuition'
    )
    GROUP BY student_tuitions.student_id
  )
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
WHERE
  student_registration.schoolyear_id = 34 AND
  student_registration.student_id NOT IN (
    SELECT DISTINCT student_tuitions.student_id
    FROM student_tuitions
    WHERE tuition_id IN (
      SELECT id
      FROM tuitions
        LEFT JOIN heritages ON tuitions.structure_id = heritages.structure_id
      WHERE (heritages.ancestor = 34 OR tuitions.structure_id = 34)
            AND tuitions.type = 'tuition'
    )
    GROUP BY student_tuitions.student_id
  )
AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.`level_id`,
  `student_registration`.`student_id`,
  `specific_amounts`,
  `student_scholarships`.`id` AS `scholarship_id`,
  `percentage`
FROM `student_registration`
  INNER JOIN `full_heritage`
    ON `student_registration`.`schoolyear_id` = `full_heritage`.`structure_id`
  LEFT JOIN `student_scholarships`
    ON `student_registration`.`people_id` = `student_scholarships`.`student_id` AND
       `student_registration`.`schoolyear_id` = `student_scholarships`.`schoolyear_id`
WHERE (FIND_IN_SET(274, full_heritage.sons) OR `full_heritage`.`structure_id` = 274) AND
      `student_registration`.`student_id` IN (2583,
                                              2630,
                                              2631,
                                              2634,
                                              3163)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  group_student.student_id,
  teacher_criteria.id                                                   AS evaluation_id,
  `group_teacher`.`teacher_id`,
  IFNULL(teacher_criteria.subject_id, group_teacher.subject_id)         AS subject_id,
  `group_student`.`group_id`,
  `teacher_criteria`.`criteria_id`,
  `teacher_criteria`.`concepts`,
  CONCAT_WS('_', group_student.student_id, teacher_criteria.subject_id) AS student_subject
FROM `group_student`
  LEFT JOIN `group_teacher` ON `group_student`.`group_id` = `group_teacher`.`group_id`
  LEFT JOIN `heritages` ON `group_student`.`group_id` = `heritages`.`structure_id`
  LEFT JOIN `teacher_criteria` ON `group_teacher`.`teacher_id` = `teacher_criteria`.`teacher_id` AND
                                  `group_student`.`group_id` = `teacher_criteria`.`group_id` AND
                                  group_teacher.teacher_id = teacher_criteria.teacher_id
                                  AND group_student.group_id = teacher_criteria.group_id
                                  AND IF(group_teacher.subject_id,
                                         group_teacher.subject_id = group_teacher.subject_id, TRUE)
                                      = TRUE
WHERE `group_student`.`student_id` IN
      (
        2634,
        3389,
        2609,
        2888,
        2756,
        2967,
        2685,
        2957,
        2872,
        2867,
        2633,
        3397,
        2627,
        2688,
        3057,
        3382,
        3063,
        3070,
        4545,
        2870,
        3237,
        2598,
        2879,
        2608,
        3224,
        4477,
        4008,
        2769
      ) AND
      `heritages`.`ancestor` IN (34)
ORDER BY `student_id` ASC
;-- -. . -..- - / . -. - .-. -.--
CREATE PROCEDURE getStudentsTuitions(IN _structure_id INT )
  BEGIN
    SELECT
      student_scholarships.student_id,
      registrations.degree_id,
      degreeTuitions.id,
      degreeTuitions.config,
      degreeTuitions.type,
      student_scholarships.specific_amounts,
      student_scholarships.percentage,
      student_scholarships.comment
    FROM student_scholarships
      LEFT JOIN registrations ON student_scholarships.student_id = registrations.student_id
      LEFT JOIN (
                  SELECT *
                  FROM structure_tuitions
                  WHERE  ancestor = _structure_id OR structure_id = _structure_id
                ) AS degreeTuitions ON registrations.degree_id = degreeTuitions.decendants
                                       OR registrations.degree_id = degreeTuitions.ancestor
    GROUP BY student_scholarships.student_id, degreeTuitions.id
    HAVING config IS NOT NULL;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.school_enrollment                                            AS 'Matricula',
  CONCAT(people.first_name, ' ', people.second_name, ' ', people.names) AS 'Nombre Completo',
  sl.name                                                               AS 'Nivel',
  deg.name                                                              AS 'Grado',
  camp.name                                                             AS 'Campus',
  student_registration.status,
  student_tuitions.tuition_id,
  students.enrollment_at
FROM student_registration
  JOIN students ON students.people_id = student_registration.people_id
  JOIN school_structures sl ON sl.id = student_registration.level_id
  JOIN school_structures camp ON camp.id = student_registration.site_id
  JOIN school_structures deg ON deg.id = student_registration.degree_id
  JOIN people ON people.id = students.people_id
  JOIN student_tuitions ON students.people_id = student_tuitions.student_id
WHERE student_registration.schoolyear_id IN (198, 288) AND
      student_tuitions.tuition_id IN (40, 43, 46, 49, 52, 55, 58, 61, 66, 67) AND
      student_registration.status IN ('Admitido', 'Activo')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.school_enrollment                                            AS 'Matricula',
  CONCAT(people.first_name, ' ', people.second_name, ' ', people.names) AS 'Nombre Completo',
  sl.name                                                               AS 'Nivel',
  deg.name                                                              AS 'Grado',
  camp.name                                                             AS 'Campus',
  student_registration.status,
  students.enrollment_at
FROM student_registration
  JOIN students ON students.people_id = student_registration.people_id
  JOIN school_structures sl ON sl.id = student_registration.level_id
  JOIN school_structures camp ON camp.id = student_registration.site_id
  JOIN school_structures deg ON deg.id = student_registration.degree_id
  JOIN people ON people.id = students.people_id
  JOIN student_tuitions ON students.people_id = student_tuitions.student_id
WHERE student_registration.schoolyear_id IN (198, 288) AND
      student_tuitions.tuition_id IN (40, 43, 46, 49, 52, 55, 58, 61, 66, 67) AND
      student_registration.status IN ('Admitido', 'Activo')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  camp.name                                                           AS 'Campus',
  deg.name                                                            AS 'Grado',
  deg.order,
  sl.name                                                             AS 'Nivel',
  sl.order,
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción'
FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE `type` = 'inscription') AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `camp`.`name` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT `id`
FROM `tuitions`
WHERE `type` = 'inscription'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  camp.name                                                           AS 'Campus',
  sl.name                                                             AS 'Nivel',
  sl.order,
  deg.name                                                            AS 'Grado',
  deg.order,
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción'
FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE `type` = 'inscription') AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `camp`.`name` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  camp.name                                                           AS 'Campus',
  sl.name                                                             AS 'Nivel',
  sl.id,
  deg.name                                                            AS 'Grado',
  deg.order,
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción'
FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE `type` = 'inscription') AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `camp`.`name` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  camp.name                                                           AS 'Campus',
  sl.name                                                             AS 'Nivel',
  sl.id,
  deg.name                                                            AS 'Grado',
  deg.order,
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción'
FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE `type` = 'inscription') AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `camp`.`name` ASC, sl.id ASC, deg.order ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  scy.name                                                            AS 'Ciclo',
  camp.name                                                           AS 'Campus',
  deg.name                                                            AS 'Grado',
  sl.name                                                             AS 'Nivel',
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción'
FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures scy ON `scy`.`id` = `student_registration`.`schoolyear_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34,198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE
                                            `type` = 'inscription' AND `structure_id` IN (SELECT `structure_id`
                                                                              FROM `heritages`
                                                                              WHERE `ancestor` IN
                                                                                    (34,198))) AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `scy`.`name` ASC, `camp`.`name` ASC, `sl`.`id` ASC, `deg`.`order` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  scy.name                                                            AS 'Ciclo',
  camp.name                                                           AS 'Campus',
  deg.name                                                            AS 'Grado',
  sl.name                                                             AS 'Nivel',
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción'
FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures scy ON `scy`.`id` = `student_registration`.`schoolyear_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE
                                            `type` = 'inscription' AND
                                            `structure_id` IN (SELECT `structure_id`
                                                               FROM `heritages`
                                                               WHERE `ancestor` IN
                                                                     (34, 198))) AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `scy`.`name` ASC, `camp`.`name` ASC, `sl`.`id` ASC, `deg`.`order` ASC,
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.school_enrollment                                            AS 'Matricula',
  CONCAT(people.first_name, ' ', people.second_name, ' ', people.names) AS 'Nombre Completo',
  sl.name                                                               AS 'Nivel',
  deg.name                                                              AS 'Grado',
  camp.name                                                             AS 'Campus',
  student_registration.status,
  students.enrollment_at,
  student_registration.registration_id
FROM student_registration
  JOIN students ON students.people_id = student_registration.people_id
  JOIN school_structures sl ON sl.id = student_registration.level_id
  JOIN school_structures camp ON camp.id = student_registration.site_id
  JOIN school_structures deg ON deg.id = student_registration.degree_id
  JOIN people ON people.id = students.people_id
  JOIN student_tuitions ON students.people_id = student_tuitions.student_id
WHERE student_registration.schoolyear_id IN (198, 288) AND
      student_tuitions.tuition_id IN (40, 43, 46, 49, 52, 55, 58, 61, 66, 67) AND
      student_registration.status IN ('Admitido', 'Activo')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  scy.name                                                            AS 'Ciclo',
  camp.name                                                           AS 'Campus',
  deg.name                                                            AS 'Grado',
  sl.name                                                             AS 'Nivel',
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción',
  student_registration.registration_id

FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures scy ON `scy`.`id` = `student_registration`.`schoolyear_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE
                                            `type` = 'inscription' AND
                                            `structure_id` IN (SELECT `structure_id`
                                                               FROM `heritages`
                                                               WHERE `ancestor` IN
                                                                     (34, 198))) AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `scy`.`name` ASC, `camp`.`name` ASC, `sl`.`id` ASC, `deg`.`order` ASC,
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW 
  scy.name                                                            AS 'Ciclo',
  camp.name                                                           AS 'Campus',
  deg.name                                                            AS 'Grado',
  sl.name                                                             AS 'Nivel',
  students.school_enrollment                                          AS 'Matricula',
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) AS 'Nombre Completo',
  student_registration.status                                         AS 'Estado',
  students.enrollment_at                                              AS 'Fecha de inscripción',
  student_registration.registration_id

FROM `student_registration`
  INNER JOIN `students` ON `students`.`people_id` = `student_registration`.`people_id`
  INNER JOIN school_structures sl ON `sl`.`id` = `student_registration`.`level_id`
  INNER JOIN school_structures scy ON `scy`.`id` = `student_registration`.`schoolyear_id`
  INNER JOIN school_structures camp ON `camp`.`id` = `student_registration`.`site_id`
  INNER JOIN school_structures deg ON `deg`.`id` = `student_registration`.`degree_id`
  INNER JOIN `people` ON `people`.`id` = `students`.`people_id`
  INNER JOIN `student_tuitions` ON `students`.`people_id` = `student_tuitions`.`student_id`
WHERE `student_registration`.`schoolyear_id` IN (34, 198) AND
      `student_tuitions`.`tuition_id` IN (SELECT `id`
                                          FROM `tuitions`
                                          WHERE
                                            `type` = 'inscription' AND
                                            `structure_id` IN (SELECT `structure_id`
                                                               FROM `heritages`
                                                               WHERE `ancestor` IN
                                                                     (34, 198))) AND
      `student_registration`.`status` IN (
        "Activo",
        "Baja temporal",
        "Condicionado",
        "Suspendido"
      )
ORDER BY `scy`.`name` ASC, `camp`.`name` ASC, `sl`.`id` ASC, `deg`.`order` ASC,
  CONCAT_WS(' ', people.first_name, people.second_name, people.names) ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payment_detail
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_payed
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payments
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuition_id, payment_id, SUM(amount) AS payed, payed_at
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
GROUP BY student_tuition_id
;-- -. . -..- - / . -. - .-. -.--
SELECT student_tuition_id, payment_id, SUM(student_payments.amount) AS payed, payed_at
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
GROUP BY student_tuition_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
LEFT JOIN (
SELECT student_tuition_id, payment_id, SUM(student_payments.amount) AS payed, payed_at
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
GROUP BY student_tuition_id) AS payment_resume ON student_tuition_detail.id = payment_resume.student_tuition_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.tuition_id,
  student_tuition_detail.payment_index,
  student_tuition_detail.payment_time,
  student_tuition_detail.type,
  student_tuition_detail.amount,
  student_tuition_detail.created_at,
  student_tuition_detail.updated_at,
  student_tuition_detail.deleted_at,
  student_tuition_detail.expected_at,
  payment_resume.payed,
  payment_resume.payed_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type !='other' AND ISNULL(deleted_at)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  SUM(IF(payment_resume.payed_at IS NULL ,student_tuition_detail.amount,payment_resume.payed)) AS
    amount,
  DATE_FORMAT(student_tuition_detail.expected_at, '%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at,student_tuition_detail.expected_at), '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type !='other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING show_at = payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  SUM(IF(payment_resume.payed_at IS NULL ,student_tuition_detail.amount,payment_resume.payed)) AS
    amount,
  DATE_FORMAT(student_tuition_detail.expected_at, '%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at,student_tuition_detail.expected_at), '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type !='other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  SUM(IF(payment_resume.payed_at IS NULL ,student_tuition_detail.amount,payment_resume.payed)) AS
    amount,
  DATE_FORMAT(student_tuition_detail.expected_at, '%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at,student_tuition_detail.expected_at), '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type !='other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 215 AND tuition_type = 'tuition' AND expected_at = '2016-08'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  SUM(IF(payment_resume.payed_at IS NULL ,student_tuition_detail.amount,payment_resume.payed)) AS
    amount,
  DATE_FORMAT(student_tuition_detail.expected_at, '%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at,student_tuition_detail.expected_at), '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type !='other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 215
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(student_tuition_detail.amount)
FROM student_tuition_detail
WHERE student_tuition_detail.tuition_id IN (56) AND
      (student_tuition_detail.expected_at >= '2016-08-01' AND
       student_tuition_detail.expected_at <= '2016-08-31')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
WHERE level_id = 215
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail
WHERE level_id = 215 AND tuition_type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(amount)
FROM student_tuition_detail
WHERE level_id = 215 AND tuition_type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(amount)
FROM student_tuition_detail
WHERE level_id = 215 AND tuition_type = 'tuition' AND DATE_FORMAT(expected_at, '%Y-%m')='2016-08'
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(student_tuition_detail.amount)
FROM student_tuition_detail
WHERE student_tuition_detail.tuition_id IN (56) AND
      (student_tuition_detail.expected_at >= '2016-08-01' AND
       student_tuition_detail.expected_at <= '2016-09-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(student_tuition_detail.amount)
FROM student_tuition_detail
WHERE student_tuition_detail.tuition_id IN (56) AND
      (student_tuition_detail.expected_at >= '2016-08-01' AND
       student_tuition_detail.expected_at < '2016-09-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT id, amount, student_tuition_detail.tuition_id IN (56) AND
                   (student_tuition_detail.expected_at >= '2016-08-01' AND
                    student_tuition_detail.expected_at < '2016-09-01') AS ignacio,
  level_id = 215 AND tuition_type = 'tuition' AND DATE_FORMAT(expected_at, '%Y-%m')='2016-08' AS 
    henry
FROM student_tuition_detail
;-- -. . -..- - / . -. - .-. -.--
SELECT id, amount, student_tuition_detail.tuition_id IN (56) AND
                   (student_tuition_detail.expected_at >= '2016-08-01' AND
                    student_tuition_detail.expected_at < '2016-09-01') AS ignacio,
  level_id = 215 AND tuition_type = 'tuition' AND DATE_FORMAT(expected_at, '%Y-%m')='2016-08' AS 
    henry
FROM student_tuition_detail
HAVING ignacio = 1 OR henry = 1
;-- -. . -..- - / . -. - .-. -.--
SELECT id, amount, student_tuition_detail.tuition_id IN (56) AND
                   (student_tuition_detail.expected_at >= '2016-08-01' AND
                    student_tuition_detail.expected_at < '2016-09-01') AS ignacio,
  level_id = 215 AND tuition_type = 'tuition' AND DATE_FORMAT(expected_at, '%Y-%m')='2016-08' AS
    henry, student_tuition_detail.*
FROM student_tuition_detail
HAVING ignacio = 1 OR henry = 1
;-- -. . -..- - / . -. - .-. -.--
SELECT id, amount, student_tuition_detail.tuition_id IN (56) AND
                   (student_tuition_detail.expected_at >= '2016-08-01' AND
                    student_tuition_detail.expected_at < '2016-09-01') AS ignacio,
  level_id = 215 AND tuition_type = 'tuition' AND DATE_FORMAT(expected_at, '%Y-%m')='2016-08' AS
    henry, student_tuition_detail.*
FROM student_tuition_detail
HAVING (ignacio = 1 OR henry = 1) AND ignacio!=henry
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS
                                                                                                   amount,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                          AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                          AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                                                          AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 215
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS
                                                                                                   amount,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                          AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                          AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                                                          AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 215 AND tuition_type = 'tuition'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
LEFT JOIN students ON students.people_id = student_scholarships.student_id
WHERE student_scholarships.schoolyear_id = 34
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
LEFT JOIN students ON students.people_id = student_scholarships.student_id
WHERE student_scholarships.schoolyear_id = 34 AND student_id in (SELECT student_id FROM 
  student_registration WHERE schoolyear_id = 34 AND status != 'Baja')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN students ON students.people_id = student_scholarships.student_id
  LEFT JOIN student_registration ON students.people_id = student_scholarships.student_id AND
                                    student_scholarships.schoolyear_id = student_registration.schoolyear_id
WHERE student_scholarships.schoolyear_id = 34
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN students ON students.people_id = student_scholarships.student_id
  LEFT JOIN student_registration ON students.people_id = student_scholarships.student_id AND
                                    student_scholarships.schoolyear_id = student_registration.schoolyear_id
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN students ON students.people_id = student_scholarships.student_id
  INNER JOIN student_registration ON students.people_id = student_scholarships.student_id AND
                                    student_scholarships.schoolyear_id = student_registration.schoolyear_id
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN students ON students.people_id = student_scholarships.student_id
  INNER JOIN student_registration ON student_scholarships.student_id = student_registration.student_id AND
                                    student_scholarships.schoolyear_id = student_registration.schoolyear_id
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
LEFT JOIN students ON students.people_id = student_scholarships.student_id
WHERE student_scholarships.schoolyear_id = 34 AND student_id in (SELECT student_id FROM
  student_registration WHERE schoolyear_id = 34 AND status != 'Baja')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
LEFT JOIN students ON students.people_id = student_scholarships.student_id
WHERE student_scholarships.schoolyear_id = 34 AND student_id NOT in (SELECT student_id FROM
  student_registration WHERE schoolyear_id = 34 AND status = 'Baja')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN students ON students.people_id = student_scholarships.student_id
  LEFT JOIN student_registration ON student_scholarships.student_id = student_registration
.student_id AND
                                    student_scholarships.schoolyear_id = student_registration.schoolyear_id
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN students ON students.people_id = student_scholarships.student_id
  LEFT JOIN student_registration ON student_scholarships.student_id = student_registration.student_id AND
                                    student_scholarships.schoolyear_id = 34
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  LEFT JOIN student_registration ON student_scholarships.student_id = student_registration.student_id AND
                                    student_scholarships.schoolyear_id = 34
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_scholarships
  JOIN student_registration ON student_scholarships.student_id = student_registration.student_id AND
                                    student_scholarships.schoolyear_id = 34
WHERE student_scholarships.schoolyear_id = 34 AND student_registration.status != 'Baja'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_grades`.*,
  `period_id`
FROM `student_grades`
  INNER JOIN `grading_periods` ON `grading_periods`.`id` = `grading_period`
  INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE `student_grades`.`deleted_at` IS NULL AND `student_id` = 3232 AND `ancestor` = 34 AND
      `student_grades`.`status` >= 2
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `grading_periods`
INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `grading_periods`
INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE period_id = 51
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `grading_periods`
INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE id = 51
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *
FROM `student_grades`
  INNER JOIN `grading_periods` ON `grading_periods`.`id` = `grading_period`
  INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE `student_grades`.`deleted_at` IS NULL AND `student_id` = 3232 AND `ancestor` = 34 AND
      `student_grades`.`status` >= 2
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_id,
  payment_id,
  SUM(student_payments.amount) AS payed,
  payed_at
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE DATE_FORMAT(payed_at, '%Y-%m')='2016-04' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48
)
GROUP BY student_tuition_id,payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
    student_id
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                DISTINCT student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(DISTINCT IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) 
    AS amount,
  count(DISTINCT IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(DISTINCT IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(DISTINCT IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  student_tuition_detail.expected_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(DISTINCT IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(DISTINCT IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM student_payments
WHERE student_tuition_id IN (66929,92503)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS amount,
  (IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at)
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  GROUP_CONCAT(student_tuition_detail.id) AS tmp,
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  GROUP_CONCAT(student_tuition_detail.id) AS tmp,
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  GROUP_CONCAT(student_tuition_detail.id) AS tmp,
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
GROUP_CONCAT(student_tuition_detail.id) AS tmp,

FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
GROUP_CONCAT(student_tuition_detail.id) AS tmp

FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
GROUP_CONCAT(payment_resume.student_tuition_id) AS tmp

FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
GROUP_CONCAT(payment_resume.student_tuition_id) AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS 
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
COUNT(payment_resume.student_tuition_id) AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_id,
  payment_id,
  SUM(student_payments.amount) AS payed,
  payed_at
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE DATE_FORMAT(payed_at, '%Y-%m')='2016-04' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48 AND student_id = 2924
)
GROUP BY student_tuition_id,payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at)
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
    student_id
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id=2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS
    amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed)) AS
    Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at,
COUNT(payment_resume.student_tuition_id) AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at='2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
    student_id
HAVING level_id = 48 AND show_at='2016-04' AND student_id=2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount,payment_resume.payed))
    AS amount,
  count(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
    AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m')AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m') AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
    student_id
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed))
                                                           AS amount,
  count(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
                                                           AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at, '%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m')            AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                     AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
                                                           AS amount,
  count(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))
                                                           AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at, '%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at, '%Y-%m')            AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                     AS show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed_at, student_tuition_detail.amount))                       AS amount,
  count(IFNULL(payment_resume.payed_at,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed))
                                                                                            AS amount,
  count(IFNULL(payment_resume.payed_at,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed))   AS
                                                                                                     amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS
                                                                                                     Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                            AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                            AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                                                            AS show_at,
  COUNT(
      payment_resume.student_tuition_id)                                                          AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed))   AS
                                                                                                     amount,
  COUNT(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS
                                                                                                     Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                            AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                            AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                                                            AS show_at,
  COUNT(
      payment_resume.student_tuition_id)                                                          AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IF(payment_resume.payed, student_tuition_detail.amount))   AS
                                                                                                     amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)
  ) AS
                                                                                                     Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                            AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                            AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                                                            AS show_at,
  COUNT(
      payment_resume.student_tuition_id)                                                          AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount)   AS
                                                                                                     amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)
  ) AS
                                                                                                     Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                            AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                            AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                                                            AS show_at,
  COUNT(
      payment_resume.student_tuition_id)                                                          AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)
  )                                                                AS
                                                                      Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                             AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                             AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                             AS show_at,
  COUNT(
      payment_resume.student_tuition_id)                           AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  IFNULL(student_tuition_detail.expected_at, payment_resume.payed_at),
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_id
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_id,
  payment_id,
  SUM(student_payments.amount) AS payed,
  payed_at
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE DATE_FORMAT(payed_at, '%Y-%m') = '2016-04' AND student_tuition_id IN (
  SELECT id
  FROM student_tuition_detail
  WHERE level_id = 48 AND student_id = 2924
)
GROUP BY student_tuition_id, payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payments
WHERE student_tuition_id IN (66929, 92503)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE DATE_FORMAT(payed_at, '%Y-%m') = '2016-04' AND student_tuition_id IN (
  SELECT id
  FROM student_tuition_detail
  WHERE level_id = 48 AND student_id = 2924
)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.student_id,
  student_tuition_detail.id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))                          AS amount,
  COUNT(IFNULL(payment_resume.payed,
               student_tuition_detail.amount))                                              AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                                                      AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                                                      AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') AS
                                                                                               show_at
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at = '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  (IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.group_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
GROUP BY
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at
HAVING level_id = 48 AND show_at = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
      payment_resume.student_tuition_id)                             AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
  AND level_id = 48 AND DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
                                    '%Y-%m') = '2016-04' AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
    payment_resume.student_tuition_id)                               AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
      AND level_id = 48
      AND student_id = 2924
      AND
      DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at), '%Y-%m') =
      '2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  COUNT(IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
    payment_resume.student_tuition_id)                               AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
      AND level_id = 48
      AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  (IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
    payment_resume.student_tuition_id)                               AS tmp
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
      AND level_id = 48
      AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  (IFNULL(payment_resume.payed, student_tuition_detail.amount))   AS amount,
  (IFNULL(payment_resume.payed, student_tuition_detail.amount)) AS Contar,
  DATE_FORMAT(student_tuition_detail.expected_at,
              '%Y-%m')                                               AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,
              '%Y-%m')                                               AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),
              '%Y-%m')                                               AS show_at,
  (
    payment_resume.student_tuition_id)                               AS tmp,
payment_id
FROM student_tuition_detail
  LEFT JOIN (
              SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id, payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(deleted_at)
      AND level_id = 48
      AND student_id = 2924
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.tuition_structure_id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  IF(payment_resume.payed_at IS NULL,0,student_tuition_detail.payment_index) AS payment_index_real,
  student_tuition_detail.payment_index,
  student_tuition_detail.tuition_id,
  SUM(student_tuition_detail.amount) as expected_amount,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS payed_amount,
  count(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS count_tuitions,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,'%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),'%Y-%m') AS show_at,
  tuitions.config
FROM student_tuition_detail
  LEFT JOIN ( SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
  LEFT JOIN tuitions ON tuitions.id = student_tuition_detail.tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(student_tuition_detail.deleted_at)
GROUP BY
  student_tuition_detail.tuition_structure_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.payment_index,
  student_tuition_detail.tuition_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_tuition_detail.student_id
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-01' AND '2016-05-01'
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, student_payments.*
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-01' AND '2016-05-01'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT payed_at, student_payments.*
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-01' AND '2016-05-01') AS Muestra01
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(amount)
FROM (SELECT payed_at, student_payments.*
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-01' AND '2016-05-01') AS Muestra01
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(amount)
FROM (SELECT payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-01' AND '2016-05-01' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, SUM(amount)
FROM (SELECT payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-01' AND '2016-05-01' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-01' AND '2016-05-01' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, student_payments.*
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-15' AND '2016-04-15' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48
)
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, SUM(amount)
  FROM (SELECT payed_at, student_payments.*
        FROM student_payments
          LEFT JOIN payments ON payments.id = student_payments.payment_id
        WHERE payed_at Between '2016-04-15' AND '2016-04-15' AND student_tuition_id IN (
          SELECT id FROM student_tuition_detail WHERE level_id = 48
        )) AS Muestra01
  GROUP BY payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, student_payments.*
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48
)
;-- -. . -..- - / . -. - .-. -.--
SELECT payment, SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payment
;-- -. . -..- - / . -. - .-. -.--
SELECT payment.id, SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payment.id
;-- -. . -..- - / . -. - .-. -.--
SELECT payments.id AS payment_id, student_payments.*
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48
)
;-- -. . -..- - / . -. - .-. -.--
SELECT payment_id, SUM(amount)
FROM (SELECT payments.id AS payment_id, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payment_id
;-- -. . -..- - / . -. - .-. -.--
SELECT student_id, SUM(amount)
FROM (SELECT student_id, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
        LEFT JOIN student_tuitions ON student_tuitions.id = student_payments.student_tuition_id
      WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-01' AND '2016-05-01' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
GROUP BY payed_at
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(amount)
FROM (SELECT DATE_FORMAT(payed_at,'%Y-%m-%d')payed_at, student_payments.*
      FROM student_payments
        LEFT JOIN payments ON payments.id = student_payments.payment_id
      WHERE payed_at Between '2016-04-01' AND '2016-05-01' AND student_tuition_id IN (
        SELECT id FROM student_tuition_detail WHERE level_id = 48
      )) AS Muestra01
;-- -. . -..- - / . -. - .-. -.--
SELECT payed_at, student_payments.*
FROM student_payments
LEFT JOIN payments ON payments.id = student_payments.payment_id
WHERE payed_at Between '2016-04-01' AND '2016-05-01' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48
)
;-- -. . -..- - / . -. - .-. -.--
SELECT student_id, student_payments.*
FROM student_payments
  LEFT JOIN payments ON payments.id = student_payments.payment_id
  LEFT JOIN student_tuitions ON student_tuitions.id = student_payments.student_tuition_id
WHERE payed_at Between '2016-04-15' AND '2016-04-16' AND student_tuition_id IN (
  SELECT id FROM student_tuition_detail WHERE level_id = 48
)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  MAX(tuitions.structure_id)      AS tuition_structure_id,
  MAX(schoolyears.structure_id)   AS schoolyear_id,
  MAX(sites.structure_id)         AS site_id,
  MAX(levels.structure_id)        AS level_id,
  MAX(degrees.structure_id)       AS degree_id,
  MAX(school_groups.structure_id) AS group_id,
  tuitions.type                   AS tuition_type,
  student_tuitions.*
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.id = registrations.degree_id
  LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
  LEFT JOIN schoolyears ON (
    structure_tuitions.ancestor = schoolyears.structure_id OR
    structure_tuitions.decendants = schoolyears.structure_id OR
    structure_tuitions.structure_id = schoolyears.structure_id
    )
  LEFT JOIN sites ON (
    structure_tuitions.ancestor = sites.structure_id OR
    structure_tuitions.decendants = sites.structure_id OR
    structure_tuitions.structure_id = sites.structure_id
    )
  LEFT JOIN levels ON (
    structure_tuitions.ancestor = levels.structure_id OR
    structure_tuitions.decendants = levels.structure_id OR
    structure_tuitions.structure_id = levels.structure_id
    )
  LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
    structure_tuitions.ancestor = degrees.structure_id OR
    structure_tuitions.decendants = degrees.structure_id OR
    structure_tuitions.structure_id = degrees.structure_id
  )
  LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
    structure_tuitions.ancestor = school_groups.structure_id OR
    structure_tuitions.decendants = school_groups.structure_id OR
    structure_tuitions.structure_id = school_groups.structure_id
  )
  LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
WHERE isnull(student_tuitions.deleted_at)
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (
SELECT DISTINCTROW
  MAX(tuitions.structure_id)      AS tuition_structure_id,
  MAX(schoolyears.structure_id)   AS schoolyear_id,
  MAX(sites.structure_id)         AS site_id,
  MAX(levels.structure_id)        AS level_id,
  MAX(degrees.structure_id)       AS degree_id,
  MAX(school_groups.structure_id) AS group_id,
  tuitions.type                   AS tuition_type,
  student_tuitions.*
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.id = registrations.degree_id
  LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
  LEFT JOIN schoolyears ON (
    structure_tuitions.ancestor = schoolyears.structure_id OR
    structure_tuitions.decendants = schoolyears.structure_id OR
    structure_tuitions.structure_id = schoolyears.structure_id
    )
  LEFT JOIN sites ON (
    structure_tuitions.ancestor = sites.structure_id OR
    structure_tuitions.decendants = sites.structure_id OR
    structure_tuitions.structure_id = sites.structure_id
    )
  LEFT JOIN levels ON (
    structure_tuitions.ancestor = levels.structure_id OR
    structure_tuitions.decendants = levels.structure_id OR
    structure_tuitions.structure_id = levels.structure_id
    )
  LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
    structure_tuitions.ancestor = degrees.structure_id OR
    structure_tuitions.decendants = degrees.structure_id OR
    structure_tuitions.structure_id = degrees.structure_id
  )
  LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
    structure_tuitions.ancestor = school_groups.structure_id OR
    structure_tuitions.decendants = school_groups.structure_id OR
    structure_tuitions.structure_id = school_groups.structure_id
  )
  LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
WHERE isnull(student_tuitions.deleted_at)
GROUP BY student_tuitions.id) AS TMP
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (
SELECT DISTINCTROW
  MAX(tuitions.structure_id)      AS tuition_structure_id,
  MAX(schoolyears.structure_id)   AS schoolyear_id,
  MAX(sites.structure_id)         AS site_id,
  MAX(levels.structure_id)        AS level_id,
  MAX(degrees.structure_id)       AS degree_id,
  MAX(school_groups.structure_id) AS group_id,
  tuitions.type                   AS tuition_type,
  student_tuitions.*
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.id = registrations.degree_id
  LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
  LEFT JOIN schoolyears ON (
    structure_tuitions.ancestor = schoolyears.structure_id OR
    structure_tuitions.decendants = schoolyears.structure_id OR
    structure_tuitions.structure_id = schoolyears.structure_id
    )
  LEFT JOIN sites ON (
    structure_tuitions.ancestor = sites.structure_id OR
    structure_tuitions.decendants = sites.structure_id OR
    structure_tuitions.structure_id = sites.structure_id
    )
  LEFT JOIN levels ON (
    structure_tuitions.ancestor = levels.structure_id OR
    structure_tuitions.decendants = levels.structure_id OR
    structure_tuitions.structure_id = levels.structure_id
    )
  LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
    structure_tuitions.ancestor = degrees.structure_id OR
    structure_tuitions.decendants = degrees.structure_id OR
    structure_tuitions.structure_id = degrees.structure_id
  )
  LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
    structure_tuitions.ancestor = school_groups.structure_id OR
    structure_tuitions.decendants = school_groups.structure_id OR
    structure_tuitions.structure_id = school_groups.structure_id
  )
  LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
WHERE isnull(student_tuitions.deleted_at)
GROUP BY student_tuitions.id) AS TMP
WHERE student_id = 3373
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.tuition_structure_id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(student_tuition_detail.amount) as expected_amount,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS payed_amount,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,'%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),'%Y-%m') AS show_at,
  tuitions.config
FROM student_tuition_detail
  LEFT JOIN ( SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
  LEFT JOIN tuitions ON tuitions.id = student_tuition_detail.tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(student_tuition_detail.deleted_at)
GROUP BY
  student_tuition_detail.tuition_structure_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_tuition_detail.student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_tuition_detail.tuition_structure_id,
  student_tuition_detail.student_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  SUM(student_tuition_detail.amount) as expected_amount,
  SUM(IF(payment_resume.payed_at IS NULL, student_tuition_detail.amount, payment_resume.payed)) AS payed_amount,
  DATE_FORMAT(student_tuition_detail.expected_at,'%Y-%m') AS expected_at,
  DATE_FORMAT(payment_resume.payed_at,'%Y-%m') AS payed_at,
  DATE_FORMAT(IFNULL(payment_resume.payed_at, student_tuition_detail.expected_at),'%Y-%m') AS show_at,
  tuitions.config
FROM student_tuition_detail
  LEFT JOIN ( SELECT
                student_tuition_id,
                payment_id,
                SUM(student_payments.amount) AS payed,
                payed_at
              FROM student_payments
                LEFT JOIN payments ON payments.id = student_payments.payment_id
              GROUP BY student_tuition_id,payed_at) AS payment_resume
    ON student_tuition_detail.id = payment_resume.student_tuition_id
  LEFT JOIN tuitions ON tuitions.id = student_tuition_detail.tuition_id
WHERE student_tuition_detail.tuition_type != 'other' AND ISNULL(student_tuition_detail.deleted_at)
GROUP BY
  student_tuition_detail.tuition_structure_id,
  student_tuition_detail.schoolyear_id,
  student_tuition_detail.site_id,
  student_tuition_detail.level_id,
  student_tuition_detail.degree_id,
  student_tuition_detail.group_id,
  student_tuition_detail.tuition_type,
  student_tuition_detail.type,
  student_tuition_detail.expected_at,
  payment_resume.payed_at,
  student_tuition_detail.student_id
HAVING level_id = 48 AND show_at='2016-04'
;-- -. . -..- - / . -. - .-. -.--
CREATE OR REPLACE VIEW student_tuition_detail AS
SELECT DISTINCTROW
  MAX(tuitions.structure_id)      AS tuition_structure_id,
  MAX(schoolyears.structure_id)   AS schoolyear_id,
  MAX(sites.structure_id)         AS site_id,
  MAX(levels.structure_id)        AS level_id,
  MAX(degrees.structure_id)       AS degree_id,
  MAX(school_groups.structure_id) AS group_id,
  tuitions.type                   AS tuition_type,
  student_tuitions.*
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.id = registrations.degree_id
  LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
  LEFT JOIN schoolyears ON (
    structure_tuitions.ancestor = schoolyears.structure_id OR
    structure_tuitions.decendants = schoolyears.structure_id OR
    structure_tuitions.structure_id = schoolyears.structure_id
    )
  LEFT JOIN sites ON (
    structure_tuitions.ancestor = sites.structure_id OR
    structure_tuitions.decendants = sites.structure_id OR
    structure_tuitions.structure_id = sites.structure_id
    )
  LEFT JOIN levels ON (
    structure_tuitions.ancestor = levels.structure_id OR
    structure_tuitions.decendants = levels.structure_id OR
    structure_tuitions.structure_id = levels.structure_id
    )
  LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
    structure_tuitions.ancestor = degrees.structure_id OR
    structure_tuitions.decendants = degrees.structure_id OR
    structure_tuitions.structure_id = degrees.structure_id
  )
  LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
    structure_tuitions.ancestor = school_groups.structure_id OR
    structure_tuitions.decendants = school_groups.structure_id OR
    structure_tuitions.structure_id = school_groups.structure_id
  )
  LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
WHERE isnull(student_tuitions.deleted_at)
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
CREATE OR REPLACE VIEW student_tuition_detail AS
SELECT DISTINCTROW
  MAX(tuitions.structure_id)      AS tuition_structure_id,
  MAX(schoolyears.structure_id)   AS schoolyear_id,
  MAX(sites.structure_id)         AS site_id,
  MAX(levels.structure_id)        AS level_id,
  MAX(degrees.structure_id)       AS degree_id,
  MAX(school_groups.structure_id) AS group_id,
  tuitions.type                   AS tuition_type,
  student_tuitions.*
FROM student_tuitions
  LEFT JOIN structure_tuitions ON structure_tuitions.id = student_tuitions.tuition_id
  LEFT JOIN registrations ON student_tuitions.student_id = registrations.student_id
                             AND structure_tuitions.structure_id = registrations.degree_id
  LEFT JOIN group_student ON student_tuitions.student_id = group_student.student_id
  LEFT JOIN schoolyears ON (
    structure_tuitions.ancestor = schoolyears.structure_id OR
    structure_tuitions.decendants = schoolyears.structure_id OR
    structure_tuitions.structure_id = schoolyears.structure_id
    )
  LEFT JOIN sites ON (
    structure_tuitions.ancestor = sites.structure_id OR
    structure_tuitions.decendants = sites.structure_id OR
    structure_tuitions.structure_id = sites.structure_id
    )
  LEFT JOIN levels ON (
    structure_tuitions.ancestor = levels.structure_id OR
    structure_tuitions.decendants = levels.structure_id OR
    structure_tuitions.structure_id = levels.structure_id
    )
  LEFT JOIN degrees ON degrees.structure_id = registrations.degree_id AND (
    structure_tuitions.ancestor = degrees.structure_id OR
    structure_tuitions.decendants = degrees.structure_id OR
    structure_tuitions.structure_id = degrees.structure_id
  )
  LEFT JOIN school_groups ON group_student.group_id = school_groups.structure_id AND (
    structure_tuitions.ancestor = school_groups.structure_id OR
    structure_tuitions.decendants = school_groups.structure_id OR
    structure_tuitions.structure_id = school_groups.structure_id
  )
  LEFT JOIN tuitions ON tuitions.id = student_tuitions.tuition_id
WHERE isnull(student_tuitions.deleted_at)
GROUP BY student_tuitions.id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `schoolyears`
WHERE `schoolyears`.`deleted_at` IS NULL AND `status` IN (
  "Pre-activo",
  "Activo",
  "Vigente",
  "Bloqueado",
  "Histórico",
  "Respaldo"
)
ORDER BY status + 0 DESC
LIMIT 1
;-- -. . -..- - / . -. - .-. -.--
SELECT status + 0, schoolyears.*
FROM `schoolyears`
WHERE `schoolyears`.`deleted_at` IS NULL AND `status` IN (
  "Pre-activo",
  "Activo",
  "Vigente",
  "Bloqueado",
  "Histórico",
  "Respaldo"
)
ORDER BY status + 0 DESC
LIMIT 1
;-- -. . -..- - / . -. - .-. -.--
SELECT status + 0, schoolyears.*
FROM `schoolyears`
WHERE `schoolyears`.`deleted_at` IS NULL AND `status` IN (
  "Pre-activo",
  "Activo",
  "Vigente",
  "Bloqueado",
  "Histórico",
  "Respaldo"
)
ORDER BY status + 0 DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT CONCAT("ALTER TABLE ", TABLE_NAME," CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci") AS ExecuteTheString
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA="oramalocal" AND TABLE_TYPE="BASE TABLE"
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE 5b_tc CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE address_family CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE address_people CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE address_site CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE addresses CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE appointments CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE cashier_drops CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE cashiers CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE criteria CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE customers CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE degrees CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE documents CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE educational_standards CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE eliminar CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_formats CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_information_person CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_informations CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_points CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollments CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE facilities CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE families CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE family_people CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE feedbacks CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE grade_logs CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE grading_periods CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE group_student CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE group_teacher CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE heritages CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE invoices CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE levels CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE message_statuses CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE messages CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE migrations CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE old_payments CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE payments CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE people CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE periods CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE plan_subjects CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE registrations CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE scales CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE scholarships CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE school_groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE school_structures CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE schoolyears CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE sites CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_enrollments CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_grades CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_healths CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_logs CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_payment_options CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_payments CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_psychological CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_scholarships CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_tuitions CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE students CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE study_plans CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE subject_groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE subjects CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE subjects_heritages CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE teacher_criteria CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE teacher_schedules CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE teachers CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE throttle CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE tuitions CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE user_devices CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE users CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE users_groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_spanish_ci
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA='oramalocal' AND TABLE_TYPE="BASE TABLE"
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE 5b CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE 5b_tc CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE address_family CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE address_people CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE address_site CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE addresses CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE appointments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE cashier_drops CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE cashiers CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE criteria CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE customers CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE degrees CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE documents CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE educational_standards CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE eliminar CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_formats CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_information_person CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_informations CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollment_points CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE enrollments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE facilities CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE families CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE family_people CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE feedbacks CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE grade_logs CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE grading_periods CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE group_student CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE group_teacher CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE heritages CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE invoices CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE levels CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE message_statuses CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE messages CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE migrations CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE old_payments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE payments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE people CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE periods CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE plan_subjects CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE registrations CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE scales CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE scholarships CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE school_groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE school_structures CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE schoolyears CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE sites CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_enrollments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_grades CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_healths CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_logs CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_payment_options CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_payments CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_psychological CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_scholarships CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE student_tuitions CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE students CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE study_plans CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE subject_groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE subjects CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE subjects_heritages CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE teacher_criteria CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE teacher_schedules CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE teachers CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE throttle CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE tuitions CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE user_devices CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE users CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE users_groups CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail ON students.people_id = student_tuitions.student_id
                                      AND student_registration.schoolyear_id =
                                          student_tuition_detail.schoolyear_id
                                      AND student_tuition_detail.tuition_type = 'inscription'
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail ON students.people_id = student_tuition_detail.student_id
                                      AND student_registration.schoolyear_id =
                                          student_tuition_detail.schoolyear_id
                                      AND student_tuition_detail.tuition_type = 'inscription'
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT students.*,
  student_registration.*,
people.*,
!ISNULL(student_tuition_detail.id) AS new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail ON students.people_id = student_tuition_detail.student_id
                                      AND student_registration.schoolyear_id =
                                          student_tuition_detail.schoolyear_id
                                      AND student_tuition_detail.tuition_type = 'inscription'
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT students.*,
  student_registration.*,
people.*,
student_id IN (SELECT student_id FROM student_tuition_detail WHERE student_tuition_detail
.schoolyear_id = student_registration.schoolyear_id) AS new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT students.*,
  student_registration.*,
people.*,
student_id IN (
  SELECT student_id
  FROM student_tuition_detail
  WHERE student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
        AND student_tuition_detail.tuition_type='inscription') AS
  new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.*,
  student_registration.*,
  people.*,
  student_id IN (
    SELECT student_tuition_detail.student_id
    FROM student_tuition_detail
    WHERE student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
          AND student_tuition_detail.tuition_type = 'inscription'
          AND student_tuition_detail.student_id = student_registration.student_id) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT students.*,
  student_registration.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT student_registration.*,
  students.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT student_registration.*,
  students.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
HAVING school_enrollment = '09020013'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT student_registration.*,
  students.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
HAVING school_enrollment = '09020013'
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT student_registration.*,
  students.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
HAVING students.school_enrollment = '09020013'
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.*,
  student_registration.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
HAVING students.school_enrollment = '09020013'
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.*,
  student_registration.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(34, full_heritage.sons) OR FIND_IN_SET(34, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 34)
HAVING students.school_enrollment = '09020013'
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.*,
  student_registration.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(34, full_heritage.sons) OR FIND_IN_SET(34, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 34)
HAVING students.school_enrollment = '16040009'
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT schoolyear_id, people_id, count(registration_id) AS conta
FROM student_registration
HAVING conta>1
;-- -. . -..- - / . -. - .-. -.--
SELECT schoolyear_id, people_id, count(registration_id) AS conta
FROM student_registration
  GROUP BY schoolyear_id, people_id
HAVING conta>1
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.*,
  student_registration.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(34, full_heritage.sons) OR FIND_IN_SET(34, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 34)
HAVING students.school_enrollment = '15010028'
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  students.*,
  student_registration.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS
    new_inscrioption
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN student_tuition_detail
    ON student_tuition_detail.schoolyear_id = student_registration.schoolyear_id
       AND student_tuition_detail.tuition_type = 'inscription'
       AND student_tuition_detail.student_id = student_registration.student_id
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(34, full_heritage.sons) OR FIND_IN_SET(34, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 34)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id ` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type ` = `inscription` AND
                                        `student_tuition_detail`.`student_id ` =
                                        `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type ` = `'inscription'`
                                        AND `student_tuition_detail`.`student_id ` =
                                            `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type` = 'inscription' AND
                                        `student_tuition_detail`.`student_id` =
                                        `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT students.*,
  student_registration.*,
  full_heritage.*,
  people.*,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type` = 'inscription' AND
                                        `student_tuition_detail`.`student_id` =
                                        `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  students.*,
  `student_registration`.*,
  `full_heritage`.*,
  `people`.*,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type` = 'inscription' AND
                                        `student_tuition_detail`.`student_id` =
                                        `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(34, full_heritage.sons) OR FIND_IN_SET(34, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 34)
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  students.*,
  `student_registration`.*,
  `full_heritage`.*,
  `people`.*,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type` = 'inscription' AND
                                        `student_tuition_detail`.`student_id` =
                                        `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
  HAVING school_enrollment IN (16070009,
  16070010,
  16070016,
  16070018,
  16070020
  )
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  students.*,
  `student_registration`.*,
  `full_heritage`.*,
  `people`.*,
  !ISNULL(student_tuition_detail.tuition_type) AS newEnrollment
FROM `students`
  INNER JOIN `student_registration` ON `students`.`people_id` = `student_registration`.`student_id`
  INNER JOIN `full_heritage` ON `student_registration`.`degree_id` = `full_heritage`.`structure_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
  LEFT JOIN `student_tuition_detail` ON `student_tuition_detail`.`schoolyear_id` =
                                        `student_registration`.`schoolyear_id` AND
                                        `student_tuition_detail`.`tuition_type` = 'inscription' AND
                                        `student_tuition_detail`.`student_id` =
                                        `student_registration`.`student_id`
WHERE `students`.`deleted_at` IS NULL AND
      (FIND_IN_SET(198, full_heritage.sons) OR FIND_IN_SET(198, full_heritage.ancestor) OR
       `full_heritage`.`structure_id` = 198)
  HAVING students.school_enrollment IN (16070009,
  16070010,
  16070016,
  16070018,
  16070020
  )
ORDER BY `students`.`school_enrollment` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
  INNER JOIN heritages ON school_groups.structure_id = heritages.structure_id
  INNER JOIN levels ON heritages.ancestor = levels.structure_id
WHERE levels.responsible LIKE CONCAT('\_id_:%','42','}%')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
  INNER JOIN heritages ON school_groups.structure_id = heritages.structure_id
  INNER JOIN levels ON heritages.ancestor = levels.structure_id
WHERE levels.responsible LIKE CONCAT('\_id_:%','4281','}%')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
  INNER JOIN heritages ON school_groups.structure_id = heritages.structure_id
  INNER JOIN levels ON heritages.ancestor = levels.structure_id
WHERE levels.responsible LIKE CONCAT('%\_id_:','4281','}%')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
  INNER JOIN heritages ON school_groups.structure_id = heritages.structure_id
  INNER JOIN levels ON heritages.ancestor = levels.structure_id
WHERE levels.responsible LIKE CONCAT('%\_id_:','42','}%')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
  INNER JOIN heritages ON school_groups.structure_id = heritages.structure_id
  INNER JOIN levels ON heritages.ancestor = levels.structure_id
WHERE levels.responsible LIKE CONCAT('%\_id_:','1','}%')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM school_groups
  INNER JOIN heritages ON school_groups.structure_id = heritages.structure_id
  INNER JOIN levels ON heritages.ancestor = levels.structure_id
WHERE levels.responsible LIKE CONCAT('%\_id_:', '1', '}%')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `grade_logs`
WHERE `grade_logs`.`deleted_at` IS NULL AND `grade_id` IN (SELECT *
                                                           FROM `student_grades`
                                                           WHERE `evaluation_id` IN (608) AND
                                                                 `grading_period` IN (29))
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `grade_logs`
WHERE `grade_logs`.`deleted_at` IS NULL AND `grade_id` IN (SELECT id
                                                           FROM `student_grades`
                                                           WHERE `evaluation_id` IN (608) AND
                                                                 `grading_period` IN (29))
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM addresses
INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type='Familiar'
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT address_people.* zip,
  location,
phones,
address
FROM addresses
  INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type = 'Familiar'
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  address_people.*,
  zip,
  location,
  phones,
  address
FROM addresses
  INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type = 'Familiar'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT DISTINCT
  address_people.*,
  zip,
  location,
  phones,
  address
FROM addresses
  INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type = 'Familiar') AS people_family_address
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT DISTINCT
  address_people.*,
  zip,
  location,
  phones,
  address
FROM addresses
  INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type = 'Familiar') AS people_family_address
LEFT JOIN family_people ON people_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT DISTINCT
  address_people.*,
  zip,
  location,
  phones,
  address
FROM addresses
  INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type = 'Familiar') AS people_family_address
LEFT JOIN family_people ON people_family_address.people_id=family_people.people_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM (SELECT DISTINCT
  address_people.*,
  zip,
  location,
  phones,
  SOUNDEX(address)AS addresSound
FROM addresses
  INNER JOIN address_people ON addresses.id = address_people.address_id
WHERE type = 'Familiar') AS people_family_address
LEFT JOIN family_people ON people_family_address.people_id=family_people.people_id
;-- -. . -..- - / . -. - .-. -.--
SELECT id, SOUNDEX(address) AS addressSound
FROM addresses
;-- -. . -..- - / . -. - .-. -.--
SELECT
  SOUNDEX(address) AS addressSound,
  id
FROM addresses
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT SOUNDEX(address) AS addressSound,
  id
FROM addresses
;-- -. . -..- - / . -. - .-. -.--
SELECT
  DISTINCT SOUNDEX(address) AS addressSound,
  id
FROM addresses
WHERE created_at>'2016-01-01'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  SOUNDEX(address) AS addressSound,
  id
FROM addresses
WHERE created_at>'2016-01-01'
GROUP BY SOUNDEX(address)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  SOUNDEX(address) AS addressSound,
  address,
  id
FROM addresses
WHERE created_at>'2016-01-01'
GROUP BY SOUNDEX(address)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM
(SELECT
  SOUNDEX(address) AS addressSound,
  id
FROM addresses
WHERE created_at>'2016-01-01'
GROUP BY SOUNDEX(address)) as addressCondenced
INNER JOIN address_people ON addressCondenced.id=address_people.address_id
                             AND address_people.type='Familiar'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM address_people
WHERE type='Familiar'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM address_people
WHERE type='Familiar' AND address_id IN (SELECT id FROM addresses WHERE created_at>'2016-01-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
  FROM
(SELECT
  SOUNDEX(address) AS addressSound,
  id
FROM addresses
WHERE created_at>'2016-01-01'
GROUP BY SOUNDEX(address)) as addressCondenced
INNER JOIN address_people ON addressCondenced.id=address_people.address_id
                             AND address_people.type='Familiar'
INNER JOIN family_people ON address_people.people_id=family_people.people_id
;-- -. . -..- - / . -. - .-. -.--
SELECT address_id, family_id
  FROM
(SELECT
  SOUNDEX(address) AS addressSound,
  id
FROM addresses
WHERE created_at>'2016-01-01'
GROUP BY SOUNDEX(address)) as addressCondenced
INNER JOIN address_people ON addressCondenced.id=address_people.address_id
                             AND address_people.type='Familiar'
INNER JOIN family_people ON address_people.people_id=family_people.people_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO address_family SELECT
                              address_id,
                              family_id
                            FROM
                              (SELECT
                                 SOUNDEX(address) AS addressSound,
                                 id
                               FROM addresses
                               WHERE created_at > '2016-01-01'
                               GROUP BY SOUNDEX(address)) AS addressCondenced
                              INNER JOIN address_people
                                ON addressCondenced.id = address_people.address_id
                                   AND address_people.type = 'Familiar'
                              INNER JOIN family_people
                                ON address_people.people_id = family_people.people_id
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM address_people
WHERE type = 'Familiar' AND address_id IN (SELECT id
                                           FROM addresses
                                           WHERE created_at > '2016-01-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM address_people
WHERE type = 'Familiar' AND address_id IN (SELECT id
                                           FROM addresses
                                           WHERE created_at > '2016-01-01')
;-- -. . -..- - / . -. - .-. -.--
SELECT first_name
FROM people
  INNER JOIN registrations ON student_id = people.id AND status = 'Baja'
INNER JOIN student_debt_detail ON people.id=student_debt_detail.student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT first_name, second_name, names
FROM people
  INNER JOIN registrations ON student_id = people.id AND status = 'Baja'
INNER JOIN student_debt_detail ON people.id=student_debt_detail.student_id
;-- -. . -..- - / . -. - .-. -.--
SELECT first_name, second_name, names
FROM people
  INNER JOIN student_registration ON student_registration.student_id = people.id AND status = 'Baja'
INNER JOIN student_debt_detail ON people.id=student_debt_detail.student_id
AND student_registration.schoolyear_id=student_debt_detail.schoolyear_id
;-- -. . -..- - / . -. - .-. -.--
SELECT first_name, second_name, names, registration_id
FROM people
  INNER JOIN student_registration ON student_registration.student_id = people.id AND status = 'Baja'
INNER JOIN student_debt_detail ON people.id=student_debt_detail.student_id
AND student_registration.schoolyear_id=student_debt_detail.schoolyear_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3268)
GROUP BY `student_tuitions`.`id`
HAVING (payed < student_tuitions.amount AND type =
                                            'normal')
       OR (type = 'discount' AND payments IS NULL AND student_tuitions.created_at IS NOT NULL)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3268)
GROUP BY `student_tuitions`.`id`
HAVING (payed < student_tuitions.amount AND type =
                                            'normal')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuitions`.*,
  SUM(IFNULL(student_payments.amount, 0))             AS payed,
  CONCAT('[', GROUP_CONCAT(payment_id), ']')          AS payments,
  CONCAT('[', GROUP_CONCAT(invoice_id), ']')          AS invoices,
  CONCAT('[', GROUP_CONCAT(student_payments.id), ']') AS concepts
FROM `student_tuitions`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
WHERE `student_tuitions`.`deleted_at` IS NULL AND `student_id` IN (3268)
GROUP BY `student_tuitions`.`id`
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288)
;-- -. . -..- - / . -. - .-. -.--
SELECT student_registration.*, people.gender
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status ='Activos'
;-- -. . -..- - / . -. - .-. -.--
SELECT student_registration.*, people.gender
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status ='Activo'
;-- -. . -..- - / . -. - .-. -.--
SELECT people.gender, coutn(id)
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status ='Activo'
;-- -. . -..- - / . -. - .-. -.--
SELECT people.gender, count(people.id)
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status ='Activo'
;-- -. . -..- - / . -. - .-. -.--
SELECT people.gender, count(people.id)
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status ='Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT people.gender, count(people.id) AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status ='Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END,
  COUNT
  (people.id)
    AS
    cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END,
  COUNT(people.id)
    AS
    cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END AS Sexo,
  COUNT(people.id)
    AS
    cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END AS Genero,
  COUNT(people.id)
    AS
    cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END AS Genero,
  schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,
  COUNT(people.id) AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END AS Genero,
  schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,
  COUNT(people.id) AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender,schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END AS Genero,
  schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,
  COUNT(people.id) AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender,schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END AS Genero,
  (select name FROM school_structures WHERE id =schoolyear_id) AS Ciclo,
  (select name FROM school_structures WHERE id =site_id) AS Sede,
  (select name FROM school_structures WHERE id =level_id) AS Sección,
  (select name FROM school_structures WHERE id =degree_id) AS Grado,
  (select name FROM school_structures WHERE id =group_id) AS Grupo,
  COUNT(people.id) AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender,schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
ORDER BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
GROUP BY people.gender, schoolyear_id,
site_id,
level_id,
degree_id,
group_id WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY people.gender, schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id WITH ROLLUP
ORDER BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  IF(ISNULL(schoolyear_id),NULL ,(SELECT name
   FROM school_structures
   WHERE id = schoolyear_id)) AS Ciclo,
  IF(ISNULL(site_id),NULL ,(SELECT name
   FROM school_structures
   WHERE id = site_id))       AS Sede,
  IF(ISNULL(level_id),NULL ,(SELECT name
   FROM school_structures
   WHERE id = level_id))      AS Sección,
  IF(ISNULL(degree_id),NULL ,(SELECT name
   FROM school_structures
   WHERE id = degree_id))     AS Grado,
  IF(ISNULL(group_id),NULL ,(SELECT name
   FROM school_structures
   WHERE id = group_id))      AS Grupo,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender WITH ROLLUP
ORDER BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,
  people.gender WITH ROLLUP
ORDER BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id ASC,
  site_id ASC,
  level_id ASC,
  degree_id ASC,
  group_id ASC,
  people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id ASC,
  site_id ASC,
  level_id ASC,
  degree_id ASC,
  group_id ASC,
  people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id  WITH ROLLUP,
  level_id  WITH ROLLUP,
  degree_id  WITH ROLLUP,
  group_id  WITH ROLLUP,
  people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  schoolyear_id AS Ciclo,
  site_id       AS Sede,
  level_id      AS Sección,
  degree_id     AS Grado,
  group_id      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id,
  people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender WITH ROLLUP
;-- -. . -..- - / . -. - .-. -.--
SELECT
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
;-- -. . -..- - / . -. - .-. -.--
SELECT
  (SELECT name
   FROM school_structures
   WHERE id = schoolyear_id) AS Ciclo,
  (SELECT name
   FROM school_structures
   WHERE id = site_id)       AS Sede,
  (SELECT name
   FROM school_structures
   WHERE id = level_id)      AS Sección,
  (SELECT name
   FROM school_structures
   WHERE id = degree_id)     AS Grado,
  (SELECT name
   FROM school_structures
   WHERE id = group_id)      AS Grupo,
  CASE people.gender
  WHEN 2
    THEN 'Femenino'
  WHEN 1
    THEN 'Masculino'
  ELSE 'Sin definir' END     AS Genero,
  COUNT(people.id)           AS cantidad
FROM student_registration
  LEFT JOIN people
    ON student_registration.people_id = people.id
WHERE schoolyear_id IN (198, 288) AND student_registration.status = 'Activo'
GROUP BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
ORDER BY schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id, people.gender
;-- -. . -..- - / . -. - .-. -.--
SHOW function
;-- -. . -..- - / . -. - .-. -.--
SHOW FUNCTION STATUS
;-- -. . -..- - / . -. - .-. -.--
SHOW PROCEDURE STATUS
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.student_id,
  teacher_criteria.id,
  55,
  teacher_criteria.teacher_id,
  1,
  0,
  now(),
  "[null]"
FROM full_heritage
  JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
WHERE student_registration.status IN ("Activo","Baja temporal","Condicionado","Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.student_id,
  teacher_criteria.id,
  55,
  teacher_criteria.teacher_id,
  1,
  0,
  now(),
  "[null]"
FROM full_heritage
  JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
  JOIN group_teacher ON student_registration.group_id = group_teacher.group_id
  JOIN teacher_criteria ON group_teacher.group_id = teacher_criteria.group_id
                           AND group_teacher.teacher_id = teacher_criteria.teacher_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.student_id,
  teacher_criteria.id,
  55,
  teacher_criteria.teacher_id,
  1,
  0,
  now(),
  "[null]"
FROM full_heritage
  LEFT JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
  LEFT JOIN group_teacher ON student_registration.group_id = group_teacher.group_id
  LEFT JOIN teacher_criteria ON group_teacher.group_id = teacher_criteria.group_id
                           AND group_teacher.teacher_id = teacher_criteria.teacher_id
WHERE student_registration.status IN ("Activo","Baja temporal","Condicionado","Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.student_id,
  teacher_criteria.id,
  55,
  teacher_criteria.teacher_id,
  1,
  0,
  now(),
  "[null]"
FROM full_heritage
  JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
  JOIN group_teacher ON student_registration.group_id = group_teacher.group_id
  LEFT JOIN teacher_criteria ON group_teacher.group_id = teacher_criteria.group_id
                           AND group_teacher.teacher_id = teacher_criteria.teacher_id
WHERE student_registration.status IN ("Activo","Baja temporal","Condicionado","Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.student_id,
  teacher_criteria.id,
  55,
  teacher_criteria.teacher_id,
  1,
  0,
  now(),
  "[null]"
FROM full_heritage
  JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
  LEFT JOIN group_teacher ON student_registration.group_id = group_teacher.group_id
  LEFT JOIN teacher_criteria ON group_teacher.group_id = teacher_criteria.group_id
                           AND group_teacher.teacher_id = teacher_criteria.teacher_id
WHERE student_registration.status IN ("Activo","Baja temporal","Condicionado","Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT
  student_registration.student_id,
  teacher_criteria.id,
  55,
  teacher_criteria.teacher_id,
  1,
  0,
  now(),
  "[null]"
FROM full_heritage
  JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
  JOIN group_teacher ON student_registration.group_id = group_teacher.group_id
  JOIN teacher_criteria ON group_teacher.group_id = teacher_criteria.group_id
                           AND group_teacher.teacher_id = teacher_criteria.teacher_id
WHERE student_registration.status IN ("Activo","Baja temporal","Condicionado","Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT people_id,
  registration_id,
schoolyear_id,
site_id,
level_id,
degree_id,
group_id
FROM full_heritage
JOIN student_registration ON
FIND_IN_SET(student_registration.schoolyear_id,
full_heritage.ancestor)
AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
AND full_heritage.structure_id = 234
;-- -. . -..- - / . -. - .-. -.--
SELECT
  people_id,
  registration_id,
  schoolyear_id,
  site_id,
  level_id,
  degree_id,
  group_id
FROM full_heritage
  JOIN student_registration ON
                              FIND_IN_SET(student_registration.schoolyear_id,
                                          full_heritage.ancestor)
                              AND FIND_IN_SET(student_registration.level_id, full_heritage.ancestor)
                              AND full_heritage.structure_id = 234
WHERE student_registration.status IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `students`
  INNER JOIN `people` ON `id` = `people_id`
  INNER JOIN (SELECT *
  FROM student_tuition_detail
  LEFT JOIN student_tuition_payed
  ON student_tuition_detail.id = student_tuition_payed.student_tuition_id
  AND student_tuition_payed.last_pay_at < adddate('2016-09-14 00:00:00', 1)
  WHERE (student_tuition_detail.amount != student_tuition_payed.payed
  OR isnull(student_tuition_payed.payed))
  AND expected_at < adddate('2016-09-14 00:00:00', 1)
  AND (IF(student_tuition_detail.type IN ('discount', 'surcharges'),
  student_tuition_detail.created_at < adddate('2016-09-14 00:00:00', 1),
  TRUE
  ))
              AND student_tuition_detail.tuition_type = 'reinscription'
             ) AS student_debt_detail_at ON `student_debt_detail_at`.`student_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL AND `student_debt_detail_at`.`amount` <> 0 AND
      `students`.`people_id` IN (SELECT `student_id`
                                 FROM `student_registration`
                                 WHERE `student_registration`.`status` IN ("Activo",
                                                                           "Bajatemporal",
                                                                           "Condicionado",
                                                                           "Suspendido"
                                                                           )) AND
      `students`.`people_id` IN (SELECT `student_id`
                                 FROM `student_registration`
                                 WHERE `schoolyear_id` IN (SELECT `structure_id`
                                                           FROM `schoolyears`
                                                           WHERE `schoolyears`.`status` IN ("Vigente"))) AND
      `expected_at` <= '2016-09-14 00:00:00.000000' AND `student_debt_detail_at`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  people.*,student_payment_options.tax_id,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_id, tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  people.*,student_payment_options.tax_id,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_payment_options.student_id, student_payment_options.tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  people.*,spo.tax_id,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_payment_options.student_id, student_payment_options.tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  spo.tax_id,
  people.*,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_payment_options.student_id, student_payment_options.tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  spo.tax_id,
  people.*,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_id, tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  isnull(spo.tax_id) AS possibly_billable,
  people.*,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_id, tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  !isnull(spo.tax_id) AS possibly_billable,
  people.*,
  `student_payments`.`payment_id`,
  `levels`.`structure_id` AS `level_id`
FROM `people`
  LEFT JOIN (
              SELECT DISTINCT student_id, tax_id
              FROM student_payment_options
            ) AS spo ON spo.student_id=people.id
  LEFT JOIN `student_tuitions` ON `people`.`id` = `student_tuitions`.`student_id`
  LEFT JOIN `student_payments` ON `student_tuitions`.`id` = `student_payments`.`student_tuition_id`
  LEFT JOIN `structure_tuitions` ON `student_tuitions`.`tuition_id` = `structure_tuitions`.`id`
  LEFT JOIN `levels` ON `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`structure_id` = `levels`.`structure_id` OR
                        `structure_tuitions`.`decendants` = `levels`.`structure_id`
WHERE `people`.`deleted_at` IS NULL AND `payment_id` IN
                                        (
                                          75458,
                                          75423,
                                          75423,
                                          75554,
                                          75555,
                                          75402,
                                          75426,
                                          75586,
                                          75384,
                                          75391,
                                          75396,
                                          75410,
                                          75420,
                                          75430,
                                          75440,
                                          75488,
                                          75490,
                                          75532,
                                          75535,
                                          75541,
                                          75544,
                                          75613,
                                          75639,
                                          75667,
                                          75668,
                                          75668,
                                          75674,
                                          75678,
                                          75694,
                                          75696,
                                          75750,
                                          75394,
                                          75397,
                                          75398,
                                          75400,
                                          75404,
                                          75409,
                                          75411,
                                          75412,
                                          75413,
                                          75415,
                                          75418,
                                          75429,
                                          75429,
                                          75430,
                                          75432,
                                          75443,
                                          75450,
                                          75452,
                                          75454,
                                          75456,
                                          75475,
                                          75527,
                                          75528,
                                          75529,
                                          75530,
                                          75533,
                                          75552,
                                          75562,
                                          75562,
                                          75566,
                                          75568,
                                          75571,
                                          75582,
                                          75589,
                                          75604,
                                          75611,
                                          75621,
                                          75624,
                                          75634,
                                          75652,
                                          75654,
                                          75655,
                                          75674,
                                          75680,
                                          75682,
                                          75686,
                                          75688,
                                          75689,
                                          75694,
                                          75698,
                                          75707,
                                          75707,
                                          75708,
                                          75711,
                                          75728,
                                          75733,
                                          75736,
                                          75738,
                                          75742,
                                          75404,
                                          75407,
                                          75408,
                                          75414,
                                          75416,
                                          75418,
                                          75427,
                                          75433,
                                          75451,
                                          75460,
                                          75476,
                                          75476,
                                          75482,
                                          75489,
                                          75494,
                                          75516,
                                          75521,
                                          75579,
                                          75610,
                                          75623,
                                          75625,
                                          75629,
                                          75630,
                                          75650,
                                          75659,
                                          75665,
                                          75677,
                                          75683,
                                          75684,
                                          75687,
                                          75700,
                                          75704,
                                          75707,
                                          75719,
                                          75720,
                                          75737,
                                          75638,
                                          75724,
                                          75748,
                                          75749,
                                          75453,
                                          75524,
                                          75602,
                                          75647,
                                          75653,
                                          75672,
                                          75715,
                                          75729,
                                          75389,
                                          75418,
                                          75431,
                                          75444,
                                          75449,
                                          75484,
                                          75486,
                                          75487,
                                          75515,
                                          75525,
                                          75531,
                                          75539,
                                          75565,
                                          75569,
                                          75572,
                                          75573,
                                          75603,
                                          75620,
                                          75648,
                                          75657,
                                          75658,
                                          75672,
                                          75673,
                                          75673,
                                          75681,
                                          75726,
                                          75727,
                                          75732,
                                          75381,
                                          75389,
                                          75446,
                                          75447,
                                          75459,
                                          75522,
                                          75523,
                                          75526,
                                          75545,
                                          75574,
                                          75578,
                                          75628,
                                          75628,
                                          75640,
                                          75671,
                                          75673,
                                          75679,
                                          75726,
                                          75734,
                                          75380,
                                          75393,
                                          75401,
                                          75421,
                                          75422,
                                          75461,
                                          75473,
                                          75513,
                                          75543,
                                          75551,
                                          75553,
                                          75626,
                                          75627,
                                          75627,
                                          75646,
                                          75651,
                                          75660,
                                          75661,
                                          75671,
                                          75685,
                                          75690,
                                          75691,
                                          75704,
                                          75709,
                                          75715,
                                          75726,
                                          75735
                                        )
GROUP BY `people`.`id`, `student_payments`.`payment_id`
;-- -. . -..- - / . -. - .-. -.--
SELECT max(created_at) FROM payments
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-09-12 00:00:00.000000' AND '2016-09-12 23:59:59.000000' AND `payment_index` IN (0,1)
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-09-12 00:00:00.000000' AND '2016-09-12 23:59:59.000000' AND `payment_index` IN (0,1)
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, `payment_id`
HAVING general_folio = 'SP-8243'
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_payment_detail`.`student_id`,
  `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`,
  tuition_id,
  MAX(student_payment_detail.tuition_structure_id)      AS tuition_structure_id,
  MAX(student_payment_detail.schoolyear_id)             AS schoolyear_id,
  MAX(student_payment_detail.degree_id)                 AS degree_id,
  MAX(student_payment_detail.group_id)                  AS group_id,
  MAX(student_payment_detail.type)                      AS type,
  MAX(student_payment_detail.tuition_id)                AS tuition_id,
  MAX(student_payment_detail.payment_index)             AS payment_index,
  MAX(student_payment_detail.payment_time)              AS payment_time,
  MAX(student_payment_detail.expected_at)               AS expected_at,
  MAX(student_payment_detail.student_tuition_id)        AS student_tuition_id,
  MAX(student_payment_detail.payment_id)                AS payment_id,
  MAX(student_payment_detail.invoice_id)                AS invoice_id,
  MAX(student_payment_detail.id)                        AS id,
  MAX(student_payment_detail.created_at)                AS created_at,
  MAX(student_payment_detail.updated_at)                AS updated_at,
  MAX(student_payment_detail.deleted_at)                AS deleted_at,
  GROUP_CONCAT(student_payment_detail.expected_at)      AS expected_at,
  SUM(student_payment_detail.amount)                    AS amount,
  IF(payments.type = 'transfer'
     AND payments.info LIKE '%transaction___TRANSFER%',
     'deposit', payments.type)                          AS paymentType,
  `payed_at`,
  IF(invoice_id, CONCAT_WS('-', invoices.sequence, invoices.folio),
     CONCAT_WS('-', payments.sequence, payments.folio)) AS general_folio,
  DATE_FORMAT(payed_at, '%Y-%m-%d')                     AS payed_grouping
FROM `student_payment_detail`
  LEFT JOIN `payments` ON `payment_id` = `payments`.`id`
  LEFT JOIN `invoices` ON `invoice_id` = `invoices`.`id`
WHERE `payed_at` BETWEEN '2016-09-12 00:00:00.000000' AND '2016-09-12 23:59:59.000000' AND `payment_index` IN (0,1)
GROUP BY `student_payment_detail`.`student_id`, `student_payment_detail`.`level_id`,
  `student_payment_detail`.`site_id`, tuition_id, `payment_id`
HAVING general_folio = 'SP-8243'
ORDER BY `payed_grouping` ASC, `paymentType` ASC, `schoolyear_id` ASC, `degree_id` ASC,
  `payment_id` ASC, `type` ASC, `payment_index` ASC
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO plan_subjects (subject_group_id,subject_id,created_at)
  SELECT 312,subject_id,'2016-10-05' FROM plan_subjects
  WHERE subject_group_id=197
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO plan_subjects (subject_group_id,subject_id,created_at)
  SELECT 284,subject_id,'2016-10-27' FROM plan_subjects
  WHERE subject_group_id=137
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO plan_subjects (subject_group_id,subject_id,created_at)
  SELECT 285,subject_id,'2016-10-28' FROM plan_subjects
  WHERE subject_group_id=138
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO plan_subjects (subject_group_id,subject_id,created_at)
  SELECT 286,subject_id,'2016-10-29' FROM plan_subjects
  WHERE subject_group_id=139
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO plan_subjects (subject_group_id,subject_id,created_at)
  SELECT 287,subject_id,'2016-10-29' FROM plan_subjects
  WHERE subject_group_id=140
;-- -. . -..- - / . -. - .-. -.--
SELECT
    student_registration.student_id,
    teacher_criteria.id,
    65,
    teacher_criteria.teacher_id,
    1,
    0,
    now(),
    "[null]"
  FROM full_heritage
    JOIN student_registration ON
                                FIND_IN_SET(student_registration.schoolyear_id,
                                            full_heritage.ancestor)
                                AND FIND_IN_SET(student_registration.level_id,full_heritage.ancestor)
                                AND full_heritage.structure_id = 245
    JOIN group_teacher ON student_registration.group_id = group_teacher.group_id
    JOIN teacher_criteria ON group_teacher.group_id = teacher_criteria.group_id
                             AND group_teacher.teacher_id = teacher_criteria.teacher_id
  WHERE student_registration.status IN ("Activo","Baja temporal","Condicionado","Suspendido")
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  group_student.student_id,
  teacher_criteria.id                                                   AS evaluation_id,
  `group_teacher`.`teacher_id`,
  IFNULL(teacher_criteria.subject_id, group_teacher.subject_id)         AS subject_id,
  `group_student`.`group_id`,
  `teacher_criteria`.`criteria_id`,
  `teacher_criteria`.`concepts`,
  CONCAT_WS('_', group_student.student_id, teacher_criteria.subject_id) AS student_subject
FROM `group_student`
  LEFT JOIN `group_teacher` ON `group_student`.`group_id` = `group_teacher`.`group_id`
  LEFT JOIN `heritages` ON `group_student`.`group_id` = `heritages`.`structure_id`
  LEFT JOIN `teacher_criteria` ON `group_teacher`.`teacher_id` = `teacher_criteria`.`teacher_id` AND
                                  `group_student`.`group_id` = `teacher_criteria`.`group_id` AND
                                  group_teacher.teacher_id = teacher_criteria.teacher_id
                                  AND group_student.group_id = teacher_criteria.group_id
                                  AND IF(group_teacher.subject_id,
                                         group_teacher.subject_id = group_teacher.subject_id, TRUE)
                                      = TRUE 
WHERE `group_student`.`student_id` IN
      (
        4824,
        2719,
        3409,
        2887,
        4394,
        2717,
        3245,
        2574,
        2970,
        4869,
        2720,
        3061,
        2697,
        3214,
        2808,
        3406,
        3410,
        2588,
        2618,
        4703,
        2722,
        3229,
        2623,
        2711,
        3069,
        4425,
        5165
      )
      AND `heritages`.`ancestor` IN (?)
ORDER BY `student_id` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  group_student.student_id,
  teacher_criteria.id                                                   AS evaluation_id,
  `group_teacher`.`teacher_id`,
  IFNULL(teacher_criteria.subject_id, group_teacher.subject_id)         AS subject_id,
  `group_student`.`group_id`,
  `teacher_criteria`.`criteria_id`,
  `teacher_criteria`.`concepts`,
  CONCAT_WS('_', group_student.student_id, teacher_criteria.subject_id) AS student_subject
FROM `group_student`
  LEFT JOIN `group_teacher` ON `group_student`.`group_id` = `group_teacher`.`group_id`
  LEFT JOIN `heritages` ON `group_student`.`group_id` = `heritages`.`structure_id`
  LEFT JOIN `teacher_criteria` ON `group_teacher`.`teacher_id` = `teacher_criteria`.`teacher_id` AND
                                  `group_student`.`group_id` = `teacher_criteria`.`group_id` AND
                                  group_teacher.teacher_id = teacher_criteria.teacher_id
                                  AND group_student.group_id = teacher_criteria.group_id
                                  AND IF(group_teacher.subject_id,
                                         group_teacher.subject_id = group_teacher.subject_id, TRUE)
                                      = TRUE
WHERE `group_student`.`student_id` IN
      (
        4824,
        2719,
        3409,
        2887,
        4394,
        2717,
        3245,
        2574,
        2970,
        4869,
        2720,
        3061,
        2697,
        3214,
        2808,
        3406,
        3410,
        2588,
        2618,
        4703,
        2722,
        3229,
        2623,
        2711,
        3069,
        4425,
        5165
      )
      AND `heritages`.`ancestor` IN (198)
ORDER BY `student_id` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  group_student.student_id,
  teacher_criteria.id                                                   AS evaluation_id,
  `group_teacher`.`teacher_id`,
  IFNULL(teacher_criteria.subject_id, group_teacher.subject_id)         AS subject_id,
  `group_student`.`group_id`,
  `teacher_criteria`.`criteria_id`,
  `teacher_criteria`.`concepts`,
  CONCAT_WS('_', group_student.student_id, teacher_criteria.subject_id) AS student_subject
FROM `group_student`
  LEFT JOIN `group_teacher` ON `group_student`.`group_id` = `group_teacher`.`group_id`
  LEFT JOIN `heritages` ON `group_student`.`group_id` = `heritages`.`structure_id`
  LEFT JOIN `teacher_criteria` ON `group_teacher`.`teacher_id` = `teacher_criteria`.`teacher_id` AND
                                  `group_student`.`group_id` = `teacher_criteria`.`group_id` AND
                                  group_teacher.teacher_id = teacher_criteria.teacher_id
                                  AND group_student.group_id = teacher_criteria.group_id
                                  AND IF(group_teacher.subject_id,
                                         group_teacher.subject_id = group_teacher.subject_id, TRUE)
                                      = TRUE
WHERE `group_student`.`student_id` IN
      (
        
        5165
      )
      AND `heritages`.`ancestor` IN (198)
ORDER BY `student_id` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  group_student.student_id,
  teacher_criteria.id                                                   AS evaluation_id,
  `group_teacher`.`teacher_id`,
  IFNULL(teacher_criteria.subject_id, group_teacher.subject_id)         AS subject_id,
  `group_student`.`group_id`,
  `teacher_criteria`.`criteria_id`,
  `teacher_criteria`.`concepts`,
  CONCAT_WS('_', group_student.student_id, teacher_criteria.subject_id) AS student_subject
FROM `group_student`
  LEFT JOIN `group_teacher` ON `group_student`.`group_id` = `group_teacher`.`group_id`
  LEFT JOIN `heritages` ON `group_student`.`group_id` = `heritages`.`structure_id`
  LEFT JOIN `teacher_criteria` ON `group_teacher`.`teacher_id` = `teacher_criteria`.`teacher_id` AND
                                  `group_student`.`group_id` = `teacher_criteria`.`group_id` AND
                                  group_teacher.teacher_id = teacher_criteria.teacher_id
                                  AND group_student.group_id = teacher_criteria.group_id
                                  AND IF(group_teacher.subject_id,
                                         group_teacher.subject_id = group_teacher.subject_id, TRUE)
                                      = TRUE
WHERE `group_student`.`student_id` IN
      (

        5165
      )
      AND `heritages`.`ancestor` IN (198)
ORDER BY `student_id` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243))
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243)) AND 
      grading_period=65
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243)) AND
      grading_period=65 AND committed_at < '2016-10-28'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243)) AND
      grading_period=65 AND committed_at < '2016-10-27'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241,243)) AND
      grading_period=65 AND committed_at >= '2016-10-27'
;-- -. . -..- - / . -. - .-. -.--
DELETE
FROM student_grades
WHERE student_id IN (SELECT student_id FROM group_student WHERE group_id IN (241)) AND
      grading_period=65
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM teacher_criteria WHERE group_id in (241)
;-- -. . -..- - / . -. - .-. -.--
DELETE
FROM student_grades
WHERE student_id IN (SELECT student_id
                     FROM group_student
                     WHERE group_id IN (243)) AND grading_period = 65
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM teacher_criteria
WHERE group_id IN (243)
;-- -. . -..- - / . -. - .-. -.--
DELETE
FROM student_grades
WHERE student_id IN (SELECT student_id
                     FROM group_student
                     WHERE group_id IN (244)) AND grading_period = 65
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM teacher_criteria
WHERE group_id IN (244)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*,
  `criteria`.`concepts`
FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
  INNER JOIN `criteria` ON `periods`.`criteria_id` = `criteria`.`id`
WHERE `school_structures`.`deleted_at` IS NULL AND `type` = ?
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*,
  `criteria`.`concepts`
FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
  INNER JOIN `criteria` ON `periods`.`criteria_id` = `criteria`.`id`
WHERE `school_structures`.`deleted_at` IS NULL AND `type` = 'Period'
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*,
  `criteria`.`concepts`
FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
  INNER JOIN `criteria` ON `periods`.`criteria_id` = `criteria`.`id`
WHERE `school_structures`.`deleted_at` IS NULL
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*,
  `criteria`.`concepts`
FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
WHERE `school_structures`.`deleted_at` IS NULL
      AND `type` = 'Period'
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*,

FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
WHERE `school_structures`.`deleted_at` IS NULL
      AND `type` = 'Period'
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*

FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
WHERE `school_structures`.`deleted_at` IS NULL
      AND `type` = 'Period'
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*,
  `criteria`.`concepts`
FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
  INNER JOIN `criteria` ON `periods`.`criteria_id` = `criteria`.`id`
WHERE `school_structures`.`deleted_at` IS NULL
      AND `type` = 'Period'
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `school_structures`.`name`,
  `periods`.*
FROM `school_structures`
  INNER JOIN `periods` ON `school_structures`.`id` = `periods`.`structure_id`
WHERE `school_structures`.`deleted_at` IS NULL
      AND `type` = 'Period'
      AND `parent` IN (SELECT `ancestor`
                       FROM `heritages`
                       WHERE `structure_id` = 202)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.`registration_id`   AS `prevRegistration_registration_id`,
  `student_registration`.`schoolyear_id`     AS `prevRegistration_schoolyear_id`,
  `student_registration`.`site_id`           AS `prevRegistration_site_id`,
  `student_registration`.`level_id`          AS `prevRegistration_level_id`,
  `student_registration`.`degree_id`         AS `prevRegistration_degree_id`,
  `student_registration`.`group_id`          AS `prevRegistration_group_id`,
  `student_registration`.`list_in`           AS `prevRegistration_list_in`,
  `student_registration`.`student_id`,
  `student_registration`.`school_enrollment` AS `prevRegistration_school_enrollment`,
  `student_registration`.`status`            AS `prevRegistration_status`,
  `student_registration`.`updated_at`        AS `prevRegistration_updated_at`,
  `student_registration`.`tutor`             AS `prevRegistration_tutor`,
  `nextRegistration`.`registration_id`       AS `nextRegistration_registration_id`,
  `nextRegistration`.`schoolyear_id`         AS `nextRegistration_schoolyear_id`,
  `nextRegistration`.`site_id`               AS `nextRegistration_site_id`,
  `nextRegistration`.`level_id`              AS `nextRegistration_level_id`,
  `nextRegistration`.`degree_id`             AS `nextRegistration_degree_id`,
  `nextRegistration`.`group_id`              AS `nextRegistration_group_id`,
  `nextRegistration`.`list_in`               AS `nextRegistration_list_in`,
  `nextRegistration`.`status`                AS `nextRegistration_status`
FROM `student_registration`
  INNER JOIN `degrees` ON `student_registration`.`degree_id` = `degrees`.`structure_id`
  INNER JOIN `student_registration` AS `nextRegistration`
    ON `student_registration`.`student_id` = `nextRegistration`.`student_id` AND
       `nextRegistration`.`schoolyear_id` = 316
WHERE `student_registration`.`schoolyear_id` = 288
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.`registration_id`   AS `prevRegistration_registration_id`,
  `student_registration`.`schoolyear_id`     AS `prevRegistration_schoolyear_id`,
  `student_registration`.`site_id`           AS `prevRegistration_site_id`,
  `student_registration`.`level_id`          AS `prevRegistration_level_id`,
  `student_registration`.`degree_id`         AS `prevRegistration_degree_id`,
  `student_registration`.`group_id`          AS `prevRegistration_group_id`,
  `student_registration`.`list_in`           AS `prevRegistration_list_in`,
  `student_registration`.`student_id`,
  `student_registration`.`school_enrollment` AS `prevRegistration_school_enrollment`,
  `student_registration`.`status`            AS `prevRegistration_status`,
  `student_registration`.`updated_at`        AS `prevRegistration_updated_at`,
  `student_registration`.`tutor`             AS `prevRegistration_tutor`,
  `nextRegistration`.`registration_id`       AS `nextRegistration_registration_id`,
  `nextRegistration`.`schoolyear_id`         AS `nextRegistration_schoolyear_id`,
  `nextRegistration`.`site_id`               AS `nextRegistration_site_id`,
  `nextRegistration`.`level_id`              AS `nextRegistration_level_id`,
  `nextRegistration`.`degree_id`             AS `nextRegistration_degree_id`,
  `nextRegistration`.`group_id`              AS `nextRegistration_group_id`,
  `nextRegistration`.`list_in`               AS `nextRegistration_list_in`,
  `nextRegistration`.`status`                AS `nextRegistration_status`
FROM `student_registration`
  INNER JOIN `degrees` ON `student_registration`.`degree_id` = `degrees`.`structure_id`
  INNER JOIN `student_registration` AS `nextRegistration`
    ON `student_registration`.`student_id` = `nextRegistration`.`student_id` AND
       `nextRegistration`.`schoolyear_id` = 288
WHERE `student_registration`.`schoolyear_id` = 316
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.`registration_id`   AS `prevRegistration_registration_id`,
  `student_registration`.`schoolyear_id`     AS `prevRegistration_schoolyear_id`,
  `student_registration`.`site_id`           AS `prevRegistration_site_id`,
  `student_registration`.`level_id`          AS `prevRegistration_level_id`,
  `student_registration`.`degree_id`         AS `prevRegistration_degree_id`,
  `student_registration`.`group_id`          AS `prevRegistration_group_id`,
  `student_registration`.`list_in`           AS `prevRegistration_list_in`,
  `student_registration`.`student_id`,
  `student_registration`.`school_enrollment` AS `prevRegistration_school_enrollment`,
  `student_registration`.`status`            AS `prevRegistration_status`,
  `student_registration`.`updated_at`        AS `prevRegistration_updated_at`,
  `student_registration`.`tutor`             AS `prevRegistration_tutor`,
  `nextRegistration`.`registration_id`       AS `nextRegistration_registration_id`,
  `nextRegistration`.`schoolyear_id`         AS `nextRegistration_schoolyear_id`,
  `nextRegistration`.`site_id`               AS `nextRegistration_site_id`,
  `nextRegistration`.`level_id`              AS `nextRegistration_level_id`,
  `nextRegistration`.`degree_id`             AS `nextRegistration_degree_id`,
  `nextRegistration`.`group_id`              AS `nextRegistration_group_id`,
  `nextRegistration`.`list_in`               AS `nextRegistration_list_in`,
  `nextRegistration`.`status`                AS `nextRegistration_status`
FROM `student_registration`
  INNER JOIN `degrees` ON `student_registration`.`degree_id` = `degrees`.`structure_id`
  INNER JOIN `student_registration` AS `nextRegistration`
    ON `student_registration`.`student_id` = `nextRegistration`.`student_id` AND
       `nextRegistration`.`schoolyear_id` = 288
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.`registration_id`   AS `prevRegistration_registration_id`,
  `student_registration`.`schoolyear_id`     AS `prevRegistration_schoolyear_id`,
  `student_registration`.`site_id`           AS `prevRegistration_site_id`,
  `student_registration`.`level_id`          AS `prevRegistration_level_id`,
  `student_registration`.`degree_id`         AS `prevRegistration_degree_id`,
  `student_registration`.`group_id`          AS `prevRegistration_group_id`,
  `student_registration`.`list_in`           AS `prevRegistration_list_in`,
  `student_registration`.`student_id`,
  `student_registration`.`school_enrollment` AS `prevRegistration_school_enrollment`,
  `student_registration`.`status`            AS `prevRegistration_status`,
  `student_registration`.`updated_at`        AS `prevRegistration_updated_at`,
  `student_registration`.`tutor`             AS `prevRegistration_tutor`,
  `nextRegistration`.`registration_id`       AS `nextRegistration_registration_id`,
  `nextRegistration`.`schoolyear_id`         AS `nextRegistration_schoolyear_id`,
  `nextRegistration`.`site_id`               AS `nextRegistration_site_id`,
  `nextRegistration`.`level_id`              AS `nextRegistration_level_id`,
  `nextRegistration`.`degree_id`             AS `nextRegistration_degree_id`,
  `nextRegistration`.`group_id`              AS `nextRegistration_group_id`,
  `nextRegistration`.`list_in`               AS `nextRegistration_list_in`,
  `nextRegistration`.`status`                AS `nextRegistration_status`
FROM `student_registration`
  INNER JOIN `degrees` ON `student_registration`.`degree_id` = `degrees`.`structure_id`
  INNER JOIN `student_registration` AS `nextRegistration`
    ON `student_registration`.`student_id` = `nextRegistration`.`student_id` AND
       `nextRegistration`.`schoolyear_id` = 316
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_registration`.`registration_id`   AS `prevRegistration_registration_id`,
  `student_registration`.`schoolyear_id`     AS `prevRegistration_schoolyear_id`,
  `student_registration`.`site_id`           AS `prevRegistration_site_id`,
  `student_registration`.`level_id`          AS `prevRegistration_level_id`,
  `student_registration`.`degree_id`         AS `prevRegistration_degree_id`,
  `student_registration`.`group_id`          AS `prevRegistration_group_id`,
  `student_registration`.`list_in`           AS `prevRegistration_list_in`,
  `student_registration`.`student_id`,
  `student_registration`.`school_enrollment` AS `prevRegistration_school_enrollment`,
  `student_registration`.`status`            AS `prevRegistration_status`,
  `student_registration`.`updated_at`        AS `prevRegistration_updated_at`,
  `student_registration`.`tutor`             AS `prevRegistration_tutor`,
  `nextRegistration`.`registration_id`       AS `nextRegistration_registration_id`,
  `nextRegistration`.`schoolyear_id`         AS `nextRegistration_schoolyear_id`,
  `nextRegistration`.`site_id`               AS `nextRegistration_site_id`,
  `nextRegistration`.`level_id`              AS `nextRegistration_level_id`,
  `nextRegistration`.`degree_id`             AS `nextRegistration_degree_id`,
  `nextRegistration`.`group_id`              AS `nextRegistration_group_id`,
  `nextRegistration`.`list_in`               AS `nextRegistration_list_in`,
  `nextRegistration`.`status`                AS `nextRegistration_status`
FROM `student_registration`
  INNER JOIN `degrees` ON `student_registration`.`degree_id` = `degrees`.`structure_id`
  INNER JOIN `student_registration` AS `nextRegistration`
    ON `student_registration`.`student_id` = `nextRegistration`.`student_id` AND
       `nextRegistration`.`schoolyear_id` = 316
WHERE `student_registration`.`schoolyear_id` = 288 AND `student_registration`.`status` IN (
  "Activo",
  "Baja temporal",
  "Condicionado",
  "Retenido",
  "Suspendido",
  "Pendiente"
) AND `nextRegistration`.`status` NOT IN ("Egresado", "Activo")
;-- -. . -..- - / . -. - .-. -.--
UPDATE grading_periods SET status = 1 WHERE id=71
;-- -. . -..- - / . -. - .-. -.--
UPDATE grading_periods SET status = 2 WHERE id=71
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM schoolyears
LEFT JOIN school_structures ON school_structures.id = schoolyears.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `schoolyears`
  INNER JOIN `school_structures` ON `school_structures`.`master` = `schoolyears`.`structure_id`
WHERE `schoolyears`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `schoolyears`
  INNER JOIN `school_structures` ON `school_structures`.`master` = `schoolyears`.`structure_id`
WHERE `schoolyears`.`deleted_at` IS NULL AND `status` = 'Activo'
;-- -. . -..- - / . -. - .-. -.--
SELECT subtype
FROM messages
;-- -. . -..- - / . -. - .-. -.--
SELECT subtype
FROM messages
GROUP BY subtype