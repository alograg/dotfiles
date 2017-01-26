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
) AND `nextRegistration`.`status` NOT IN ("Egresado", "Activo");

SELECT *
FROM schoolyears
  LEFT JOIN school_structures ON school_structures.id = schoolyears.structure_id;


SELECT *
FROM `schoolyears`
  INNER JOIN `school_structures` ON `school_structures`.`master` = `schoolyears`.`structure_id`
WHERE `schoolyears`.`deleted_at` IS NULL AND `status` = 'Activo';

SELECT subtype
FROM messages
GROUP BY subtype
