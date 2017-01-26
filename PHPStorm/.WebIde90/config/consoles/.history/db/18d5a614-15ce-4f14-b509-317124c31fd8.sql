SELECT *
FROM student_tuitions
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM study_plan
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE %tena% OR `second_name` LIKE %tena% OR `first_name` LIKE %tena% OR `tax_id` LIKE %tena% OR `school_enrollment` LIKE %tena%) UNION (SELECT DISTINCT `id`, `first_name`, `second_name`, "family" AS names, "" AS tax_id, 'family' AS findType, '' AS school_enrollment FROM `families` HAVING `second_name` LIKE %tena% OR `first_name` LIKE %tena% OR `tax_id` LIKE %tena%) UNION (SELECT DISTINCT `id`, `first_name`, `second_name`, `names`, `tax_id`, 'people' AS findType, '' AS school_enrollment FROM `people` HAVING `names` LIKE %tena% OR `second_name` LIKE %tena% OR `first_name` LIKE %tena% OR `tax_id` LIKE %tena%) UNION (SELECT DISTINCT `teachers`.`people_id`, `first_name`, `second_name`, `names`, `tax_id`, 'teacher' AS findType, '' AS school_enrollment FROM `teachers` LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE %tena% OR `second_name` LIKE %tena% OR `first_name` LIKE %tena % OR `tax_id` LIKE % tena %
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%') UNION (SELECT DISTINCT `id`, `first_name`, `second_name`, "family" AS names, "" AS tax_id, 'family' AS findType, '' AS school_enrollment FROM `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%') UNION (SELECT DISTINCT `id`, `first_name`, `second_name`, `names`, `tax_id`, 'people' AS findType, '' AS school_enrollment FROM `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%') UNION (SELECT DISTINCT `teachers`.`people_id`, `first_name`, `second_name`, `names`, `tax_id`, 'teacher' AS findType, '' AS school_enrollment FROM `teachers` LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE %tena % OR `tax_id` LIKE % tena %
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR 
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%') UNION (SELECT DISTINCT `id`, `first_name`, `second_name`, "family" AS names, "" AS tax_id, 'family' AS findType, '' AS school_enrollment FROM `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%') UNION (SELECT DISTINCT `id`, `first_name`, `second_name`, `names`, `tax_id`, 'people' AS findType, '' AS school_enrollment FROM `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%') UNION (SELECT DISTINCT `teachers`.`people_id`, `first_name`, `second_name`, `names`, `tax_id`, 'teacher' AS findType, '' AS school_enrollment FROM `teachers` LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE %tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido"
       LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
       LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
       WHERE `students`.`deleted_at` IS NULL
       HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
       `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         "family" AS names,
         ""       AS tax_id,
         'family' AS findType,
         ''       AS school_enrollment
       FROM
         `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'people' AS findType,
         ''       AS school_enrollment
       FROM
         `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `teachers`.`people_id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'teacher' AS findType,
         ''        AS school_enrollment
       FROM `teachers`
         LEFT JOIN `people` ON `people`.`id` =
                               `teachers`.`people_id` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE % tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido"
       LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
       LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
       WHERE `students`.`deleted_at` IS NULL
       HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
       `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         "family" AS names,
         ""       AS tax_id,
         'family' AS findType,
         ''       AS school_enrollment
       FROM
         `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'people' AS findType,
         ''       AS school_enrollment
       FROM
         `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `teachers`.`people_id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'teacher' AS findType,
         ''        AS school_enrollment
       FROM `teachers`
         LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id`)
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE % tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
       LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
       LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
       WHERE `students`.`deleted_at` IS NULL
       HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
       `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         "family" AS names,
         ""       AS tax_id,
         'family' AS findType,
         ''       AS school_enrollment
       FROM
         `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'people' AS findType,
         ''       AS school_enrollment
       FROM
         `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `teachers`.`people_id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'teacher' AS findType,
         ''        AS school_enrollment
       FROM `teachers`
         LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE 
       '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE % tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
"family" AS names,
"" AS tax_id,
'family' AS findType,
'' AS school_enrollment
FROM
`families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'people' AS findType,'' AS school_enrollment
FROM
`people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`teachers`.`people_id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'teacher' AS findType,
'' AS school_enrollment
FROM `teachers`
LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE
'%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE % tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
(SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
"family" AS names,
"" AS tax_id,
'family' AS findType,
'' AS school_enrollment
FROM
`families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'people' AS findType,'' AS school_enrollment
FROM
`people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`teachers`.`people_id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'teacher' AS findType,
'' AS school_enrollment
FROM `teachers`
LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE
'%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE % tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%'
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
"family" AS names,
"" AS tax_id,
'family' AS findType,
'' AS school_enrollment
FROM
`families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'people' AS findType,'' AS school_enrollment
FROM
`people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`teachers`.`people_id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'teacher' AS findType,
'' AS school_enrollment
FROM `teachers`
LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE
'%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE % tena % OR `tax_id` LIKE % tena %)
;-- -. . -..- - / . -. - .-. -.--
(select distinct `registrations`.`student_id` as `id`, `first_name`, `second_name`, `names`, `tax_id`, 'student' as findType, `school_enrollment` from `students` inner join `student_registration` on `students`.`people_id` = `student_registration`.`people_id` and `status` IN ("Activo","Baja temporal","Condicionado","Suspendido") left join `group_student` on `student_registration`.`student_id` = `group_student`.`student_id` left join `people` on `students`.`people_id` = `people`.`id` where `students`.`deleted_at` is null having `names` LIKE %tena% or `second_name` LIKE %tena% or `first_name` LIKE %tena% or `tax_id` LIKE %tena% or `school_enrollment` LIKE %tena%) union (select distinct `id`, `first_name`, `second_name`, "family" as names, "" as tax_id, 'family' as findType, '' as school_enrollment from `families` having `second_name` LIKE %tena% or `first_name` LIKE %tena% or `tax_id` LIKE %tena%) union (select distinct `id`, `first_name`, `second_name`, `names`, `tax_id`, 'people' as findType, '' as school_enrollment from `people` having `names` LIKE %tena% or `second_name` LIKE %tena% or `first_name` LIKE %tena% or `tax_id` LIKE %tena%) union (select distinct `teachers`.`people_id`, `first_name`, `second_name`, `names`, `tax_id`, 'teacher' as findType, '' as school_enrollment from `teachers` left join `people` on `people`.`id` = `teachers`.`people_id` having `names` LIKE %tena% or `second_name` LIKE %tena% or `first_name` LIKE %tena% or `tax_id` LIKE %tena%))"SELECT DISTINCT
  `registrations`.`student_id` AS `id`,
  `first_name`,
  `second_name`,
  `names`,
  `tax_id`,
  'student'                    AS findType,
  `school_enrollment`
FROM `students`
  INNER JOIN `student_registration`
    ON `students`.`people_id` = `student_registration`.`people_id` AND
       `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
  LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
  LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%'
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
"family" AS names,
"" AS tax_id,
'family' AS findType,
'' AS school_enrollment
FROM
`families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'people' AS findType,'' AS school_enrollment
FROM
`people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`teachers`.`people_id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'teacher' AS findType,
'' AS school_enrollment
FROM `teachers`
LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE
'%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
;-- -. . -..- - / . -. - .-. -.--
(SELECT DISTINCT
   `registrations`.`student_id` AS `id`,
   `first_name`,
   `second_name`,
   `names`,
   `tax_id`,
   'student'                    AS findType,
   `school_enrollment`
 FROM `students`
   INNER JOIN `student_registration`
     ON `students`.`people_id` = `student_registration`.`people_id` AND
        `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
   LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
   LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
 WHERE `students`.`deleted_at` IS
       NULL HAVING `names` LIKE %tena% OR `second_name` LIKE %tena% OR `first_name` LIKE %tena% OR `tax_id` LIKE % tena % OR `school_enrollment` LIKE % tena %)
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         "family" AS names,
         ""       AS tax_id,
         'family' AS findType,
         ''       AS school_enrollment
       FROM
         `families` HAVING `second_name` LIKE %tena% OR `first_name` LIKE %tena % OR `tax_id` LIKE % tena %)
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'people' AS findType,
         ''       AS school_enrollment
       FROM
         `people` HAVING `names` LIKE %tena% OR `second_name` LIKE %tena% OR `first_name` LIKE %tena% OR `tax_id` LIKE % tena %)
UNION (SELECT DISTINCT
         `teachers`.`people_id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'teacher' AS findType,
         ''        AS school_enrollment
       FROM `teachers`
         LEFT JOIN `people` ON `people`.`id` =
                               `teachers`.`people_id` HAVING `names` LIKE %tena% OR `second_name` LIKE %tena% OR `first_name` LIKE %tena% OR `tax_id` LIKE % tena %))"SELECT DISTINCT
`registrations`.`student_id` AS `id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'student' AS findType,
`school_enrollment`
FROM `students`
INNER JOIN `student_registration`
ON `students`.`people_id` = `student_registration`.`people_id` AND
`status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%'
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
"family" AS names,
"" AS tax_id,
'family' AS findType,
'' AS school_enrollment
FROM
`families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'people' AS findType, '' AS school_enrollment
FROM
`people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`teachers`.`people_id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'teacher' AS findType,
'' AS school_enrollment
FROM `teachers`
LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE
'%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
;-- -. . -..- - / . -. - .-. -.--
(SELECT DISTINCT
   `registrations`.`student_id` AS `id`,
   `first_name`,
   `second_name`,
   `names`,
   `tax_id`,
   'student'                    AS findType,
   `school_enrollment`
 FROM `students`
   INNER JOIN `student_registration`
     ON `students`.`people_id` = `student_registration`.`people_id` AND
        `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
   LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
   LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
 WHERE `students`.`deleted_at` IS
       NULL HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE % tena % OR `school_enrollment` LIKE % tena %)
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         "family" AS names,
         ""       AS tax_id,
         'family' AS findType,
         ''       AS school_enrollment
       FROM
         `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE %tena % OR `tax_id` LIKE % tena %)
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'people' AS findType,
         ''       AS school_enrollment
       FROM
         `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE % tena %)
UNION (SELECT DISTINCT
         `teachers`.`people_id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'teacher' AS findType,
         ''        AS school_enrollment
       FROM `teachers`
         LEFT JOIN `people` ON `people`.`id` =
                               `teachers`.`people_id` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE % tena %))"SELECT DISTINCT
`registrations`.`student_id` AS `id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'student' AS findType,
`school_enrollment`
FROM `students`
INNER JOIN `student_registration`
ON `students`.`people_id` = `student_registration`.`people_id` AND
`status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
WHERE `students`.`deleted_at` IS NULL
HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR
`tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%'
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
"family" AS names,
"" AS tax_id,
'family' AS findType,
'' AS school_enrollment
FROM
`families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'people' AS findType, '' AS school_enrollment
FROM
`people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
`teachers`.`people_id`,
`first_name`,
`second_name`,
`names`,
`tax_id`,
'teacher' AS findType,
'' AS school_enrollment
FROM `teachers`
LEFT JOIN `people` ON `people`.`id` = `teachers`.`people_id` HAVING `names` LIKE
'%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
;-- -. . -..- - / . -. - .-. -.--
(SELECT DISTINCT
   `registrations`.`student_id` AS `id`,
   `first_name`,
   `second_name`,
   `names`,
   `tax_id`,
   'student'                    AS findType,
   `school_enrollment`
 FROM `students`
   INNER JOIN `student_registration`
     ON `students`.`people_id` = `student_registration`.`people_id` AND
        `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
   LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
   LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
 WHERE `students`.`deleted_at` IS
       NULL HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         "family" AS names,
         ""       AS tax_id,
         'family' AS findType,
         ''       AS school_enrollment
       FROM
         `families` HAVING `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'people' AS findType,
         ''       AS school_enrollment
       FROM
         `people` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
UNION (SELECT DISTINCT
         `teachers`.`people_id`,
         `first_name`,
         `second_name`,
         `names`,
         `tax_id`,
         'teacher' AS findType,
         ''        AS school_enrollment
       FROM `teachers`
         LEFT JOIN `people` ON `people`.`id` =
                               `teachers`.`people_id` HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%')
;-- -. . -..- - / . -. - .-. -.--
(SELECT DISTINCT
   `registrations`.`student_id` AS `id`,
   `first_name`,
   `second_name`,
   `names`,
   `tax_id`,
   'student'                    AS findType,
   `school_enrollment`
 FROM `students`
   INNER JOIN `student_registration`
     ON `students`.`people_id` = `student_registration`.`people_id` AND
        `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
   LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
   LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
 WHERE `students`.`deleted_at` IS
       NULL HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
   `registrations`.`student_id` AS `id`,
   `first_name`,
   `second_name`,
   `names`,
   `tax_id`,
   'student'                    AS findType,
   `school_enrollment`
 FROM `students`
   INNER JOIN `student_registration`
     ON `students`.`people_id` = `student_registration`.`people_id` AND
        `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
   LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
   LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
 WHERE `students`.`deleted_at` IS
       NULL HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%')
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
   `registrations`.`student_id` AS `id`,
   `first_name`,
   `second_name`,
   `names`,
   `tax_id`,
   'student'                    AS findType,
   `school_enrollment`
 FROM `students`
   INNER JOIN `student_registration`
     ON `students`.`people_id` = `student_registration`.`people_id` AND
        `status` IN ("Activo", "Baja temporal", "Condicionado", "Suspendido")
   LEFT JOIN `group_student` ON `student_registration`.`student_id` = `group_student`.`student_id`
   LEFT JOIN `people` ON `students`.`people_id` = `people`.`id`
 WHERE `students`.`deleted_at` IS
       NULL HAVING `names` LIKE '%tena%' OR `second_name` LIKE '%tena%' OR `first_name` LIKE '%tena%' OR `tax_id` LIKE '%tena%' OR `school_enrollment` LIKE '%tena%'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_grades`.*,
  `period_id`,
  `ancestor`
FROM `student_grades`
  INNER JOIN `grading_periods` ON `grading_periods`.`id` = `grading_period`
  INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE `student_grades`.`deleted_at` IS NULL AND `student_id` = '3179' AND
      `grading_periods`.`status` = 'published' AND `ancestor` IN ('34', '173')
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
JOIN schoolyears ON student_registration.schoolyear_id = schoolyears.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_tuition_detail