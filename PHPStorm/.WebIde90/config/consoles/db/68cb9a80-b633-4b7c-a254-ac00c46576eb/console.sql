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