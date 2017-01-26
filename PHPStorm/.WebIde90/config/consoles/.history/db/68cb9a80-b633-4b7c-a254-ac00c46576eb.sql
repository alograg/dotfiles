SELECT *
FROM invoices
WHERE FIND_IN_SET('public',type)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM invoices
WHERE !FIND_IN_SET('public',type)
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `payments`
WHERE `payments`.`id` IN
      (26749, 24059, 27875, 28380, 26241, 24932, 24564, 24981, 26747, 34770, 35126, 34061, 33089, 36009, 35468, 36424, 36847, 36735, 36736, 36422, 5729, 7532, 4579, 4998, 6285, 7150, 4533, 7548, 175, 1277, 1219, 721, 632, 6498, 2172, 4657, 3252, 3059, 2996, 2661, 3389, 1859, 3519, 3555, 3631, 3764, 2485, 16744, 10602, 10905, 11453, 12239, 12588, 13256, 10233, 13642, 18835, 17066, 18006, 18289, 20486, 19558, 20112, 20294, 20345, 25922, 28370, 27804, 26731, 25615, 24970, 24557, 24058, 33894, 35596, 36008, 34827, 33088, 36423, 36848, 6286, 1278, 1860, 2173, 2486, 487, 633, 762, 2662, 1220, 3002, 3520, 3390, 3556, 3630, 2748, 7533, 3060, 7549, 3817, 4859, 5955, 7122, 3251, 4800, 16743, 13643, 13257, 13044, 12589, 12240, 12217, 11454, 10906, 10604, 10234, 19003, 17067, 18007, 20485, 18836, 20113, 20295, 20344, 10603, 19559, 69538, 69600, 69829, 68867, 69063, 70165, 70588, 66869, 68049, 65654, 65970, 71171)
      AND `invoice_id` NOT IN (SELECT `id`
                               FROM `invoices`
                               WHERE !FIND_IN_SET('public', type)) AND
      `payments`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_tuition_detail`.*,
  CONCAT_WS('-', 'concept', student_id, tuition_id, payment_index, payment_time) AS concept
FROM `student_tuition_detail`
WHERE `student_id` IN ('2659', '2660', '4369') AND
      IF('tuition_type' = 'tuition', expected_at < '2016-05-01 00:00:00', TRUE) AND
      `student_tuition_detail`.`deleted_at` IS NULL
ORDER BY `id` DESC
LIMIT 1500 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  IF('tuition_type' = 'tuition', expected_at < '2016-05-01 00:00:00', TRUE) AS display,
  `student_tuition_detail`.*,
  CONCAT_WS('-', 'concept', student_id, tuition_id, payment_index, payment_time) AS concept
FROM `student_tuition_detail`
WHERE `student_id` IN ('2659', '2660', '4369') AND
      IF('tuition_type' = 'tuition', expected_at < '2016-05-01 00:00:00', TRUE) AND
      `student_tuition_detail`.`deleted_at` IS NULL
ORDER BY `id` DESC
LIMIT 1500 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  IF(tuition_type = 'tuition', expected_at < '2016-05-01 00:00:00', TRUE) AS display,
  `student_tuition_detail`.*,
  CONCAT_WS('-', 'concept', student_id, tuition_id, payment_index, payment_time) AS concept
FROM `student_tuition_detail`
WHERE `student_id` IN ('2659', '2660', '4369') AND
      IF(tuition_type = 'tuition', expected_at < '2016-05-01 00:00:00', TRUE) AND
      `student_tuition_detail`.`deleted_at` IS NULL
ORDER BY `id` DESC
LIMIT 1500 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_grades`.*,
  `period_id`,
  `ancestor`
FROM `student_grades`
  INNER JOIN `grading_periods` ON `grading_periods`.`id` = `grading_period`
  INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE `student_id` = '2623,2638' AND `grading_periods`.`status` = 'published' AND
      `ancestor` IN ('34', '173') AND `student_grades`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `student_grades`.*,
  `period_id`,
  `ancestor`
FROM `student_grades`
  INNER JOIN `grading_periods` ON `grading_periods`.`id` = `grading_period`
  INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE `student_id` = 2893 AND `grading_periods`.`status` = 'published' AND `ancestor` IN (34,173) AND
      `student_grades`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT
  grading_periods.*,
  `student_grades`.*,
  `period_id`,
  `ancestor`
FROM `student_grades`
  INNER JOIN `grading_periods` ON `grading_periods`.`id` = `grading_period`
  INNER JOIN `heritages` ON `grading_periods`.`period_id` = `heritages`.`structure_id`
WHERE `student_id` = 2893 AND `ancestor` IN (34,173) AND
      `student_grades`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM `teachers` WHERE `people_id` = '2125' LIMIT 1
;-- -. . -..- - / . -. - .-. -.--
SELECT max(`created_at`) as aggregate FROM messages
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\Models\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\Models\SchoolStructure' AND `target_id` IN
                                                           ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')))
      AND `type` != 'notices' AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\Models\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\Models\SchoolStructure' AND `target_id` IN
                                                           ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')))
      AND `type` != 'notices' AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT student_registration.*, tuition_type
FROM student_registration
  LEFT JOIN student_tuition_detail ON student_registration.student_id = student_tuition_detail
  .student_id
                                      AND student_registration.schoolyear_id =
                                          student_tuition_detail.schoolyear_id

WHERE tuition_type = 'inscription'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                           ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')))
      AND `type` != 'notices' AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1085')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             ('34',
                                                              '42',
                                                              '58',
                                                              '62',
                                                              '71',
                                                              '198',
                                                              '199',
                                                              '215',
                                                              '228',
                                                              '48',
                                                              '51',
                                                              '56', '216')))
      AND `type` != 'notices' AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198,199,204,208)))
      AND `type` != 'notices' AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208)))
      AND messages.only_new_entry = 0
      AND `type` != 'notices' AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208)))
      AND messages.only_new_entry = 0
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208)))
      AND messages.only_new_entry = 1
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208)))
      AND messages.only_new_entry = 0
      AND `messages`.`deleted_at` IS NULL
union
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208)))
      AND messages.only_new_entry = 1
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208)))
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM students_inscriptions
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM students_inscriptions
WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW *
FROM students_inscriptions
WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW schoolyear_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW site_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW level_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW degree_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW group
FROM students_inscriptions
WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW schoolyear_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW site_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW level_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW degree_id
FROM students_inscriptions
UNION 
SELECT DISTINCTROW group_id
FROM students_inscriptions
WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW schoolyear_id
FROM students_inscriptions
    WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
UNION 
SELECT DISTINCTROW site_id
FROM students_inscriptions
    WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
UNION 
SELECT DISTINCTROW level_id
FROM students_inscriptions
    WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
UNION 
SELECT DISTINCTROW degree_id
FROM students_inscriptions
    WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
UNION 
SELECT DISTINCTROW group_id
FROM students_inscriptions
WHERE student_id IN (SELECT `people_id`
                    FROM `family_people`
                    WHERE `family_id` IN ('1462'))
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208))
       AND only_new_entry = 0)
      OR
      (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                            (
                                                              SELECT DISTINCTROW schoolyear_id
                                                              FROM students_inscriptions
                                                              WHERE
                                                                student_id IN (SELECT `people_id`
                                                                               FROM `family_people`
                                                                               WHERE `family_id` IN
                                                                                     ('1462'))
                                                              UNION
                                                              SELECT DISTINCTROW site_id
                                                              FROM students_inscriptions
                                                              WHERE
                                                                student_id IN (SELECT `people_id`
                                                                               FROM `family_people`
                                                                               WHERE `family_id` IN
                                                                                     ('1462'))
                                                              UNION
                                                              SELECT DISTINCTROW level_id
                                                              FROM students_inscriptions
                                                              WHERE
                                                                student_id IN (SELECT `people_id`
                                                                               FROM `family_people`
                                                                               WHERE `family_id` IN
                                                                                     ('1462'))
                                                              UNION
                                                              SELECT DISTINCTROW degree_id
                                                              FROM students_inscriptions
                                                              WHERE
                                                                student_id IN (SELECT `people_id`
                                                                               FROM `family_people`
                                                                               WHERE `family_id` IN
                                                                                     ('1462'))
                                                              UNION
                                                              SELECT DISTINCTROW group_id
                                                              FROM students_inscriptions
                                                              WHERE
                                                                student_id IN (SELECT `people_id`
                                                                               FROM `family_people`
                                                                               WHERE `family_id` IN
                                                                                     ('1462'))
                                                            )
       AND only_new_entry = 1)
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '4853'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                    FROM `family_people`
                                                                    WHERE `family_id` IN ('1462')))
       OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN
                                                             (198, 199, 204, 208))
       AND only_new_entry = 0)
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\Models\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\Models\SchoolStructure' AND `target_id` IN (SELECT *
                                                                           FROM (SELECT DISTINCTROW
                                                                                   schoolyear_id
                                                                                 FROM
                                                                                   students_inscriptions
                                                                                 WHERE student_id IN
                                                                                       (SELECT
                                                                                          people_id
                                                                                        FROM
                                                                                          family_people
                                                                                        WHERE
                                                                                          family_id
                                                                                          IN (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         site_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         level_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         degree_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         group_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))) AS filter)
        AND `only_new_entry` = '1') OR (`target_type` = 'Orama\Models\SchoolStructure' AND
                                        `target_id` IN
                                        ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')
                                        AND `only_new_entry` = '0')) AND `type` = 'notices' AND
      `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\Models\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\Models\SchoolStructure' AND `target_id` IN (SELECT *
                                                                           FROM (SELECT DISTINCTROW
                                                                                   schoolyear_id
                                                                                 FROM
                                                                                   students_inscriptions
                                                                                 WHERE student_id IN
                                                                                       (SELECT
                                                                                          people_id
                                                                                        FROM
                                                                                          family_people
                                                                                        WHERE
                                                                                          family_id
                                                                                          IN (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         site_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         level_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         degree_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         group_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))) AS filter)
        AND `only_new_entry` = '1') OR (`target_type` = 'Orama\Models\SchoolStructure' AND
                                        `target_id` IN
                                        ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')
                                        AND `only_new_entry` = '0')) AND
      `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\Models\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\Models\SchoolStructure' AND `target_id` IN (SELECT *
                                                                           FROM (SELECT DISTINCTROW
                                                                                   schoolyear_id
                                                                                 FROM
                                                                                   students_inscriptions
                                                                                 WHERE student_id IN
                                                                                       (SELECT
                                                                                          people_id
                                                                                        FROM
                                                                                          family_people
                                                                                        WHERE
                                                                                          family_id
                                                                                          IN (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         site_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         level_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         degree_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         group_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))) AS filter)
        AND `only_new_entry` = '1')
       OR (`target_type` = 'Orama\Models\SchoolStructure' AND
                                        `target_id` IN
                                        ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')
                                        AND `only_new_entry` = '0'))
      AND `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\Models\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\Models\SchoolStructure' AND `target_id` IN (SELECT *
                                                                           FROM (SELECT DISTINCTROW
                                                                                   schoolyear_id
                                                                                 FROM
                                                                                   students_inscriptions
                                                                                 WHERE student_id IN
                                                                                       (SELECT
                                                                                          people_id
                                                                                        FROM
                                                                                          family_people
                                                                                        WHERE
                                                                                          family_id
                                                                                          IN (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         site_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         level_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         degree_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         group_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))) AS filter)
        AND `only_new_entry` = '1') OR (`target_type` = 'Orama\Models\SchoolStructure' AND
                                        `target_id` IN
                                        ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')
                                        AND `only_new_entry` = '0')) AND `type` != 'notices' AND
      `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `messages`.*,
  IFNULL(message_statuses.status + 0, 0) < 1 AS is_new
FROM `messages`
  LEFT JOIN `message_statuses`
    ON `messages`.`id` = `message_statuses`.`message_id` AND `people_id` = '2169'
WHERE (`start_at` IS NULL OR `start_at` <= '2016-06-03') AND
      (`end_at` IS NULL OR `end_at` >= '2016-06-03') AND
      ((`target_type` = 'Orama\\Models\\People' AND `target_id` IN (SELECT `people_id`
                                                                  FROM `family_people`
                                                                  WHERE `family_id` IN ('1085'))) OR
       (`target_type` = 'Orama\\Models\\SchoolStructure' AND `target_id` IN (SELECT *
                                                                           FROM (SELECT DISTINCTROW
                                                                                   schoolyear_id
                                                                                 FROM
                                                                                   students_inscriptions
                                                                                 WHERE student_id IN
                                                                                       (SELECT
                                                                                          people_id
                                                                                        FROM
                                                                                          family_people
                                                                                        WHERE
                                                                                          family_id
                                                                                          IN (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         site_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         level_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         degree_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))
                                                                                 UNION SELECT
                                                                                         DISTINCTROW
                                                                                         group_id
                                                                                       FROM
                                                                                         students_inscriptions
                                                                                       WHERE
                                                                                         student_id
                                                                                         IN (SELECT
                                                                                               people_id
                                                                                             FROM
                                                                                               family_people
                                                                                             WHERE
                                                                                               family_id
                                                                                               IN
                                                                                               (1085))) AS filter)
        AND `only_new_entry` = '1') OR (`target_type` = 'Orama\\Models\\SchoolStructure' AND
                                        `target_id` IN
                                        ('34', '42', '58', '62', '71', '198', '199', '215', '228', '48', '51', '56', '216')
                                        AND `only_new_entry` = '0')) AND `type` != 'notices' AND
      `messages`.`deleted_at` IS NULL
ORDER BY IFNULL(start_at, messages.created_at) DESC, `id` DESC
LIMIT 25 OFFSET 0