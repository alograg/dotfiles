REPLACE INTO teachers_criteria (
  subject_id,
  assigned_id,
  assigned_type
)
  SELECT
    oramalocal.plan_subjects.subject_id,
    oramalocal.plan_subjects.subject_group_id,
    'Modules\\Schools\\Structures\\Models\\SubjectGroup'
  FROM oramalocal.plan_subjects
  WHERE oramalocal.plan_subjects.subject_group_id IN (SELECT structures_subjects.structure_id
                                                      FROM structures_subjects)
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_groups (
  structure_id,
  facility_id,
  study_branch_id,
  scope,
  short_name,
  responsible
)
  SELECT
    oramalocal.school_groups.structure_id,
    oramalocal.school_groups.facility_id,
    CASE oramalocal.school_groups.study_branch_id
    WHEN 196
      THEN 156
    WHEN 283
      THEN 136
    WHEN 288
      THEN 156
    WHEN 311
      THEN 156
    ELSE oramalocal.school_groups.study_branch_id
    END,
    oramalocal.school_groups.scope,
    oramalocal.school_groups.short_name,
    oramalocal.school_groups.responsible
  FROM oramalocal.school_groups
    INNER JOIN structures
      ON structures.id = oramalocal.school_groups.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO cashiers_drops (
  id,
  cashier_id,
  people_id,
  amount,
  created_at,
  updated_at,
  deleted_at,
  note
)
  SELECT
    oramalocal.cashier_drops.id,
    oramalocal.cashier_drops.cashier_id,
    oramalocal.cashier_drops.people_id,
    oramalocal.cashier_drops.amount,
    oramalocal.cashier_drops.created_at + 0,
    oramalocal.cashier_drops.updated_at,
    oramalocal.cashier_drops.deleted_at,
    oramalocal.cashier_drops.note
  FROM oramalocal.cashier_drops
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO enrollments (
  id,
  structure_id,
  order_at,
  is_required,
  is_public,
  verification,
  type,
  to_status,
  created_at,
  updated_at,
  deleted_at,
  name,
  description,
  help,
  data
)
  SELECT
    oramalocal.enrollments.id,
    oramalocal.enrollments.structure_id,
    oramalocal.enrollments.order,
    oramalocal.enrollments.is_required,
    oramalocal.enrollments.is_public,
    oramalocal.enrollments.verification,
    oramalocal.enrollments.type + 0,
    oramalocal.enrollments.to_status + 0,
    oramalocal.enrollments.created_at,
    oramalocal.enrollments.updated_at,
    oramalocal.enrollments.deleted_at,
    oramalocal.enrollments.name,
    oramalocal.enrollments.description,
    oramalocal.enrollments.help,
    oramalocal.enrollments.data
  FROM oramalocal.enrollments
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  schoolyears.structure_id                              AS schoolyear_id,
  sites.structure_id                                    AS site_id,
  levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students.school_enrollment,
  registrations.status,
  IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
  students.tutors
FROM students
  LEFT JOIN registrations ON students.people_id = registrations.student_id
  INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
  LEFT JOIN structures_levels ON find_in_set(structures_levels.structure_id, full_heritage.ancestor)
  LEFT JOIN structures_sites ON find_in_set(structures_sites.structure_id, full_heritage.ancestor)
  LEFT JOIN structures_school_years ON find_in_set(structures_school_years.structure_id, full_heritage.ancestor)
ORDER BY
  students.people_id,
  structures_school_years.structure_id,
  structures_sites.structure_id,
  structures_levels.structure_id,
  registrations.degree_id,
  students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  schoolyears.structure_id                              AS schoolyear_id,
  sites.structure_id                                    AS site_id,
  levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students_groups.group_id                              AS group_id,
  students_groups.list_in
students.school_enrollment,
registrations.status,
IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
students.tutors
FROM students
LEFT JOIN registrations ON students.people_id = registrations.student_id
INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
LEFT JOIN students_groups ON find_in_set(students_groups.group_id, full_heritage.ancestor)
AND students_groups.student_id = registrations.student_id
LEFT JOIN structures_levels ON find_in_set(structures_levels.structure_id, full_heritage.ancestor)
LEFT JOIN structures_sites ON find_in_set(structures_sites.structure_id, full_heritage.ancestor)
LEFT JOIN structures_school_years ON find_in_set(structures_school_years.structure_id, full_heritage.ancestor)
ORDER BY
students.people_id,
structures_school_years.structure_id,
structures_sites.structure_id,
structures_levels.structure_id,
registrations.degree_id,
students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  schoolyears.structure_id                              AS schoolyear_id,
  sites.structure_id                                    AS site_id,
  levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students_groups.group_id                              AS group_id,
  students_groups.list_in,
  students.school_enrollment,
  registrations.status,
  IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
  students.tutors
FROM students
  LEFT JOIN registrations ON students.people_id = registrations.student_id
  INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
  LEFT JOIN students_groups ON find_in_set(students_groups.group_id, full_heritage.ancestor)
                               AND students_groups.student_id = registrations.student_id
  LEFT JOIN structures_levels ON find_in_set(structures_levels.structure_id, full_heritage.ancestor)
  LEFT JOIN structures_sites ON find_in_set(structures_sites.structure_id, full_heritage.ancestor)
  LEFT JOIN structures_school_years
    ON find_in_set(structures_school_years.structure_id, full_heritage.ancestor)
ORDER BY
  students.people_id,
  structures_school_years.structure_id,
  structures_sites.structure_id,
  structures_levels.structure_id,
  registrations.degree_id,
  students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  schoolyears.structure_id                              AS schoolyear_id,
  sites.structure_id                                    AS site_id,
  levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students_groups.group_id                              AS group_id,
  students_groups.list_in,
  students.school_enrollment,
  registrations.status,
  IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
  students.tutors
FROM students
  LEFT JOIN registrations ON students.people_id = registrations.student_id
  INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
  LEFT JOIN students_groups ON find_in_set(students_groups.group_id, full_heritage.ancestor)
                               AND students_groups.student_id = registrations.student_id
  LEFT JOIN structures_levels ON find_in_set(structures_levels.id, full_heritage.ancestor)
  LEFT JOIN structures_sites ON find_in_set(structures_sites.id, full_heritage.ancestor)
  LEFT JOIN structures_school_years
    ON find_in_set(structures_school_years.id, full_heritage.ancestor)
ORDER BY
  students.people_id,
  structures_school_years.structure_id,
  structures_sites.structure_id,
  structures_levels.structure_id,
  registrations.degree_id,
  students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  structures_school_years.structure_id                              AS schoolyear_id,
  structures_sites.structure_id                                    AS site_id,
  structures_levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students_groups.group_id                              AS group_id,
  students_groups.list_in,
  students.school_enrollment,
  registrations.status,
  IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
  students.tutors
FROM students
  LEFT JOIN registrations ON students.people_id = registrations.student_id
  INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
  LEFT JOIN students_groups ON find_in_set(students_groups.group_id, full_heritage.ancestor)
                               AND students_groups.student_id = registrations.student_id
  LEFT JOIN structures_levels ON find_in_set(structures_levels.id, full_heritage.ancestor)
  LEFT JOIN structures_sites ON find_in_set(structures_sites.id, full_heritage.ancestor)
  LEFT JOIN structures_school_years
    ON find_in_set(structures_school_years.id, full_heritage.ancestor)
ORDER BY
  students.people_id,
  structures_school_years.structure_id,
  structures_sites.structure_id,
  structures_levels.structure_id,
  registrations.degree_id,
  students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  structures_school_years.structure_id                              AS schoolyear_id,
  structures_sites.structure_id                                    AS site_id,
  structures_levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students_groups.group_id                              AS group_id,
  students_groups.list_in,
  students.school_enrollment,
  registrations.status,
  IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
  students.tutors
FROM students
  LEFT JOIN registrations ON students.id = registrations.student_id
  INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
  LEFT JOIN students_groups ON find_in_set(students_groups.group_id, full_heritage.ancestor)
                               AND students_groups.student_id = registrations.student_id
  LEFT JOIN structures_levels ON find_in_set(structures_levels.id, full_heritage.ancestor)
  LEFT JOIN structures_sites ON find_in_set(structures_sites.id, full_heritage.ancestor)
  LEFT JOIN structures_school_years
    ON find_in_set(structures_school_years.id, full_heritage.ancestor)
ORDER BY
  students.people_id,
  structures_school_years.structure_id,
  structures_sites.structure_id,
  structures_levels.structure_id,
  registrations.degree_id,
  students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
SELECT
  registrations.student_id,
  registrations.id                                      AS registration_id,
  structures_school_years.structure_id                              AS schoolyear_id,
  structures_sites.structure_id                                    AS site_id,
  structures_levels.structure_id                                   AS level_id,
  registrations.degree_id                               AS degree_id,
  students_groups.group_id                              AS group_id,
  students_groups.list_in,
  students.school_enrollment,
  registrations.status,
  IFNULL(registrations.updated_at, students.updated_at) AS updated_at,
  students.tutors
FROM students
  LEFT JOIN registrations ON students.id = registrations.student_id
  INNER JOIN full_heritage ON registrations.degree_id = full_heritage.structure_id
  LEFT JOIN students_groups ON find_in_set(students_groups.group_id, full_heritage.ancestor)
                               AND students_groups.student_id = registrations.student_id
  LEFT JOIN structures_levels ON find_in_set(structures_levels.structure_id, full_heritage.ancestor)
  LEFT JOIN structures_sites ON find_in_set(structures_sites.structure_id, full_heritage.ancestor)
  LEFT JOIN structures_school_years
    ON find_in_set(structures_school_years.id, full_heritage.ancestor)
ORDER BY
  students.id,
  structures_school_years.structure_id,
  structures_sites.structure_id,
  structures_levels.structure_id,
  registrations.degree_id,
  students.school_enrollment
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  id,
  group_id,
  teacher_id,
  subject_id,
  type
)
  SELECT
    oramalocal.group_teacher.id,
    oramalocal.group_teacher.group_id,
    oramalocal.group_teacher.teacher_id,
    oramalocal.group_teacher.subject_id,
    oramalocal.group_teacher.type+0
  FROM oramalocal.group_teacher
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_criteria (
  id,
  teacher_group_id,
  subject_id,
  criterion_id,
  altered,
  created_at,
  updated_at,
  deleted_at,
  concepts
)
  SELECT
    oramalocal.teacher_criteria.id,
    oramalocal.teacher_criteria.teacher_id,
    oramalocal.teacher_criteria.subject_id,
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.criteria_id,
    oramalocal.teacher_criteria.created_at,
    oramalocal.teacher_criteria.updated_at,
    oramalocal.teacher_criteria.deleted_at,
    oramalocal.teacher_criteria.concepts
  FROM oramalocal.teacher_criteria
LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.teacher_criteria.id,
  oramalocal.teacher_criteria.teacher_id,
  oramalocal.teacher_criteria.subject_id,
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.criteria_id,
  oramalocal.teacher_criteria.created_at,
  oramalocal.teacher_criteria.updated_at,
  oramalocal.teacher_criteria.deleted_at,
  oramalocal.teacher_criteria.concepts
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id
)
  SELECT
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
    RIGHT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                  AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
    RIGHT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                  AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
    outer JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                  AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
  LEFT OUTER JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                  AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
  INNER JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                  AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
  INNER JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id != teachers_groups.teacher_id
                                  AND oramalocal.teacher_criteria.group_id != teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                          AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  RIGHT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                          AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
WHERE teacher_id=null
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
WHERE teachers_groups.teacher_id = NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
WHERE teachers_groups.teacher_id IS NOT NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id,
  teachers_groups.teacher_id,
  teachers_groups.group_id
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
WHERE teachers_groups.teacher_id IS NULL
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id,
  subject_id,
  type
)
  SELECT
    oramalocal.group_teacher.group_id,
    oramalocal.group_teacher.teacher_id,
    oramalocal.group_teacher.subject_id,
    oramalocal.group_teacher.type+0
  FROM oramalocal.group_teacher
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id
)
SELECT DISTINCTROW
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.teacher_id
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
WHERE teachers_groups.teacher_id IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.teacher_criteria.id,
  oramalocal.teacher_criteria.teacher_id,
  oramalocal.teacher_criteria.subject_id,
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.criteria_id,
  oramalocal.teacher_criteria.created_at,
  oramalocal.teacher_criteria.updated_at,
  oramalocal.teacher_criteria.deleted_at,
  oramalocal.teacher_criteria.concepts,
  teachers_groups.*
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  teachers_groups.*,
  oramalocal.teacher_criteria.id,
  oramalocal.teacher_criteria.teacher_id,
  oramalocal.teacher_criteria.subject_id,
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.criteria_id,
  oramalocal.teacher_criteria.created_at,
  oramalocal.teacher_criteria.updated_at,
  oramalocal.teacher_criteria.deleted_at,
  oramalocal.teacher_criteria.concepts
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW 
  teachers_groups.*,
  oramalocal.teacher_criteria.id,
  oramalocal.teacher_criteria.teacher_id,
  oramalocal.teacher_criteria.subject_id,
  oramalocal.teacher_criteria.group_id,
  oramalocal.teacher_criteria.criteria_id,
  oramalocal.teacher_criteria.created_at,
  oramalocal.teacher_criteria.updated_at,
  oramalocal.teacher_criteria.deleted_at,
  oramalocal.teacher_criteria.concepts
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.id,
  teachers_groups.id,
  oramalocal.teacher_criteria.subject_id,
  oramalocal.teacher_criteria.criteria_id,
  oramalocal.teacher_criteria.created_at,
  oramalocal.teacher_criteria.updated_at,
  oramalocal.teacher_criteria.deleted_at,
  oramalocal.teacher_criteria.concepts
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
  oramalocal.teacher_criteria.id,
  teachers_groups.id,
  oramalocal.teacher_criteria.subject_id,
  oramalocal.teacher_criteria.criteria_id,
  oramalocal.teacher_criteria.created_at,
  oramalocal.teacher_criteria.updated_at,
  oramalocal.teacher_criteria.deleted_at
FROM oramalocal.teacher_criteria
  LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                               AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.registrations.id,
  oramalocal.registrations.degree_id,
  oramalocal.registrations.student_id,
  oramalocal.registrations.editor_id,
  IF(oramalocal.registrations.intention=1, 2, oramalocal.registrations.intention),
  oramalocal.registrations.status+0,
  oramalocal.registrations.cause+0,
  oramalocal.registrations.created_at,
  oramalocal.registrations.updated_at,
  oramalocal.registrations.deleted_at,
  oramalocal.registrations.cause_at,
  oramalocal.registrations.note
FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO registrations (
  id,
  degree_id,
  student_id,
  editor_id,
  type,
  status,
  cause,
  created_at,
  updated_at,
  deleted_at,
  cause_at,
  note
)
  SELECT
    oramalocal.registrations.id,
    oramalocal.registrations.degree_id,
    oramalocal.registrations.student_id,
    oramalocal.registrations.editor_id,
    IF(oramalocal.registrations.intention=1, 2, oramalocal.registrations.intention),
    oramalocal.registrations.status+0,
    oramalocal.registrations.cause+0,
    oramalocal.registrations.created_at,
    oramalocal.registrations.updated_at,
    oramalocal.registrations.deleted_at,
    oramalocal.registrations.cause_at,
    oramalocal.registrations.note
  FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO periods_grading (
  id,
  period_id,
  publisher_id,
  required_review,
  status,
  created_at,
  updated_at,
  deleted_at,
  start_at,
  limited_at,
  end_at,
  time,
  metadata
)
  SELECT
    oramalocal.grading_periods.id,
    oramalocal.grading_periods.period_id,
    oramalocal.grading_periods.publisher_id,
    oramalocal.grading_periods.required_review,
    oramalocal.grading_periods.status + 0,
    oramalocal.grading_periods.created_at,
    oramalocal.grading_periods.updated_at,
    oramalocal.grading_periods.deleted_at,
    oramalocal.grading_periods.start_at,
    oramalocal.grading_periods.limited_at,
    oramalocal.grading_periods.end_at,
    oramalocal.grading_periods.time,
    oramalocal.grading_periods.metadata
  FROM oramalocal.group_student
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.grading_periods.id,
  oramalocal.grading_periods.period_id,
  oramalocal.grading_periods.publisher_id,
  oramalocal.grading_periods.required_review,
  oramalocal.grading_periods.status + 0,
  oramalocal.grading_periods.created_at,
  oramalocal.grading_periods.updated_at,
  oramalocal.grading_periods.deleted_at,
  oramalocal.grading_periods.start_at,
  oramalocal.grading_periods.limited_at,
  oramalocal.grading_periods.end_at,
  oramalocal.grading_periods.time,
  oramalocal.grading_periods.metadata
FROM oramalocal.group_student
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.grading_periods.id,
  oramalocal.grading_periods.period_id,
  oramalocal.grading_periods.publisher_id,
  oramalocal.grading_periods.required_review,
  oramalocal.grading_periods.status + 0,
  oramalocal.grading_periods.created_at,
  oramalocal.grading_periods.updated_at,
  oramalocal.grading_periods.deleted_at,
  oramalocal.grading_periods.start_at,
  oramalocal.grading_periods.limited_at,
  oramalocal.grading_periods.end_at,
  oramalocal.grading_periods.time,
  oramalocal.grading_periods.metadata
FROM oramalocal.grading_periods
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_criteria (
  id,
  teacher_group_id,
  subject_id,
  criterion_id,
  altered,
  created_at,
  updated_at,
  deleted_at,
  concepts
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.id,
    teachers_groups.id,
    oramalocal.teacher_criteria.subject_id,
    oramalocal.teacher_criteria.criteria_id,
    oramalocal.teacher_criteria.created_at,
    oramalocal.teacher_criteria.updated_at,
    oramalocal.teacher_criteria.deleted_at
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND
                                 oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_criteria (
  id,
  teacher_group_id,
  subject_id,
  criterion_id,
  altered,
  created_at,
  updated_at,
  deleted_at,
  concepts
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.id,
    teachers_groups.id,
    oramalocal.teacher_criteria.subject_id,
    oramalocal.teacher_criteria.criteria_id,
    oramalocal.teacher_criteria.created_at,
    oramalocal.teacher_criteria.updated_at,
    oramalocal.teacher_criteria.deleted_at,
    null
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND
                                 oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_criteria (
  id,
  teacher_group_id,
  subject_id,
  criterion_id,
  created_at,
  updated_at,
  deleted_at,
  concepts
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.id,
    teachers_groups.id,
    oramalocal.teacher_criteria.subject_id,
    oramalocal.teacher_criteria.criteria_id,
    oramalocal.teacher_criteria.created_at,
    oramalocal.teacher_criteria.updated_at,
    oramalocal.teacher_criteria.deleted_at,
    null
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND
                                 oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO registrations (
  id,
  degree_id,
  student_id,
  editor_id,
  type,
  status,
  cause,
  created_at,
  updated_at,
  deleted_at,
  cause_at,
  note
)
  SELECT
    oramalocal.registrations.id,
    oramalocal.registrations.degree_id,
    oramalocal.registrations.student_id,
    oramalocal.registrations.editor_id,
    IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
    oramalocal.registrations.status * 10,
    oramalocal.registrations.cause * 10,
    oramalocal.registrations.created_at,
    oramalocal.registrations.updated_at,
    oramalocal.registrations.deleted_at,
    oramalocal.registrations.cause_at,
    oramalocal.registrations.note
  FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.registrations.id,
  oramalocal.registrations.degree_id,
  oramalocal.registrations.student_id,
  oramalocal.registrations.editor_id,
  IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
  oramalocal.registrations.status * 10,
  oramalocal.registrations.cause * 10,
  oramalocal.registrations.created_at,
  oramalocal.registrations.updated_at,
  oramalocal.registrations.deleted_at,
  oramalocal.registrations.cause_at,
  oramalocal.registrations.note
FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.registrations.id,
  oramalocal.registrations.degree_id,
  oramalocal.registrations.student_id,
  oramalocal.registrations.editor_id,
  IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
  oramalocal.registrations.status +1,
  oramalocal.registrations.cause * 10,
  oramalocal.registrations.created_at,
  oramalocal.registrations.updated_at,
  oramalocal.registrations.deleted_at,
  oramalocal.registrations.cause_at,
  oramalocal.registrations.note
FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.registrations.id,
  oramalocal.registrations.degree_id,
  oramalocal.registrations.student_id,
  oramalocal.registrations.editor_id,
  IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
  CASE oramalocal.registrations.status +0
  WHEN 1 THEN 1
  WHEN 6 THEN 0
  END,
  oramalocal.registrations.cause +0,
  oramalocal.registrations.created_at,
  oramalocal.registrations.updated_at,
  oramalocal.registrations.deleted_at,
  oramalocal.registrations.cause_at,
  oramalocal.registrations.note
FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.registrations.id,
  oramalocal.registrations.degree_id,
  oramalocal.registrations.student_id,
  oramalocal.registrations.editor_id,
  IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
  CASE oramalocal.registrations.status
  WHEN 'Activo' THEN 1
  WHEN 'Baja temporal' THEN 1
  WHEN 'Condicionado' THEN 1
  WHEN 'Retenido' THEN 1
  WHEN 'Suspendido' THEN 1
  WHEN 'Baja' THEN 0
  WHEN 'Expulsado' THEN 0
  WHEN 'Negado' THEN 3
  WHEN 'Pendiente' THEN 2
  WHEN 'Admitido' THEN 2
  WHEN 'Aprobado' THEN 3
  WHEN 'Egresado' THEN 0
  WHEN 'Informes' THEN 2
  WHEN 'Aspirante' THEN 2
  WHEN 'Desistió' THEN 2
  WHEN 'En espera' THEN 2
  WHEN 'Pendiente de egresar' THEN 0
  END,
  oramalocal.registrations.cause + 0,
  oramalocal.registrations.created_at,
  oramalocal.registrations.updated_at,
  oramalocal.registrations.deleted_at,
  oramalocal.registrations.cause_at,
  oramalocal.registrations.note
FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT
  oramalocal.registrations.id,
  oramalocal.registrations.degree_id,
  oramalocal.registrations.student_id,
  oramalocal.registrations.editor_id,
  IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
  CASE oramalocal.registrations.status
  WHEN 'Activo' THEN 1
  WHEN 'Baja temporal' THEN 1
  WHEN 'Condicionado' THEN 1
  WHEN 'Retenido' THEN 1
  WHEN 'Suspendido' THEN 1
  WHEN 'Baja' THEN 0
  WHEN 'Expulsado' THEN 0
  WHEN 'Negado' THEN 3
  WHEN 'Pendiente' THEN 2
  WHEN 'Admitido' THEN 2
  WHEN 'Aprobado' THEN 3
  WHEN 'Egresado' THEN 0
  WHEN 'Informes' THEN 2
  WHEN 'Aspirante' THEN 2
  WHEN 'Desistió' THEN 2
  WHEN 'En espera' THEN 2
  WHEN 'Pendiente de egresar' THEN 0
  END,
  (SELECT id FROM registrations_modes WHERE name = oramalocal.registrations.status),
  oramalocal.registrations.cause + 0,
  oramalocal.registrations.created_at,
  oramalocal.registrations.updated_at,
  oramalocal.registrations.deleted_at,
  oramalocal.registrations.cause_at,
  oramalocal.registrations.note
FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO registrations (
  id,
  degree_id,
  student_id,
  editor_id,
  type,
  status,
  registrations_mode_id,
  cause,
  created_at,
  updated_at,
  deleted_at,
  cause_at,
  review_at,
  note
)
  SELECT
    oramalocal.registrations.id,
    oramalocal.registrations.degree_id,
    oramalocal.registrations.student_id,
    oramalocal.registrations.editor_id,
    IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
    CASE oramalocal.registrations.status
    WHEN 'Activo' THEN 1
    WHEN 'Baja temporal' THEN 1
    WHEN 'Condicionado' THEN 1
    WHEN 'Retenido' THEN 1
    WHEN 'Suspendido' THEN 1
    WHEN 'Baja' THEN 0
    WHEN 'Expulsado' THEN 0
    WHEN 'Negado' THEN 3
    WHEN 'Pendiente' THEN 2
    WHEN 'Admitido' THEN 2
    WHEN 'Aprobado' THEN 3
    WHEN 'Egresado' THEN 0
    WHEN 'Informes' THEN 2
    WHEN 'Aspirante' THEN 2
    WHEN 'Desistió' THEN 2
    WHEN 'En espera' THEN 2
    WHEN 'Pendiente de egresar' THEN 0
    END,
    (SELECT id FROM registrations_modes WHERE name = oramalocal.registrations.status),
    oramalocal.registrations.cause + 0,
    oramalocal.registrations.created_at,
    oramalocal.registrations.updated_at,
    oramalocal.registrations.deleted_at,
    oramalocal.registrations.cause_at,
    oramalocal.registrations.note
  FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  messages.id,
  students_registrations.student_id,
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
FROM students_registrations
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
ORDER BY student_id, IFNULL(messages.start_at, messages.created_at) DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  messages.id,
  students_registrations.student_id,
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
FROM students_registrations
  LEFT JOIN messages ON (target_type = 'Orama\\Models\\People' AND student_id = target_id)
                        OR (target_type = 'Orama\\Models\\SchoolStructure' AND
                            FIND_IN_SET(target_id, CONCAT_WS(',',
                                                             school_year_id,
                                                             site_id,
                                                             level_id,
                                                             degree_id,
                                                             group_id)))
WHERE now() BETWEEN IFNULL(messages.start_at, messages.created_at)
      AND IFNULL(messages.end_at, adddate(now(), 1))
      AND messages.deleted_at IS NULL
      AND messages.id IS NOT NULL
ORDER BY student_id, IFNULL(messages.start_at, messages.created_at) DESC
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO registrations (
  id,
  degree_id,
  student_id,
  editor_id,
  type,
  status,
  registrations_mode_id,
  cause,
  created_at,
  updated_at,
  deleted_at,
  cause_at,
  review_at,
  note
)
  SELECT
    oramalocal.registrations.id,
    oramalocal.registrations.degree_id,
    oramalocal.registrations.student_id,
    oramalocal.registrations.editor_id,
    IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
    CASE oramalocal.registrations.status
    WHEN 'Activo' THEN 1
    WHEN 'Baja temporal' THEN 1
    WHEN 'Condicionado' THEN 1
    WHEN 'Retenido' THEN 1
    WHEN 'Suspendido' THEN 1
    WHEN 'Baja' THEN 0
    WHEN 'Expulsado' THEN 0
    WHEN 'Negado' THEN 3
    WHEN 'Pendiente' THEN 2
    WHEN 'Admitido' THEN 2
    WHEN 'Aprobado' THEN 3
    WHEN 'Egresado' THEN 0
    WHEN 'Informes' THEN 2
    WHEN 'Aspirante' THEN 2
    WHEN 'Desistió' THEN 2
    WHEN 'En espera' THEN 2
    WHEN 'Pendiente de egresar' THEN 0
    END,
    (SELECT id FROM registrations_modes WHERE name = oramalocal.registrations.status),
    oramalocal.registrations.cause + 0,
    oramalocal.registrations.created_at,
    oramalocal.registrations.updated_at,
    oramalocal.registrations.deleted_at,
    oramalocal.registrations.cause_at,
    NULL,
    oramalocal.registrations.note
  FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
UPDATE registrations SET review_at = ADDDATE(cause_at,30) WHERE registrations_mode_id IS NOT null
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `matelangular`.`messages`.`id`                 AS `id`,
  `students_registrations`.`student_id`          AS `student_id`,
  `matelangular`.`messages`.`from`               AS `from`,
  `matelangular`.`messages`.`transcribed_by`     AS `transcribed_by`,
  `matelangular`.`messages`.`type`               AS `type`,
  `matelangular`.`messages`.`signature_required` AS `signature_required`,
  `matelangular`.`messages`.`notifications`      AS `notifications`,
  `matelangular`.`messages`.`created_at`         AS `created_at`,
  `matelangular`.`messages`.`updated_at`         AS `updated_at`,
  `matelangular`.`messages`.`deleted_at`         AS `deleted_at`,
  `matelangular`.`messages`.`start_at`           AS `start_at`,
  `matelangular`.`messages`.`remember_at`        AS `remember_at`,
  `matelangular`.`messages`.`end_at`             AS `end_at`,
  `matelangular`.`messages`.`subtype`            AS `subtype`,
  `matelangular`.`messages`.`subject`            AS `subject`,
  `matelangular`.`messages`.`message`            AS `message`,
  `matelangular`.`messages`.`data`               AS `data`
FROM (`matelangular`.`students_registrations`
  LEFT JOIN `matelangular`.`messages` ON ((
    ((`matelangular`.`messages`.`target_type` = 'OramaModelsPeople') AND
     (`students_registrations`.`student_id` = `matelangular`.`messages`.`target_id`)) OR
    ((`matelangular`.`messages`.`target_type` = 'OramaModelsSchoolStructure') AND
     find_in_set(`matelangular`.`messages`.`target_id`,
                 concat_ws(',', `students_registrations`.`school_year_id`,
                           `students_registrations`.`site_id`,
                           `students_registrations`.`level_id`,
                           `students_registrations`.`degree_id`,
                           `students_registrations`.`group_id`))))))
WHERE ((now() BETWEEN ifnull(`matelangular`.`messages`.`start_at`,
                             `matelangular`.`messages`.`created_at`) AND ifnull(
    `matelangular`.`messages`.`end_at`, (now() + INTERVAL 1 DAY))) AND
       isnull(`matelangular`.`messages`.`deleted_at`) AND
       (`matelangular`.`messages`.`id` IS NOT NULL))
ORDER BY `students_registrations`.`student_id`,
  ifnull(`matelangular`.`messages`.`start_at`, `matelangular`.`messages`.`created_at`) DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  `matelangular`.`messages`.`id`                 AS `id`,
  `students_registrations`.`student_id`          AS `student_id`,
  `matelangular`.`messages`.`from`               AS `from`,
  `matelangular`.`messages`.`transcribed_by`     AS `transcribed_by`,
  `matelangular`.`messages`.`type`               AS `type`,
  `matelangular`.`messages`.`signature_required` AS `signature_required`,
  `matelangular`.`messages`.`notifications`      AS `notifications`,
  `matelangular`.`messages`.`created_at`         AS `created_at`,
  `matelangular`.`messages`.`updated_at`         AS `updated_at`,
  `matelangular`.`messages`.`deleted_at`         AS `deleted_at`,
  `matelangular`.`messages`.`start_at`           AS `start_at`,
  `matelangular`.`messages`.`remember_at`        AS `remember_at`,
  `matelangular`.`messages`.`end_at`             AS `end_at`,
  `matelangular`.`messages`.`subtype`            AS `subtype`,
  `matelangular`.`messages`.`subject`            AS `subject`,
  `matelangular`.`messages`.`message`            AS `message`,
  `matelangular`.`messages`.`data`               AS `data`
FROM (`matelangular`.`students_registrations`
  LEFT JOIN `matelangular`.`messages` ON ((
    ((`matelangular`.`messages`.`target_type` = 'OramaModelsPeople') AND
     (`students_registrations`.`student_id` = `matelangular`.`messages`.`target_id`)) OR
    ((`matelangular`.`messages`.`target_type` = 'OramaModelsSchoolStructure') AND
     find_in_set(`matelangular`.`messages`.`target_id`,
                 concat_ws(',', `students_registrations`.`school_year_id`,
                           `students_registrations`.`site_id`,
                           `students_registrations`.`level_id`,
                           `students_registrations`.`degree_id`,
                           `students_registrations`.`group_id`))))))
WHERE ((now() BETWEEN ifnull(`matelangular`.`messages`.`start_at`,
                             `matelangular`.`messages`.`created_at`) AND ifnull(
    `matelangular`.`messages`.`end_at`, (now() + INTERVAL 1 DAY))) AND
       isnull(`matelangular`.`messages`.`deleted_at`))
ORDER BY `students_registrations`.`student_id`,
  ifnull(`matelangular`.`messages`.`start_at`, `matelangular`.`messages`.`created_at`) DESC
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO messages (
  id,
  target_id,
  `from`,
  transcribed_by,
  type,
  target_type,
  signature_required,
  notifications,
  created_at,
  updated_at,
  deleted_at,
  start_at,
  remember_at,
  end_at,
  subtype,
  subject,
  message,
  data
)
  SELECT
    oramalocal.messages.id,
    oramalocal.messages.target_id,
    oramalocal.messages.from,
    oramalocal.messages.transcribed_by,
    oramalocal.messages.type + 0,
    oramalocal.messages.target_type,
    oramalocal.messages.signature_required,
    oramalocal.messages.notifications,
    oramalocal.messages.created_at,
    oramalocal.messages.updated_at,
    oramalocal.messages.deleted_at,
    oramalocal.messages.start_at,
    oramalocal.messages.remember_at,
    oramalocal.messages.end_at,
    oramalocal.messages.subtype,
    oramalocal.messages.subject,
    oramalocal.messages.message,
    IF(oramalocal.messages.data = 'null', NULL, oramalocal.messages.data)
  FROM oramalocal.messages
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO messages (
  id,
  target_id,
  `from`,
  transcribed_by,
  type,
  target_type,
  signature_required,
  notifications,
  created_at,
  updated_at,
  deleted_at,
  start_at,
  remember_at,
  end_at,
  subtype,
  subject,
  message,
  data
)
  SELECT
    oramalocal.messages.id,
    oramalocal.messages.target_id,
    oramalocal.messages.from,
    oramalocal.messages.transcribed_by,
    oramalocal.messages.type + 0,
    CASE oramalocal.messages.target_type
    WHEN
      'Orama\Models\People'
      THEN 'Modules\Schools\Students\Models\Student'
    WHEN 'Orama\Models\SchoolStructure'
      THEN 'Modules\Schools\Structures\Models\Structure'
    END,
    oramalocal.messages.signature_required,
    oramalocal.messages.notifications,
    oramalocal.messages.created_at,
    oramalocal.messages.updated_at,
    oramalocal.messages.deleted_at,
    oramalocal.messages.start_at,
    oramalocal.messages.remember_at,
    oramalocal.messages.end_at,
    oramalocal.messages.subtype,
    oramalocal.messages.subject,
    oramalocal.messages.message,
    IF(oramalocal.messages.data = 'null', NULL, oramalocal.messages.data)
  FROM oramalocal.messages
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `messages`
WHERE `target_id` IN (2168,
                      2169,
                      2771,
                      3166) AND `target_type` IN ("Modules\\People\\Models\\Person",
                                                  "Modules\\Schools\\Students\\Models\\Student") AND `messages`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE `quizzes_questions` ADD CONSTRAINT `FK_qq_quiz` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`)
  ON DELETE CASCADE
;-- -. . -..- - / . -. - .-. -.--
SELECT
    id,
    IF(type - 2 = 9, 0, parent),
    `master`,
    `order`,
    tree + 0,
    type - 2,
    `name`
  FROM oramalocal.school_structures
  WHERE IF(tree + 0 = 8, master = 0, TRUE)
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.schoolyears.structure_id,
    oramalocal.schoolyears.status - 1,
    oramalocal.schoolyears.inscription_at,
    oramalocal.schoolyears.starts_at,
    oramalocal.schoolyears.ends_at,
    oramalocal.schoolyears.description,
    oramalocal.schoolyears.config
  FROM oramalocal.schoolyears
    INNER JOIN matelangular.structures
      ON structures.id = oramalocal.schoolyears.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.periods.structure_id,
    oramalocal.periods.display,
    oramalocal.periods.extraordinary,
    oramalocal.periods.test,
    oramalocal.periods.quantity,
    oramalocal.periods.title,
    oramalocal.periods.short_name,
    oramalocal.periods.titration
  FROM oramalocal.periods
    INNER JOIN structures
      ON structures.id = oramalocal.periods.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.sites.structure_id,
    oramalocal.sites.responsible,
    oramalocal.sites.config
  FROM oramalocal.sites
    INNER JOIN structures
      ON structures.id = oramalocal.sites.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.levels.structure_id,
    oramalocal.levels.period_id,
    oramalocal.levels.standard_id,
    oramalocal.levels.code,
    oramalocal.levels.short_name,
    oramalocal.levels.description,
    oramalocal.levels.governmental,
    oramalocal.levels.responsible
  FROM oramalocal.levels
    INNER JOIN structures
      ON structures.id = oramalocal.levels.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.degrees.structure_id,
    oramalocal.degrees.standard_id,
    oramalocal.degrees.capacity,
    oramalocal.degrees.short_name,
    oramalocal.degrees.description
  FROM oramalocal.degrees
    INNER JOIN structures
      ON structures.id = oramalocal.degrees.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.school_groups.structure_id,
    oramalocal.school_groups.facility_id,
    CASE oramalocal.school_groups.study_branch_id
    WHEN 196
      THEN 156
    WHEN 283
      THEN 136
    WHEN 288
      THEN 156
    WHEN 311
      THEN 156
    ELSE oramalocal.school_groups.study_branch_id
    END,
    oramalocal.school_groups.scope,
    oramalocal.school_groups.short_name,
    oramalocal.school_groups.responsible
  FROM oramalocal.school_groups
    INNER JOIN structures
      ON structures.id = oramalocal.school_groups.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.facilities.structure_id,
    oramalocal.facilities.restriction,
    oramalocal.facilities.status,
    oramalocal.facilities.capacity,
    oramalocal.facilities.use_as,
    oramalocal.facilities.created_at,
    oramalocal.facilities.updated_at,
    oramalocal.facilities.deleted_at,
    oramalocal.facilities.code,
    oramalocal.facilities.description,
    oramalocal.facilities.note
  FROM oramalocal.facilities
    INNER JOIN structures
      ON structures.id = oramalocal.facilities.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.study_plans.structure_id,
    oramalocal.study_plans.description,
    oramalocal.study_plans.governmental,
    replace(oramalocal.study_plans.levels_ids, '"', '')
  FROM oramalocal.study_plans
    INNER JOIN structures
      ON structures.id = oramalocal.study_plans.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.subject_groups.structure_id,
    oramalocal.subject_groups.standard_id,
    oramalocal.subject_groups.academic,
    oramalocal.subject_groups.behavior,
    oramalocal.subject_groups.report
  FROM oramalocal.subject_groups
    INNER JOIN structures
      ON structures.id = oramalocal.subject_groups.structure_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.people.id,
    oramalocal.people.created_at,
    oramalocal.people.updated_at,
    oramalocal.people.deleted_at,
    oramalocal.people.gender,
    oramalocal.people.birth_at,
    oramalocal.people.citizen_identifier,
    oramalocal.people.tax_id,
    oramalocal.people.first_name,
    oramalocal.people.second_name,
    oramalocal.people.names,
    oramalocal.people.short_name,
    oramalocal.people.note,
    oramalocal.people.birth_place,
    oramalocal.people.emails,
    oramalocal.people.marital_status,
    oramalocal.people.nationalities,
    oramalocal.people.other_info,
    oramalocal.people.phones
  FROM oramalocal.people
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.families.id,
    oramalocal.families.contact_id,
    oramalocal.families.created_at,
    oramalocal.families.updated_at,
    oramalocal.families.deleted_at,
    oramalocal.families.first_name,
    oramalocal.families.second_name,
    oramalocal.families.note,
    oramalocal.families.marital
  FROM oramalocal.families
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.family_people.family_id,
    oramalocal.family_people.people_id,
    oramalocal.family_people.people_pickup,
    oramalocal.family_people.type + 0
  FROM oramalocal.family_people
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.students.people_id,
    oramalocal.students.created_at,
    oramalocal.students.updated_at,
    oramalocal.students.deleted_at,
    oramalocal.students.enrollment_at,
    oramalocal.students.school_enrollment,
    oramalocal.students.note,
    oramalocal.students.enrollment_info,
    oramalocal.students.tutor
  FROM oramalocal.students
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.teachers.people_id,
    oramalocal.teachers.status,
    oramalocal.teachers.type + 0,
    oramalocal.teachers.created_at,
    oramalocal.teachers.updated_at,
    oramalocal.teachers.deleted_at,
    oramalocal.teachers.ingress_at,
    oramalocal.teachers.certificate,
    oramalocal.teachers.language,
    oramalocal.teachers.position,
    oramalocal.teachers.internal_code,
    oramalocal.teachers.specialities,
    oramalocal.teachers.curriculum,
    oramalocal.teachers.notes
  FROM oramalocal.teachers
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.tuitions.id,
    oramalocal.tuitions.structure_id,
    oramalocal.tuitions.created_at,
    oramalocal.tuitions.updated_at,
    oramalocal.tuitions.deleted_at,
    oramalocal.tuitions.type + 0,
    oramalocal.tuitions.name,
    oramalocal.tuitions.in_ledger,
    oramalocal.tuitions.in_ledger_description,
    oramalocal.tuitions.previous_ledger,
    oramalocal.tuitions.previous_ledger_description,
    oramalocal.tuitions.surcharge_ledger,
    oramalocal.tuitions.surcharge_ledger_description,
    oramalocal.tuitions.config
  FROM oramalocal.tuitions
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.scholarships.id,
    oramalocal.scholarships.percentage,
    oramalocal.scholarships.request,
    oramalocal.scholarships.academic,
    oramalocal.scholarships.behavior,
    oramalocal.scholarships.created_at,
    oramalocal.scholarships.updated_at,
    oramalocal.scholarships.deleted_at,
    oramalocal.scholarships.name,
    oramalocal.scholarships.amounts
  FROM oramalocal.scholarships
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.student_scholarships.id,
    oramalocal.student_scholarships.schoolyear_id,
    oramalocal.student_scholarships.student_id,
    oramalocal.student_scholarships.scholarship_id,
    oramalocal.student_scholarships.renovation,
    oramalocal.student_scholarships.percentage,
    oramalocal.student_scholarships.created_at,
    oramalocal.student_scholarships.updated_at,
    oramalocal.student_scholarships.deleted_at,
    oramalocal.student_scholarships.comment,
    oramalocal.student_scholarships.specific_amounts
  FROM oramalocal.student_scholarships
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.student_tuitions.id,
    oramalocal.student_tuitions.student_id,
    oramalocal.student_tuitions.tuition_id,
    oramalocal.student_tuitions.payment_index,
    oramalocal.student_tuitions.payment_time,
    CASE oramalocal.student_tuitions.type + 0
    WHEN 1
      THEN 1
    WHEN 2
      THEN -1
    WHEN 3
      THEN 2
    END,
    oramalocal.student_tuitions.amount,
    oramalocal.student_tuitions.created_at,
    oramalocal.student_tuitions.updated_at,
    oramalocal.student_tuitions.deleted_at,
    oramalocal.student_tuitions.expected_at,
    CONCAT(oramalocal.tuitions.name, ' (',
           DATE_FORMAT(oramalocal.student_tuitions.expected_at, "%M"), ' ',
           DATE_FORMAT(oramalocal.student_tuitions.expected_at, "%Y"), ')')
  FROM oramalocal.student_tuitions
    LEFT JOIN oramalocal.tuitions
      ON oramalocal.tuitions.id = oramalocal.student_tuitions.tuition_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.payments.id,
    oramalocal.payments.people_id,
    oramalocal.payments.cashier_id,
    oramalocal.payments.type + 0,
    oramalocal.payments.amount,
    oramalocal.payments.created_at,
    oramalocal.payments.updated_at,
    oramalocal.payments.deleted_at,
    oramalocal.payments.payed_at,
    CONCAT_WS('-', oramalocal.payments.sequence, oramalocal.payments.folio),
    oramalocal.payments.note,
    oramalocal.payments.info
  FROM oramalocal.payments
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.invoices.id,
    oramalocal.invoices.people_id,
    oramalocal.invoices.type + 0,
    oramalocal.invoices.status + 0,
    oramalocal.invoices.amount,
    oramalocal.invoices.created_at,
    oramalocal.invoices.updated_at,
    oramalocal.invoices.deleted_at,
    oramalocal.invoices.invoice_at,
    CONCAT_WS('-', oramalocal.invoices.sequence, oramalocal.invoices.folio),
    oramalocal.invoices.concept,
    oramalocal.invoices.receiver
  FROM oramalocal.invoices
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
    oramalocal.student_payment_options.tax_id,
    oramalocal.student_payment_options.created_at,
    oramalocal.student_payment_options.updated_at,
    oramalocal.student_payment_options.deleted_at,
    oramalocal.student_payment_options.business_name,
    oramalocal.student_payment_options.email
  FROM oramalocal.student_payment_options
  ORDER BY oramalocal.student_payment_options.updated_at DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT
    invoice_data.id,
    oramalocal.student_payment_options.percentage,
    oramalocal.student_payment_options.amount,
    oramalocal.student_payment_options.student_id,
    oramalocal.student_payment_options.created_at,
    oramalocal.student_payment_options.updated_at,
    oramalocal.student_payment_options.deleted_at,
    'Modules\\Schools\\Students\\Models\\Student'
  FROM oramalocal.student_payment_options
    LEFT JOIN invoice_data ON oramalocal.student_payment_options.tax_id = invoice_data.tax_id
  ORDER BY oramalocal.student_payment_options.updated_at DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.student_payments.id,
    oramalocal.student_payments.student_tuition_id,
    oramalocal.student_payments.payment_id,
    oramalocal.student_payments.invoice_id,
    oramalocal.student_payments.amount,
    oramalocal.student_payments.created_at,
    oramalocal.student_payments.updated_at,
    oramalocal.student_payments.deleted_at
  FROM oramalocal.student_payments
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.cashier_drops.id,
    oramalocal.cashier_drops.cashier_id,
    oramalocal.cashier_drops.people_id,
    oramalocal.cashier_drops.amount,
    oramalocal.cashier_drops.created_at + 0,
    oramalocal.cashier_drops.updated_at,
    oramalocal.cashier_drops.deleted_at,
    oramalocal.cashier_drops.note
  FROM oramalocal.cashier_drops
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.cashiers.id,
    oramalocal.cashiers.folio,
    oramalocal.cashiers.maximum,
    oramalocal.cashiers.balance,
    oramalocal.cashiers.status + 0,
    oramalocal.cashiers.created_at,
    oramalocal.cashiers.updated_at,
    oramalocal.cashiers.deleted_at,
    oramalocal.cashiers.box_cut_at,
    oramalocal.cashiers.name,
    oramalocal.cashiers.sequence,
    oramalocal.cashiers.authorized
  FROM oramalocal.cashiers
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.scales.id,
    oramalocal.study_plans.structure_id,
    oramalocal.scales.type,
    oramalocal.scales.round_type,
    oramalocal.scales.decimals,
    oramalocal.scales.min,
    oramalocal.scales.max,
    oramalocal.scales.passing,
    oramalocal.scales.display_min,
    oramalocal.scales.let_down,
    oramalocal.scales.cheating,
    oramalocal.scales.created_at,
    oramalocal.scales.updated_at,
    oramalocal.scales.deleted_at,
    oramalocal.scales.name,
    oramalocal.scales.literals,
    oramalocal.scales.qualitative
  FROM oramalocal.scales
    LEFT JOIN oramalocal.full_heritage
      ON oramalocal.scales.structure_id = oramalocal.full_heritage.structure_id
    LEFT JOIN oramalocal.study_plans
      ON FIND_IN_SET(oramalocal.study_plans.structure_id, oramalocal.full_heritage.sons)
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.criteria.id,
    oramalocal.study_plans.structure_id,
    oramalocal.criteria.scale_id,
    oramalocal.criteria.editable,
    oramalocal.criteria.comments,
    oramalocal.criteria.created_at,
    oramalocal.criteria.updated_at,
    oramalocal.criteria.deleted_at,
    oramalocal.criteria.name,
    oramalocal.criteria.description,
    oramalocal.criteria.concepts
  FROM oramalocal.criteria
    LEFT JOIN oramalocal.full_heritage
      ON oramalocal.criteria.structure_id = oramalocal.full_heritage.structure_id
    LEFT JOIN oramalocal.study_plans
      ON FIND_IN_SET(oramalocal.study_plans.structure_id, oramalocal.full_heritage.sons)
  WHERE oramalocal.study_plans.structure_id IN (SELECT structures_plans.structure_id
                                                FROM structures_plans)
        AND oramalocal.criteria.scale_id IN (SELECT scales.id
                                             FROM scales)
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.subjects.id,
    oramalocal.subjects.parent,
    oramalocal.subjects.standard_id,
    0,
    oramalocal.subjects.criteria_id,
    IFNULL(oramalocal.subjects.order_at, 0),
    #     oramalocal.subjects.criteria_edit,
    oramalocal.subjects.proposal + 0,
    oramalocal.subjects.classification + 0,
    oramalocal.subjects.scope + 0,
    oramalocal.subjects.created_at,
    oramalocal.subjects.updated_at,
    oramalocal.subjects.deleted_at,
    oramalocal.subjects.governmental,
    oramalocal.subjects.name,
    oramalocal.subjects.short_name,
    oramalocal.subjects.abbreviations,
    oramalocal.subjects.code,
    oramalocal.subjects.report
  FROM oramalocal.subjects
  WHERE oramalocal.subjects.standard_id IN (SELECT structures_standards.structure_id
                                            FROM structures_standards)
        AND oramalocal.subjects.criteria_id IN (SELECT criteria.id
                                                FROM criteria)
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.plan_subjects.subject_id,
    oramalocal.plan_subjects.subject_group_id,
    'Modules\\Schools\\Structures\\Models\\SubjectGroup'
  FROM oramalocal.plan_subjects
  WHERE oramalocal.plan_subjects.subject_group_id IN (SELECT structures_subjects.structure_id
                                                      FROM structures_subjects)
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.enrollment_points.id,
    oramalocal.enrollment_points.created_at,
    oramalocal.enrollment_points.updated_at,
    oramalocal.enrollment_points.deleted_at,
    oramalocal.enrollment_points.name,
    oramalocal.enrollment_points.authorized,
    oramalocal.enrollment_points.goal
  FROM oramalocal.enrollment_points
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.enrollment_informations.id,
    oramalocal.enrollment_informations.change_cause,
    oramalocal.enrollment_informations.standard_id,
    oramalocal.enrollment_informations.family,
    oramalocal.enrollment_informations.how_hear,
    oramalocal.enrollment_informations.source,
    oramalocal.enrollment_informations.created_at,
    oramalocal.enrollment_informations.updated_at,
    oramalocal.enrollment_informations.deleted_at,
    oramalocal.enrollment_informations.full_name,
    oramalocal.enrollment_informations.phone,
    oramalocal.enrollment_informations.email,
    oramalocal.enrollment_informations.note,
    oramalocal.enrollment_informations.from
  FROM oramalocal.enrollment_informations
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.enrollment_information_person.enrollment_point,
    oramalocal.enrollment_information_person.person_id,
    oramalocal.enrollment_information_person.priority,
    oramalocal.enrollment_information_person.information_id,
    oramalocal.enrollment_information_person.student_id
  FROM oramalocal.enrollment_information_person
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.documents.id,
    oramalocal.documents.structure_id,
    oramalocal.documents.created_at,
    oramalocal.documents.updated_at,
    oramalocal.documents.deleted_at,
    oramalocal.documents.name,
    oramalocal.documents.description
  FROM oramalocal.documents
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.enrollments.id,
    oramalocal.enrollments.structure_id,
    oramalocal.enrollments.order,
    oramalocal.enrollments.is_required,
    oramalocal.enrollments.is_public,
    oramalocal.enrollments.verification,
    CASE oramalocal.enrollments.type + 0
    WHEN 1
      THEN 2
    WHEN 2
      THEN 9
    WHEN 3
      THEN 12
    WHEN 4
      THEN 13
    WHEN 5
      THEN 14
    WHEN 6
      THEN 15
    WHEN 7
      THEN 17
    END,
    oramalocal.enrollments.to_status + 0,
    oramalocal.enrollments.created_at,
    oramalocal.enrollments.updated_at,
    oramalocal.enrollments.deleted_at,
    oramalocal.enrollments.name,
    oramalocal.enrollments.description,
    oramalocal.enrollments.help,
    oramalocal.enrollments.data
  FROM oramalocal.enrollments
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.student_enrollments.id,
    oramalocal.student_enrollments.people_id,
    oramalocal.student_enrollments.enrollment_id,
    oramalocal.student_enrollments.status,
    oramalocal.student_enrollments.assessment,
    oramalocal.student_enrollments.doer_id,
    oramalocal.student_enrollments.editor_id,
    oramalocal.student_enrollments.created_at,
    oramalocal.student_enrollments.updated_at,
    oramalocal.student_enrollments.deleted_at,
    oramalocal.student_enrollments.expected_at,
    oramalocal.student_enrollments.completed_at,
    oramalocal.student_enrollments.comment,
    oramalocal.student_enrollments.data
  FROM oramalocal.student_enrollments
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.appointments.id,
    oramalocal.appointments.people_id,
    oramalocal.appointments.facility_id,
    oramalocal.appointments.created_at,
    oramalocal.appointments.updated_at,
    oramalocal.appointments.deleted_at,
    oramalocal.appointments.start_at,
    oramalocal.appointments.end_at,
    oramalocal.appointments.subject,
    oramalocal.appointments.peoples,
    oramalocal.appointments.note,
    oramalocal.appointments.comment
  FROM oramalocal.appointments
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.group_teacher.group_id,
    oramalocal.group_teacher.teacher_id,
    oramalocal.group_teacher.subject_id,
    oramalocal.group_teacher.type + 0
  FROM oramalocal.group_teacher
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
  WHERE teachers_groups.teacher_id IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW
    oramalocal.teacher_criteria.id,
    teachers_groups.id,
    oramalocal.teacher_criteria.subject_id,
    oramalocal.teacher_criteria.criteria_id,
    oramalocal.teacher_criteria.created_at,
    oramalocal.teacher_criteria.updated_at,
    oramalocal.teacher_criteria.deleted_at,
    NULL
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND
                                 oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.registrations.id,
    oramalocal.registrations.degree_id,
    oramalocal.registrations.student_id,
    oramalocal.registrations.editor_id,
    IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
    CASE oramalocal.registrations.status
    WHEN 'Activo'
      THEN 1
    WHEN 'Baja temporal'
      THEN 1
    WHEN 'Condicionado'
      THEN 1
    WHEN 'Retenido'
      THEN 1
    WHEN 'Suspendido'
      THEN 1
    WHEN 'Baja'
      THEN 0
    WHEN 'Expulsado'
      THEN 0
    WHEN 'Negado'
      THEN 3
    WHEN 'Pendiente'
      THEN 2
    WHEN 'Admitido'
      THEN 2
    WHEN 'Aprobado'
      THEN 3
    WHEN 'Egresado'
      THEN 0
    WHEN 'Informes'
      THEN 2
    WHEN 'Aspirante'
      THEN 2
    WHEN 'Desistió'
      THEN 2
    WHEN 'En espera'
      THEN 2
    WHEN 'Pendiente de egresar'
      THEN 0
    END,
    (SELECT id
     FROM registrations_modes
     WHERE name = oramalocal.registrations.status),
    oramalocal.registrations.cause + 0,
    oramalocal.registrations.created_at,
    oramalocal.registrations.updated_at,
    oramalocal.registrations.deleted_at,
    oramalocal.registrations.cause_at,
    NULL,
    oramalocal.registrations.note
  FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.group_student.group_id,
    oramalocal.group_student.student_id,
    oramalocal.group_student.list_in
  FROM oramalocal.group_student
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.grading_periods.id,
    oramalocal.grading_periods.period_id,
    oramalocal.grading_periods.publisher_id,
    oramalocal.grading_periods.required_review,
    oramalocal.grading_periods.status + 0,
    oramalocal.grading_periods.created_at,
    oramalocal.grading_periods.updated_at,
    oramalocal.grading_periods.deleted_at,
    oramalocal.grading_periods.start_at,
    oramalocal.grading_periods.limited_at,
    oramalocal.grading_periods.end_at,
    oramalocal.grading_periods.time,
    oramalocal.grading_periods.metadata
  FROM oramalocal.grading_periods
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.student_grades.id,
    oramalocal.student_grades.student_id,
    oramalocal.student_grades.evaluation_id,
    oramalocal.student_grades.grading_period,
    oramalocal.student_grades.teacher_id,
    oramalocal.student_grades.approved_by,
    oramalocal.student_grades.status,
    oramalocal.student_grades.grade,
    oramalocal.student_grades.created_at,
    oramalocal.student_grades.updated_at,
    oramalocal.student_grades.deleted_at,
    oramalocal.student_grades.committed_at,
    oramalocal.student_grades.comment,
    oramalocal.student_grades.note,
    oramalocal.student_grades.details
  FROM oramalocal.student_grades
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.messages.id,
    oramalocal.messages.target_id,
    oramalocal.messages.from,
    oramalocal.messages.transcribed_by,
    oramalocal.messages.type + 0,
    CASE oramalocal.messages.target_type
    WHEN
      'Orama\\Models\\People'
      THEN 'Modules\\Schools\\Students\\Models\\Student'
    WHEN 'Orama\\Models\\SchoolStructure'
      THEN 'Modules\\Schools\\Structures\\Models\\Structure'
    END,
    oramalocal.messages.signature_required,
    oramalocal.messages.notifications,
    oramalocal.messages.created_at,
    oramalocal.messages.updated_at,
    oramalocal.messages.deleted_at,
    oramalocal.messages.start_at,
    oramalocal.messages.remember_at,
    oramalocal.messages.end_at,
    oramalocal.messages.subtype,
    oramalocal.messages.subject,
    oramalocal.messages.message,
    IF(oramalocal.messages.data = 'null', NULL, oramalocal.messages.data)
  FROM oramalocal.messages
;-- -. . -..- - / . -. - .-. -.--
SELECT
    oramalocal.message_statuses.id,
    oramalocal.message_statuses.message_id,
    oramalocal.message_statuses.people_id,
    oramalocal.message_statuses.status + 0,
    oramalocal.message_statuses.created_at,
    oramalocal.message_statuses.updated_at,
    oramalocal.message_statuses.deleted_at,
    oramalocal.message_statuses.signature,
    oramalocal.message_statuses.data
  FROM oramalocal.message_statuses
;-- -. . -..- - / . -. - .-. -.--
SELECT
  shipment_id,
  container,
  count(item) AS item,
  SUM(price) AS price,
  MAX(created_at) AS created_at,
  MAX(updated_at) AS updated_at,
  MAX(deleted_at) AS deleted_at
FROM packages
GROUP BY shipment_id, container
;-- -. . -..- - / . -. - .-. -.--
SELECT
  shipment_id,
  container,
  count(item) AS item,
  SUM(price) AS price,
  MAX(created_at) AS created_at,
  MAX(updated_at) AS updated_at,
  MAX(deleted_at) AS deleted_at,
  GROUP_CONCAT(content) AS conctents
FROM packages
GROUP BY shipment_id, container
;-- -. . -..- - / . -. - .-. -.--
SELECT
  activities.vehicle_id,
  packages_status.package_id,
  packages_status.activity_id,
  packages_status.subsidiary_id,
  packages_status.staff_id,
  packages_status.status,
  packages_status.created_at,
  packages_status.updated_at,
  packages_status.deleted_at
FROM packages_status
  LEFT JOIN activities ON activities.id = packages_status.activity_id
WHERE status & (256 | 128 | 64 | 32)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  *
  FROM vehicles_packages_pre
;-- -. . -..- - / . -. - .-. -.--
SELECT
  vehicle_id,
  package_id,
  loaded - offloaded AS loaded,
  created_at,
  updated_at,
  deleted_at
FROM vehicles_packages_pre
;-- -. . -..- - / . -. - .-. -.--
SELECT
  vehicle_id,
  package_id,
  SUM(loaded - offloaded) AS loaded,
  max(created_at) AS created_at,
  max(updated_at) AS updated_at,
  max(deleted_at) AS deleted_at
FROM vehicles_packages_pre
GROUP BY vehicle_id, package_id
HAVING loaded >0
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` varchar() AS (SOUNDEX(content))) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` var_char() AS (SOUNDEX(content))) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR() AS (SOUNDEX(content))) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(255) AS (SOUNDEX(content))) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(255) AS (left(SOUNDEX(content)),255) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS (left(SOUNDEX(content)),250) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(5) AS (left(id,5)) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(5) AS (left(list,5)) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS (left(SOUNDEX(`content`)),250) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS ('C') PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS (SOUNDEX('C')) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS (SOUNDEX(id)) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS (SOUNDEX(`list`)) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE `prices` (
  `list` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'Lista de precios',
  `container_id` int(10) unsigned NOT NULL COMMENT 'Tipo de contendedor, ej: ',
  `price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT 'Precio del contenedor con contenido',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Contenido',
  `id` char(32) AS (MD5(CONCAT_WS("-",list, container_id, SOUNDEX(content)))) PERSISTENT,
  `content_sound` varchar(250) AS (SOUNDEX(`content`)) PERSISTENT,
  UNIQUE KEY `id` (`id`),
  KEY `prices_list_index` (`list`),
  KEY `prices_container_id_index` (`container_id`),
  CONSTRAINT `FK_price_container` FOREIGN KEY (`container_id`) REFERENCES `containers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Cotizado/lista básico de paquetes'
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE prices ADD COLUMN `content_sound` VARCHAR(250) AS (SOUNDEX(`content`)) PERSISTENT
;-- -. . -..- - / . -. - .-. -.--
UPDATE cashiers
SET balance = balance - NEW.amount
WHERE id = NEW.cashier_id
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE cashiers
;-- -. . -..- - / . -. - .-. -.--
SELECT version()
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET @OLD_CHARACTER_SET_CLIENT = @@CHARACTER_SET_CLIENT */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET @OLD_CHARACTER_SET_RESULTS = @@CHARACTER_SET_RESULTS */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET @OLD_COLLATION_CONNECTION = @@COLLATION_CONNECTION */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET NAMES utf8 */
;-- -. . -..- - / . -. - .-. -.--
/*!40103 SET @OLD_TIME_ZONE = @@TIME_ZONE */
;-- -. . -..- - / . -. - .-. -.--
/*!40103 SET TIME_ZONE = '+00:00' */
;-- -. . -..- - / . -. - .-. -.--
/*!40014 SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0 */
;-- -. . -..- - / . -. - .-. -.--
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0 */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO' */
;-- -. . -..- - / . -. - .-. -.--
/*!40111 SET @OLD_SQL_NOTES = @@SQL_NOTES, SQL_NOTES = 0 */
;-- -. . -..- - / . -. - .-. -.--
/*!40112 SET @OLD_lc_time_names = @@lc_time_names */
;-- -. . -..- - / . -. - .-. -.--
/*!40112 SET lc_time_names = 'es_MX' */
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures (id,
                         parent_id,
                         master_id,
                         order_at,
                         tree,
                         type,
                         name)
  SELECT
    id,
    IF(type - 2 = 9, 0, parent),
    `master`,
    `order`,
    tree + 0,
    type - 2,
    `name`
  FROM oramalocal.school_structures
  WHERE IF(tree + 0 = 8, master = 0, TRUE)
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_school_years (
  structure_id,
  status,
  inscription_at,
  starts_at,
  ends_at,
  description,
  config
)
  SELECT
    oramalocal.schoolyears.structure_id,
    oramalocal.schoolyears.status - 1,
    oramalocal.schoolyears.inscription_at,
    oramalocal.schoolyears.starts_at,
    oramalocal.schoolyears.ends_at,
    oramalocal.schoolyears.description,
    oramalocal.schoolyears.config
  FROM oramalocal.schoolyears
    INNER JOIN matelangular.structures
      ON structures.id = oramalocal.schoolyears.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_periods (
  structure_id,
  display,
  extraordinary,
  test,
  quantity,
  title,
  short_name,
  titration
)
  SELECT
    oramalocal.periods.structure_id,
    oramalocal.periods.display,
    oramalocal.periods.extraordinary,
    oramalocal.periods.test,
    oramalocal.periods.quantity,
    oramalocal.periods.title,
    oramalocal.periods.short_name,
    oramalocal.periods.titration
  FROM oramalocal.periods
    INNER JOIN structures
      ON structures.id = oramalocal.periods.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_sites (
  structure_id,
  responsible,
  config
)
  SELECT
    oramalocal.sites.structure_id,
    oramalocal.sites.responsible,
    oramalocal.sites.config
  FROM oramalocal.sites
    INNER JOIN structures
      ON structures.id = oramalocal.sites.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_levels (
  structure_id,
  period_id,
  standard_id,
  code,
  short_name,
  description,
  governmental,
  responsible
)
  SELECT
    oramalocal.levels.structure_id,
    oramalocal.levels.period_id,
    oramalocal.levels.standard_id,
    oramalocal.levels.code,
    oramalocal.levels.short_name,
    oramalocal.levels.description,
    oramalocal.levels.governmental,
    oramalocal.levels.responsible
  FROM oramalocal.levels
    INNER JOIN structures
      ON structures.id = oramalocal.levels.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_degrees (
  structure_id,
  standard_id,
  capacity,
  short_name,
  description
)
  SELECT
    oramalocal.degrees.structure_id,
    oramalocal.degrees.standard_id,
    oramalocal.degrees.capacity,
    oramalocal.degrees.short_name,
    oramalocal.degrees.description
  FROM oramalocal.degrees
    INNER JOIN structures
      ON structures.id = oramalocal.degrees.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_groups (
  structure_id,
  facility_id,
  plan_id,
  scope,
  short_name,
  responsible
)
  SELECT
    oramalocal.school_groups.structure_id,
    oramalocal.school_groups.facility_id,
    CASE oramalocal.school_groups.study_branch_id
    WHEN 196
      THEN 156
    WHEN 283
      THEN 136
    WHEN 288
      THEN 156
    WHEN 311
      THEN 156
    ELSE oramalocal.school_groups.study_branch_id
    END,
    oramalocal.school_groups.scope,
    oramalocal.school_groups.short_name,
    oramalocal.school_groups.responsible
  FROM oramalocal.school_groups
    INNER JOIN structures
      ON structures.id = oramalocal.school_groups.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_facilities (
  structure_id,
  restriction,
  status,
  capacity,
  use_as,
  created_at,
  updated_at,
  deleted_at,
  code,
  description,
  note
)
  SELECT
    oramalocal.facilities.structure_id,
    oramalocal.facilities.restriction,
    oramalocal.facilities.status,
    oramalocal.facilities.capacity,
    oramalocal.facilities.use_as,
    oramalocal.facilities.created_at,
    oramalocal.facilities.updated_at,
    oramalocal.facilities.deleted_at,
    oramalocal.facilities.code,
    oramalocal.facilities.description,
    oramalocal.facilities.note
  FROM oramalocal.facilities
    INNER JOIN structures
      ON structures.id = oramalocal.facilities.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_plans (
  structure_id,
  description,
  governmental,
  standard_levels
)
  SELECT
    oramalocal.study_plans.structure_id,
    oramalocal.study_plans.description,
    oramalocal.study_plans.governmental,
    replace(oramalocal.study_plans.levels_ids, '"', '')
  FROM oramalocal.study_plans
    INNER JOIN structures
      ON structures.id = oramalocal.study_plans.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO structures_subjects (
  structure_id,
  standard_id,
  academic,
  behavior,
  report
)
  SELECT
    oramalocal.subject_groups.structure_id,
    oramalocal.subject_groups.standard_id,
    oramalocal.subject_groups.academic,
    oramalocal.subject_groups.behavior,
    oramalocal.subject_groups.report
  FROM oramalocal.subject_groups
    INNER JOIN structures
      ON structures.id = oramalocal.subject_groups.structure_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO people (
  id,
  created_at,
  updated_at,
  deleted_at,
  gender,
  birth_at,
  citizen_identifier,
  tax_id,
  first_name,
  second_name,
  names,
  short_name,
  note,
  birth_place,
  emails,
  marital_status,
  nationalities,
  other_info,
  phones
) SELECT
    oramalocal.people.id,
    oramalocal.people.created_at,
    oramalocal.people.updated_at,
    oramalocal.people.deleted_at,
    oramalocal.people.gender,
    oramalocal.people.birth_at,
    oramalocal.people.citizen_identifier,
    oramalocal.people.tax_id,
    oramalocal.people.first_name,
    oramalocal.people.second_name,
    oramalocal.people.names,
    oramalocal.people.short_name,
    oramalocal.people.note,
    oramalocal.people.birth_place,
    oramalocal.people.emails,
    oramalocal.people.marital_status,
    oramalocal.people.nationalities,
    oramalocal.people.other_info,
    oramalocal.people.phones
  FROM oramalocal.people
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO families (
  id,
  contact_id,
  created_at,
  updated_at,
  deleted_at,
  first_name,
  second_name,
  note,
  marital
)
  SELECT
    oramalocal.families.id,
    oramalocal.families.contact_id,
    oramalocal.families.created_at,
    oramalocal.families.updated_at,
    oramalocal.families.deleted_at,
    oramalocal.families.first_name,
    oramalocal.families.second_name,
    oramalocal.families.note,
    oramalocal.families.marital
  FROM oramalocal.families
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO families_people (
  family_id,
  people_id,
  people_pickup,
  type
)
  SELECT
    oramalocal.family_people.family_id,
    oramalocal.family_people.people_id,
    oramalocal.family_people.people_pickup,
    oramalocal.family_people.type + 0
  FROM oramalocal.family_people
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students (
  person_id,
  created_at,
  updated_at,
  deleted_at,
  enrollment_at,
  school_enrollment,
  note,
  enrollment_info,
  tutors
)
  SELECT
    oramalocal.students.people_id,
    oramalocal.students.created_at,
    oramalocal.students.updated_at,
    oramalocal.students.deleted_at,
    oramalocal.students.enrollment_at,
    oramalocal.students.school_enrollment,
    oramalocal.students.note,
    oramalocal.students.enrollment_info,
    oramalocal.students.tutor
  FROM oramalocal.students
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers (
  person_id,
  status,
  type,
  created_at,
  updated_at,
  deleted_at,
  ingress_at,
  certificate,
  language,
  position,
  internal_code,
  specialities,
  curriculum,
  notes
)
  SELECT
    oramalocal.teachers.people_id,
    oramalocal.teachers.status,
    oramalocal.teachers.type + 0,
    oramalocal.teachers.created_at,
    oramalocal.teachers.updated_at,
    oramalocal.teachers.deleted_at,
    oramalocal.teachers.ingress_at,
    oramalocal.teachers.certificate,
    oramalocal.teachers.language,
    oramalocal.teachers.position,
    oramalocal.teachers.internal_code,
    oramalocal.teachers.specialities,
    oramalocal.teachers.curriculum,
    oramalocal.teachers.notes
  FROM oramalocal.teachers
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO tuitions (
  id,
  structure_id,
  created_at,
  updated_at,
  deleted_at,
  type,
  name,
  in_ledger,
  in_ledger_description,
  previous_ledger,
  previous_ledger_description,
  surcharge_ledger,
  surcharge_ledger_description,
  config
)
  SELECT
    oramalocal.tuitions.id,
    oramalocal.tuitions.structure_id,
    oramalocal.tuitions.created_at,
    oramalocal.tuitions.updated_at,
    oramalocal.tuitions.deleted_at,
    oramalocal.tuitions.type + 0,
    oramalocal.tuitions.name,
    oramalocal.tuitions.in_ledger,
    oramalocal.tuitions.in_ledger_description,
    oramalocal.tuitions.previous_ledger,
    oramalocal.tuitions.previous_ledger_description,
    oramalocal.tuitions.surcharge_ledger,
    oramalocal.tuitions.surcharge_ledger_description,
    oramalocal.tuitions.config
  FROM oramalocal.tuitions
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO scholarships (
  id,
  percentage,
  request,
  academic,
  behavior,
  created_at,
  updated_at,
  deleted_at,
  name,
  amounts
)
  SELECT
    oramalocal.scholarships.id,
    oramalocal.scholarships.percentage,
    oramalocal.scholarships.request,
    oramalocal.scholarships.academic,
    oramalocal.scholarships.behavior,
    oramalocal.scholarships.created_at,
    oramalocal.scholarships.updated_at,
    oramalocal.scholarships.deleted_at,
    oramalocal.scholarships.name,
    oramalocal.scholarships.amounts
  FROM oramalocal.scholarships
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students_scholarships (
  id,
  school_year_id,
  student_id,
  scholarship_id,
  renovation,
  percentage,
  created_at,
  updated_at,
  deleted_at,
  comment,
  specific_amounts
)
  SELECT
    oramalocal.student_scholarships.id,
    oramalocal.student_scholarships.schoolyear_id,
    oramalocal.student_scholarships.student_id,
    oramalocal.student_scholarships.scholarship_id,
    oramalocal.student_scholarships.renovation,
    oramalocal.student_scholarships.percentage,
    oramalocal.student_scholarships.created_at,
    oramalocal.student_scholarships.updated_at,
    oramalocal.student_scholarships.deleted_at,
    oramalocal.student_scholarships.comment,
    oramalocal.student_scholarships.specific_amounts
  FROM oramalocal.student_scholarships
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students_tuitions (
  id,
  student_id,
  tuition_id,
  payment_index,
  payment_time,
  type,
  amount,
  created_at,
  updated_at,
  deleted_at,
  expected_at,
  title
)
  SELECT
    oramalocal.student_tuitions.id,
    oramalocal.student_tuitions.student_id,
    oramalocal.student_tuitions.tuition_id,
    oramalocal.student_tuitions.payment_index,
    oramalocal.student_tuitions.payment_time,
    CASE oramalocal.student_tuitions.type + 0
    WHEN 1
      THEN 1
    WHEN 2
      THEN -1
    WHEN 3
      THEN 2
    END,
    oramalocal.student_tuitions.amount,
    oramalocal.student_tuitions.created_at,
    oramalocal.student_tuitions.updated_at,
    oramalocal.student_tuitions.deleted_at,
    oramalocal.student_tuitions.expected_at,
    CONCAT(oramalocal.tuitions.name, ' (',
           DATE_FORMAT(oramalocal.student_tuitions.expected_at, "%M"), ' ',
           DATE_FORMAT(oramalocal.student_tuitions.expected_at, "%Y"), ')')
  FROM oramalocal.student_tuitions
    LEFT JOIN oramalocal.tuitions
      ON oramalocal.tuitions.id = oramalocal.student_tuitions.tuition_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO payments (
  id,
  person_id,
  cashier_id,
  type,
  amount,
  created_at,
  updated_at,
  deleted_at,
  payed_at,
  folio,
  note,
  info
)
  SELECT
    oramalocal.payments.id,
    oramalocal.payments.people_id,
    oramalocal.payments.cashier_id,
    oramalocal.payments.type + 0,
    oramalocal.payments.amount,
    oramalocal.payments.created_at,
    oramalocal.payments.updated_at,
    oramalocal.payments.deleted_at,
    oramalocal.payments.payed_at,
    CONCAT_WS('-', oramalocal.payments.sequence, oramalocal.payments.folio),
    oramalocal.payments.note,
    oramalocal.payments.info
  FROM oramalocal.payments
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO invoices (
  id,
  person_id,
  type,
  status,
  amount,
  created_at,
  updated_at,
  deleted_at,
  invoice_at,
  folio,
  concept,
  details
)
  SELECT
    oramalocal.invoices.id,
    oramalocal.invoices.people_id,
    oramalocal.invoices.type + 0,
    oramalocal.invoices.status + 0,
    oramalocal.invoices.amount,
    oramalocal.invoices.created_at,
    oramalocal.invoices.updated_at,
    oramalocal.invoices.deleted_at,
    oramalocal.invoices.invoice_at,
    CONCAT_WS('-', oramalocal.invoices.sequence, oramalocal.invoices.folio),
    oramalocal.invoices.concept,
    oramalocal.invoices.receiver
  FROM oramalocal.invoices
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO invoice_data (
  tax_id,
  created_at,
  updated_at,
  deleted_at,
  business_name,
  email
)
  SELECT DISTINCT
    oramalocal.student_payment_options.tax_id,
    oramalocal.student_payment_options.created_at,
    oramalocal.student_payment_options.updated_at,
    oramalocal.student_payment_options.deleted_at,
    oramalocal.student_payment_options.business_name,
    oramalocal.student_payment_options.email
  FROM oramalocal.student_payment_options
  ORDER BY oramalocal.student_payment_options.updated_at DESC
;-- -. . -..- - / . -. - .-. -.--
SELECT "Ejecutar script para generar direcciones del estractro"
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO invoice_assignments (
  invoice_datum_id,
  split_type,
  split_amount,
  assignable_id,
  created_at,
  updated_at,
  deleted_at,
  assignable_type
)
  SELECT
    invoice_data.id,
    oramalocal.student_payment_options.percentage,
    oramalocal.student_payment_options.amount,
    oramalocal.student_payment_options.student_id,
    oramalocal.student_payment_options.created_at,
    oramalocal.student_payment_options.updated_at,
    oramalocal.student_payment_options.deleted_at,
    'Modules\\Schools\\Students\\Models\\Student'
  FROM oramalocal.student_payment_options
    LEFT JOIN invoice_data ON oramalocal.student_payment_options.tax_id = invoice_data.tax_id
  ORDER BY oramalocal.student_payment_options.updated_at DESC
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students_payments (
  id,
  student_tuition_id,
  payment_id,
  invoice_id,
  amount,
  created_at,
  updated_at,
  deleted_at
)
  SELECT
    oramalocal.student_payments.id,
    oramalocal.student_payments.student_tuition_id,
    oramalocal.student_payments.payment_id,
    oramalocal.student_payments.invoice_id,
    oramalocal.student_payments.amount,
    oramalocal.student_payments.created_at,
    oramalocal.student_payments.updated_at,
    oramalocal.student_payments.deleted_at
  FROM oramalocal.student_payments
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO cashiers_drops (
  id,
  cashier_id,
  person_id,
  amount,
  created_at,
  updated_at,
  deleted_at,
  note
)
  SELECT
    oramalocal.cashier_drops.id,
    oramalocal.cashier_drops.cashier_id,
    oramalocal.cashier_drops.people_id,
    oramalocal.cashier_drops.amount,
    oramalocal.cashier_drops.created_at + 0,
    oramalocal.cashier_drops.updated_at,
    oramalocal.cashier_drops.deleted_at,
    oramalocal.cashier_drops.note
  FROM oramalocal.cashier_drops
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO cashiers (
  id,
  folio,
  maximum,
  balance,
  status,
  created_at,
  updated_at,
  deleted_at,
  box_cut_at,
  name,
  sequence,
  authorized
)
  SELECT
    oramalocal.cashiers.id,
    oramalocal.cashiers.folio,
    oramalocal.cashiers.maximum,
    oramalocal.cashiers.balance,
    oramalocal.cashiers.status + 0,
    oramalocal.cashiers.created_at,
    oramalocal.cashiers.updated_at,
    oramalocal.cashiers.deleted_at,
    oramalocal.cashiers.box_cut_at,
    oramalocal.cashiers.name,
    oramalocal.cashiers.sequence,
    oramalocal.cashiers.authorized
  FROM oramalocal.cashiers
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO scales (
  id,
  plan_id,
  type,
  round_type,
  decimals,
  min,
  max,
  passing,
  display_min,
  let_down,
  cheating,
  created_at,
  updated_at,
  deleted_at,
  name,
  literals,
  qualitative
)
  SELECT
    oramalocal.scales.id,
    oramalocal.study_plans.structure_id,
    oramalocal.scales.type,
    oramalocal.scales.round_type,
    oramalocal.scales.decimals,
    oramalocal.scales.min,
    oramalocal.scales.max,
    oramalocal.scales.passing,
    oramalocal.scales.display_min,
    oramalocal.scales.let_down,
    oramalocal.scales.cheating,
    oramalocal.scales.created_at,
    oramalocal.scales.updated_at,
    oramalocal.scales.deleted_at,
    oramalocal.scales.name,
    oramalocal.scales.literals,
    oramalocal.scales.qualitative
  FROM oramalocal.scales
    LEFT JOIN oramalocal.full_heritage
      ON oramalocal.scales.structure_id = oramalocal.full_heritage.structure_id
    LEFT JOIN oramalocal.study_plans
      ON FIND_IN_SET(oramalocal.study_plans.structure_id, oramalocal.full_heritage.sons)
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO criteria (
  id,
  plan_id,
  scale_id,
  editable,
  comments,
  created_at,
  updated_at,
  deleted_at,
  name,
  description,
  concepts
)
  SELECT
    oramalocal.criteria.id,
    oramalocal.study_plans.structure_id,
    oramalocal.criteria.scale_id,
    oramalocal.criteria.editable,
    oramalocal.criteria.comments,
    oramalocal.criteria.created_at,
    oramalocal.criteria.updated_at,
    oramalocal.criteria.deleted_at,
    oramalocal.criteria.name,
    oramalocal.criteria.description,
    oramalocal.criteria.concepts
  FROM oramalocal.criteria
    LEFT JOIN oramalocal.full_heritage
      ON oramalocal.criteria.structure_id = oramalocal.full_heritage.structure_id
    LEFT JOIN oramalocal.study_plans
      ON FIND_IN_SET(oramalocal.study_plans.structure_id, oramalocal.full_heritage.sons)
  WHERE oramalocal.study_plans.structure_id IN (SELECT structures_plans.structure_id
                                                FROM structures_plans)
        AND oramalocal.criteria.scale_id IN (SELECT scales.id
                                             FROM scales)
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO subjects (
  id,
  parent_id,
  standard_id,
  predecessor_id,
  criteria_id,
  order_at,
  proposal,
  classification,
  scope,
  created_at,
  updated_at,
  deleted_at,
  governmental,
  name,
  short_name,
  abbreviations,
  code,
  config
)
  SELECT
    oramalocal.subjects.id,
    oramalocal.subjects.parent,
    oramalocal.subjects.standard_id,
    0,
    oramalocal.subjects.criteria_id,
    IFNULL(oramalocal.subjects.order_at, 0),
    #     oramalocal.subjects.criteria_edit,
    oramalocal.subjects.proposal + 0,
    oramalocal.subjects.classification + 0,
    oramalocal.subjects.scope + 0,
    oramalocal.subjects.created_at,
    oramalocal.subjects.updated_at,
    oramalocal.subjects.deleted_at,
    oramalocal.subjects.governmental,
    oramalocal.subjects.name,
    oramalocal.subjects.short_name,
    oramalocal.subjects.abbreviations,
    oramalocal.subjects.code,
    oramalocal.subjects.report
  FROM oramalocal.subjects
  WHERE oramalocal.subjects.standard_id IN (SELECT structures_standards.structure_id
                                            FROM structures_standards)
        AND oramalocal.subjects.criteria_id IN (SELECT criteria.id
                                                FROM criteria)
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO subjects_assignments (
  subject_id,
  assigned_id,
  assigned_type
)
  SELECT
    oramalocal.plan_subjects.subject_id,
    oramalocal.plan_subjects.subject_group_id,
    'Modules\\Schools\\Structures\\Models\\SubjectGroup'
  FROM oramalocal.plan_subjects
  WHERE oramalocal.plan_subjects.subject_group_id IN (SELECT structures_subjects.structure_id
                                                      FROM structures_subjects)
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO enrollments_points (
  id,
  created_at,
  updated_at,
  deleted_at,
  name,
  authorized,
  goal
)
  SELECT
    oramalocal.enrollment_points.id,
    oramalocal.enrollment_points.created_at,
    oramalocal.enrollment_points.updated_at,
    oramalocal.enrollment_points.deleted_at,
    oramalocal.enrollment_points.name,
    oramalocal.enrollment_points.authorized,
    oramalocal.enrollment_points.goal
  FROM oramalocal.enrollment_points
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO enrollments_information (
  id,
  change_cause,
  standard_id,
  family,
  how_hear,
  source,
  created_at,
  updated_at,
  deleted_at,
  full_name,
  phone,
  email,
  note,
  `from`
)
  SELECT
    oramalocal.enrollment_informations.id,
    oramalocal.enrollment_informations.change_cause,
    oramalocal.enrollment_informations.standard_id,
    oramalocal.enrollment_informations.family,
    oramalocal.enrollment_informations.how_hear,
    oramalocal.enrollment_informations.source,
    oramalocal.enrollment_informations.created_at,
    oramalocal.enrollment_informations.updated_at,
    oramalocal.enrollment_informations.deleted_at,
    oramalocal.enrollment_informations.full_name,
    oramalocal.enrollment_informations.phone,
    oramalocal.enrollment_informations.email,
    oramalocal.enrollment_informations.note,
    oramalocal.enrollment_informations.from
  FROM oramalocal.enrollment_informations
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO enrollments_information_person (
  enrollment_point_id,
  person_id,
  priority,
  information_id,
  student_id
)
  SELECT
    oramalocal.enrollment_information_person.enrollment_point,
    oramalocal.enrollment_information_person.person_id,
    oramalocal.enrollment_information_person.priority,
    oramalocal.enrollment_information_person.information_id,
    oramalocal.enrollment_information_person.student_id
  FROM oramalocal.enrollment_information_person
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO documents (
  id,
  structure_id,
  created_at,
  updated_at,
  deleted_at,
  name,
  description
)
  SELECT
    oramalocal.documents.id,
    oramalocal.documents.structure_id,
    oramalocal.documents.created_at,
    oramalocal.documents.updated_at,
    oramalocal.documents.deleted_at,
    oramalocal.documents.name,
    oramalocal.documents.description
  FROM oramalocal.documents
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO enrollments (
  id,
  structure_id,
  order_at,
  is_required,
  is_public,
  verification,
  type,
  to_status,
  created_at,
  updated_at,
  deleted_at,
  name,
  description,
  help,
  data
)
  SELECT
    oramalocal.enrollments.id,
    oramalocal.enrollments.structure_id,
    oramalocal.enrollments.order,
    oramalocal.enrollments.is_required,
    oramalocal.enrollments.is_public,
    oramalocal.enrollments.verification,
    CASE oramalocal.enrollments.type + 0
    WHEN 1
      THEN 2
    WHEN 2
      THEN 9
    WHEN 3
      THEN 12
    WHEN 4
      THEN 13
    WHEN 5
      THEN 14
    WHEN 6
      THEN 15
    WHEN 7
      THEN 17
    END,
    oramalocal.enrollments.to_status + 0,
    oramalocal.enrollments.created_at,
    oramalocal.enrollments.updated_at,
    oramalocal.enrollments.deleted_at,
    oramalocal.enrollments.name,
    oramalocal.enrollments.description,
    oramalocal.enrollments.help,
    oramalocal.enrollments.data
  FROM oramalocal.enrollments
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students_enrollment (
  id,
  student_id,
  enrollment_id,
  status,
  assessment,
  doer_id,
  editor_id,
  created_at,
  updated_at,
  deleted_at,
  expected_at,
  completed_at,
  comment,
  data
)
  SELECT
    oramalocal.student_enrollments.id,
    oramalocal.student_enrollments.people_id,
    oramalocal.student_enrollments.enrollment_id,
    oramalocal.student_enrollments.status,
    oramalocal.student_enrollments.assessment,
    oramalocal.student_enrollments.doer_id,
    oramalocal.student_enrollments.editor_id,
    oramalocal.student_enrollments.created_at,
    oramalocal.student_enrollments.updated_at,
    oramalocal.student_enrollments.deleted_at,
    oramalocal.student_enrollments.expected_at,
    oramalocal.student_enrollments.completed_at,
    oramalocal.student_enrollments.comment,
    oramalocal.student_enrollments.data
  FROM oramalocal.student_enrollments
;-- -. . -..- - / . -. - .-. -.--
SELECT "Ejecutar script para extraer documentos del usuario o enrolment"
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO appointments (
  id,
  teacher_id,
  facility_id,
  created_at,
  updated_at,
  deleted_at,
  start_at,
  end_at,
  subject,
  peoples_ids,
  note,
  comment
)
  SELECT
    oramalocal.appointments.id,
    oramalocal.appointments.people_id,
    oramalocal.appointments.facility_id,
    oramalocal.appointments.created_at,
    oramalocal.appointments.updated_at,
    oramalocal.appointments.deleted_at,
    oramalocal.appointments.start_at,
    oramalocal.appointments.end_at,
    oramalocal.appointments.subject,
    oramalocal.appointments.peoples,
    oramalocal.appointments.note,
    oramalocal.appointments.comment
  FROM oramalocal.appointments
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id,
  subject_id,
  type
)
  SELECT
    oramalocal.group_teacher.group_id,
    oramalocal.group_teacher.teacher_id,
    oramalocal.group_teacher.subject_id,
    oramalocal.group_teacher.type + 0
  FROM oramalocal.group_teacher
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_groups (
  group_id,
  teacher_id
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.group_id,
    oramalocal.teacher_criteria.teacher_id
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND oramalocal.teacher_criteria.group_id = teachers_groups.group_id
  WHERE teachers_groups.teacher_id IS NULL
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO teachers_criteria (
  id,
  teacher_group_id,
  subject_id,
  criterion_id,
  created_at,
  updated_at,
  deleted_at,
  concepts
)
  SELECT DISTINCTROW
    oramalocal.teacher_criteria.id,
    teachers_groups.id,
    oramalocal.teacher_criteria.subject_id,
    oramalocal.teacher_criteria.criteria_id,
    oramalocal.teacher_criteria.created_at,
    oramalocal.teacher_criteria.updated_at,
    oramalocal.teacher_criteria.deleted_at,
    NULL
  FROM oramalocal.teacher_criteria
    LEFT JOIN teachers_groups ON oramalocal.teacher_criteria.teacher_id = teachers_groups.teacher_id
                                 AND
                                 oramalocal.teacher_criteria.group_id = teachers_groups.group_id
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO registrations (
  id,
  degree_id,
  student_id,
  editor_id,
  type,
  status,
  registrations_mode_id,
  cause,
  created_at,
  updated_at,
  deleted_at,
  cause_at,
  review_at,
  note
)
  SELECT
    oramalocal.registrations.id,
    oramalocal.registrations.degree_id,
    oramalocal.registrations.student_id,
    oramalocal.registrations.editor_id,
    IF(oramalocal.registrations.intention = 1, 2, oramalocal.registrations.intention),
    CASE oramalocal.registrations.status
    WHEN 'Activo'
      THEN 1
    WHEN 'Baja temporal'
      THEN 1
    WHEN 'Condicionado'
      THEN 1
    WHEN 'Retenido'
      THEN 1
    WHEN 'Suspendido'
      THEN 1
    WHEN 'Baja'
      THEN 0
    WHEN 'Expulsado'
      THEN 0
    WHEN 'Negado'
      THEN 3
    WHEN 'Pendiente'
      THEN 2
    WHEN 'Admitido'
      THEN 2
    WHEN 'Aprobado'
      THEN 3
    WHEN 'Egresado'
      THEN 0
    WHEN 'Informes'
      THEN 2
    WHEN 'Aspirante'
      THEN 2
    WHEN 'Desistió'
      THEN 2
    WHEN 'En espera'
      THEN 2
    WHEN 'Pendiente de egresar'
      THEN 0
    END,
    (SELECT id
     FROM registrations_modes
     WHERE name = oramalocal.registrations.status),
    oramalocal.registrations.cause + 0,
    oramalocal.registrations.created_at,
    oramalocal.registrations.updated_at,
    oramalocal.registrations.deleted_at,
    oramalocal.registrations.cause_at,
    NULL,
    oramalocal.registrations.note
  FROM oramalocal.registrations
;-- -. . -..- - / . -. - .-. -.--
UPDATE registrations
SET review_at = ADDDATE(cause_at, 30)
WHERE registrations_mode_id IS NOT NULL
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students_groups (
  group_id,
  student_id,
  list_in
)
  SELECT
    oramalocal.group_student.group_id,
    oramalocal.group_student.student_id,
    oramalocal.group_student.list_in
  FROM oramalocal.group_student
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO periods_grading (
  id,
  period_id,
  publisher_id,
  required_review,
  status,
  created_at,
  updated_at,
  deleted_at,
  start_at,
  limited_at,
  end_at,
  time,
  metadata
)
  SELECT
    oramalocal.grading_periods.id,
    oramalocal.grading_periods.period_id,
    oramalocal.grading_periods.publisher_id,
    oramalocal.grading_periods.required_review,
    oramalocal.grading_periods.status + 0,
    oramalocal.grading_periods.created_at,
    oramalocal.grading_periods.updated_at,
    oramalocal.grading_periods.deleted_at,
    oramalocal.grading_periods.start_at,
    oramalocal.grading_periods.limited_at,
    oramalocal.grading_periods.end_at,
    oramalocal.grading_periods.time,
    oramalocal.grading_periods.metadata
  FROM oramalocal.grading_periods
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO students_grades (
  id,
  student_id,
  evaluation_id,
  periods_grading_id,
  teacher_id,
  approved_by,
  status,
  grade,
  created_at,
  updated_at,
  deleted_at,
  committed_at,
  comment,
  note,
  details
)
  SELECT
    oramalocal.student_grades.id,
    oramalocal.student_grades.student_id,
    oramalocal.student_grades.evaluation_id,
    oramalocal.student_grades.grading_period,
    oramalocal.student_grades.teacher_id,
    oramalocal.student_grades.approved_by,
    oramalocal.student_grades.status,
    oramalocal.student_grades.grade,
    oramalocal.student_grades.created_at,
    oramalocal.student_grades.updated_at,
    oramalocal.student_grades.deleted_at,
    oramalocal.student_grades.committed_at,
    oramalocal.student_grades.comment,
    oramalocal.student_grades.note,
    oramalocal.student_grades.details
  FROM oramalocal.student_grades
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO messages (
  id,
  target_id,
  `from`,
  transcribed_by,
  type,
  target_type,
  signature_required,
  notifications,
  created_at,
  updated_at,
  deleted_at,
  start_at,
  remember_at,
  end_at,
  subtype,
  subject,
  message,
  data
)
  SELECT
    oramalocal.messages.id,
    oramalocal.messages.target_id,
    oramalocal.messages.from,
    oramalocal.messages.transcribed_by,
    oramalocal.messages.type + 0,
    CASE oramalocal.messages.target_type
    WHEN
      'Orama\\Models\\People'
      THEN 'Modules\\Schools\\Students\\Models\\Student'
    WHEN 'Orama\\Models\\SchoolStructure'
      THEN 'Modules\\Schools\\Structures\\Models\\Structure'
    END,
    oramalocal.messages.signature_required,
    oramalocal.messages.notifications,
    oramalocal.messages.created_at,
    oramalocal.messages.updated_at,
    oramalocal.messages.deleted_at,
    oramalocal.messages.start_at,
    oramalocal.messages.remember_at,
    oramalocal.messages.end_at,
    oramalocal.messages.subtype,
    oramalocal.messages.subject,
    oramalocal.messages.message,
    IF(oramalocal.messages.data = 'null', NULL, oramalocal.messages.data)
  FROM oramalocal.messages
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO messages_statuses (
  id,
  message_id,
  person_id,
  status,
  created_at,
  updated_at,
  deleted_at,
  signature,
  data
)
  SELECT
    oramalocal.message_statuses.id,
    oramalocal.message_statuses.message_id,
    oramalocal.message_statuses.people_id,
    oramalocal.message_statuses.status + 0,
    oramalocal.message_statuses.created_at,
    oramalocal.message_statuses.updated_at,
    oramalocal.message_statuses.deleted_at,
    oramalocal.message_statuses.signature,
    oramalocal.message_statuses.data
  FROM oramalocal.message_statuses
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO groups (
  id,
  status,
  created_at,
  updated_at,
  deleted_at,
  name,
  description
)
  SELECT
    oramalocal.groups.id,
    1,
    oramalocal.groups.created_at,
    oramalocal.groups.updated_at,
    oramalocal.groups.deleted_at,
    oramalocal.groups.name,
    CONCAT_WS(';', oramalocal.groups.name, oramalocal.groups.permissions)
  FROM oramalocal.groups
  WHERE oramalocal.groups.id > 2
;-- -. . -..- - / . -. - .-. -.--
REPLACE INTO users (
  id,
  person_id,
  status,
  created_at,
  updated_at,
  deleted_at,
  email,
  password,
  email_token,
  login_token
)
  SELECT
    oramalocal.users.id,
    oramalocal.users.people,
    oramalocal.users.activated + 1,
    oramalocal.users.created_at,
    oramalocal.users.updated_at,
    oramalocal.users.deleted_at,
    oramalocal.users.email,
    oramalocal.users.password,
    oramalocal.users.activation_code,
    oramalocal.users.persist_code
  FROM oramalocal.users
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET SQL_MODE = @OLD_SQL_MODE */
;-- -. . -..- - / . -. - .-. -.--
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */
;-- -. . -..- - / . -. - .-. -.--
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */
;-- -. . -..- - / . -. - .-. -.--
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */
;-- -. . -..- - / . -. - .-. -.--
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */
;-- -. . -..- - / . -. - .-. -.--
/*!40112 SET lc_time_names = @OLD_lc_time_names */
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `groups`
WHERE (SELECT count(*)
       FROM `users`
         INNER JOIN `user_group` ON `users`.`id` = `user_group`.`user_id`
       WHERE `user_group`.`group_id` = `groups`.`id` AND `users`.`deleted_at` IS NULL) = 1 AND
      `groups`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM people
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM business
;-- -. . -..- - / . -. - .-. -.--
SELECT id, CONCAT_WS(' ', first_name, second_name,',',names) AS full_name, 'person' AS type
FROM people
UNION
SELECT id, name as full_name,'business' as type
FROM business
;-- -. . -..- - / . -. - .-. -.--
SELECT id, CONCAT(first_name, ' ', second_name,', ',names) AS full_name, 'person' AS type
FROM people
UNION
SELECT id, name as full_name,'business' as type
FROM business
;-- -. . -..- - / . -. - .-. -.--
SELECT id, CONCAT(first_name, ' ', second_name,', ',names) AS full_name, 'person' AS type, CONCAT_WS('-', type, id)
FROM people
UNION
SELECT id, name as full_name,'business' as type, CONCAT_WS('-', type, id)
FROM business
;-- -. . -..- - / . -. - .-. -.--
SELECT id, CONCAT(first_name, ' ', second_name,', ',names) AS full_name, 'person' AS type, CONCAT_WS('-', 'person' , id) AS unique_id
FROM people
UNION
SELECT id, name as full_name,'business' as type, CONCAT_WS('-', 'business', id) AS unique_id
FROM business
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  created_at,
  updated_at,
  deleted_at,
  CONCAT(first_name, ' ', second_name, ', ', names) AS full_name,
  'person'                                          AS type,
  CONCAT_WS('-', 'person', id)                      AS unique_id
FROM people
UNION
SELECT
  id,
  created_at,
  updated_at,
  deleted_at,
  name                           AS full_name,
  'business'                     AS type,
  CONCAT_WS('-', 'business', id) AS unique_id
FROM business
;-- -. . -..- - / . -. - .-. -.--
CREATE VIEW clients AS
  SELECT
    id,
    created_at,
    updated_at,
    deleted_at,
    CONCAT(first_name, ' ', second_name, ', ', names) AS full_name,
    'person'                                          AS type,
    CONCAT_WS('-', 'person', id)                      AS unique_id
  FROM people
  UNION
  SELECT
    id,
    created_at,
    updated_at,
    deleted_at,
    name                           AS full_name,
    'business'                     AS type,
    CONCAT_WS('-', 'business', id) AS unique_id
  FROM business
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `subsidiaries_staff`
WHERE (SELECT count(*)
       FROM `subsidiaries`
       WHERE `subsidiaries_staff`.`subsidiary_id` = `subsidiaries`.`id` AND
             `subsidiaries`.`deleted_at` IS NULL) = 2 AND `subsidiaries_staff`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `subsidiaries_staff`
WHERE exists(SELECT *
             FROM `subsidiaries`
             WHERE `subsidiaries_staff`.`subsidiary_id` = `subsidiaries`.`id` AND `id` = 2 AND
                   `subsidiaries`.`deleted_at` IS NULL) AND
      `subsidiaries_staff`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `subsidiaries_desks`
WHERE exists(SELECT *
             FROM `subsidiaries`
             WHERE `subsidiaries_desks`.`subsidiary_id` = `subsidiaries`.`id` AND `id` = 1 AND
                   `subsidiaries`.`deleted_at` IS NULL)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  `permissions`.*,
  `group_permission`.`group_id`      AS `pivot_group_id`,
  `group_permission`.`permission_id` AS `pivot_permission_id`
FROM `permissions`
  INNER JOIN `group_permission` ON `permissions`.`id` = `group_permission`.`permission_id`
WHERE `group_permission`.`group_id` IN ('1', '2', '3', '4', '5', '6', '7', '8') AND
      `permissions`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM cashiers
WHERE authorized RLIKE '(4)'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM cashiers
WHERE authorized RLIKE '\D(2)\D'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM cashiers
WHERE authorized RLIKE '(2)'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM cashiers
WHERE authorized RLIKE '\D(2)'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM cashiers
WHERE authorized RLIKE '\\D(2)\\D'
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO routes SELECT * FROM destinations
;-- -. . -..- - / . -. - .-. -.--
INSERT INTO routes (
  id,
  parent_id,
  pickup,
  shipping,
  delivery,
  created_at,
  updated_at,
  deleted_at,
  name,
  origin,
  destination,
  description
) SELECT
    id,
    parent_id,
    pickup,
    shipping,
    delivery,
    created_at,
    updated_at,
    deleted_at,
    name,
    municipality,
    type,
    description
  FROM destinations
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `shipment_extras`
WHERE `shipment_extras`.`shipment_id` IN (5) AND `shipment_extras`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `shipments_extras`
WHERE `shipments_extras`.`shipment_id` IN (5) AND `shipment_extras`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `shipments_extras`
WHERE `shipments_extras`.`shipment_id` IN (5) AND `shipments_extras`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `subsidiaries_staff`
WHERE `subsidiaries_staff`.`id` IN ('4') AND `subsidiaries_staff`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `packages`
WHERE `packages`.`shipment_id` IN ('5') AND `packages`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT
  shipment_id,
  container_id,
  count(id)       AS items,
  avg(price)      AS price,
  min(created_at) AS created_at,
  max(updated_at) AS updated_at,
  max(deleted_at) AS deleted_at,
  content,
  content_sound
FROM `packages`
WHERE `packages`.`shipment_id` IN ('5') AND `packages`.`deleted_at` IS NULL
GROUP BY shipment_id, container_id, content_sound
;-- -. . -..- - / . -. - .-. -.--
CREATE OR REPLACE VIEW matelangular.shipments_packages AS
  SELECT
    md5(concat_ws('-', `matelangular`.`packages`.`shipment_id`,
                  `matelangular`.`packages`.`container_id`)) AS `id`,
    `matelangular`.`packages`.`shipment_id`                  AS `shipment_id`,
    `matelangular`.`packages`.`container_id`                 AS `container_id`,
    count(`matelangular`.`packages`.`item`)                  AS `items`,
    avg(`matelangular`.`packages`.`price`)                   AS `price`,
    sum(`matelangular`.`packages`.`price`)                   AS `total`,
    max(`matelangular`.`packages`.`created_at`)              AS `created_at`,
    max(`matelangular`.`packages`.`updated_at`)              AS `updated_at`,
    max(`matelangular`.`packages`.`deleted_at`)              AS `deleted_at`,
    group_concat(concat_ws(':', `matelangular`.`packages`.`id`, `matelangular`.`packages`.`content`)
                 SEPARATOR ',')                              AS `contents`
  FROM `matelangular`.`packages`
  GROUP BY `matelangular`.`packages`.`shipment_id`, `matelangular`.`packages`.`container_id`
;-- -. . -..- - / . -. - .-. -.--
CREATE OR REPLACE VIEW matelangular.shipments_packages AS
  SELECT
    md5(concat_ws('-', `matelangular`.`packages`.`shipment_id`,
                  `matelangular`.`packages`.`container_id`)) AS `id`,
    `matelangular`.`packages`.`shipment_id`                  AS `shipment_id`,
    `matelangular`.`packages`.`container_id`                 AS `container_id`,
    count(`matelangular`.`packages`.`item`)                  AS `items`,
    avg(`matelangular`.`packages`.`price`)                   AS `price`,
    sum(`matelangular`.`packages`.`price`)                   AS `total`,
    max(`matelangular`.`packages`.`created_at`)              AS `created_at`,
    max(`matelangular`.`packages`.`updated_at`)              AS `updated_at`,
    max(`matelangular`.`packages`.`deleted_at`)              AS `deleted_at`,
    `matelangular`.`packages`.`content`                      AS `contents`
  FROM `matelangular`.`packages`
  GROUP BY `matelangular`.`packages`.`shipment_id`, `matelangular`.`packages`.`container_id`, packages.content_sound
;-- -. . -..- - / . -. - .-. -.--
CREATE OR REPLACE VIEW matelangular.shipments_packages AS
  SELECT
    md5(CONCAT_WS('-',shipment_id, container_id, content_sound)) AS id,
    shipment_id,
    container_id,
    count(item) AS items,
    avg(price) AS price,
    SUM(price) AS total,
    MIN(IFNULL(created_at, now())) AS created_at,
    MAX(IFNULL(updated_at, now())) AS updated_at,
    MAX(deleted_at) AS deleted_at,
    content AS contents
  FROM packages
  GROUP BY shipment_id, container_id, content_sound
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE `shipments_extras` (
`shipment_id` int(10) unsigned NOT NULL COMMENT 'Id del envío',
`extra_id` int(10) unsigned NOT NULL COMMENT 'Id del extra',
`price` decimal(10,2) NOT NULL COMMENT 'Monto del extra',
`created_at` timestamp NULL DEFAULT NULL,
`updated_at` timestamp NULL DEFAULT NULL,
`deleted_at` timestamp NULL DEFAULT NULL,
`id` char(32) AS (md5(CONCAT_WS('-',shipment_id, extra_id))) PERSISTENT,
UNIQUE KEY `shipments_extras_shipment_id_extra_id_unique` (`shipment_id`,`extra_id`),
UNIQUE KEY `id` (`id`),
KEY `shipments_extras_shipment_id_index` (`shipment_id`),
KEY `shipments_extras_extra_id_index` (`extra_id`),
CONSTRAINT `FK_se_extra` FOREIGN KEY (`extra_id`) REFERENCES `extras` (`id`),
CONSTRAINT `FK_se_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Extras de un envío'
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  NULL AS container_id,
  packages.content,
  NULL AS price
FROM packages
UNION
SELECT DISTINCT
  prices.container_id,
  prices.content,
  prices.price
FROM prices
ORDER BY content
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(price)
FROM packages
WHERE shipment_id = 2
;-- -. . -..- - / . -. - .-. -.--
SET @totalPrices =
;-- -. . -..- - / . -. - .-. -.--
SET @totalPrices = (SELECT SUM(price)
FROM packages
WHERE shipment_id = 2)
;-- -. . -..- - / . -. - .-. -.--
SET @totalPrices = (SELECT SUM(price)
                    FROM packages
                    WHERE shipment_id = 2)
;-- -. . -..- - / . -. - .-. -.--
SELECT @totalPrices
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages
  BEGIN ATOMIC
    SET @totalPrices = (SELECT SUM(packages.price)
  FROM packages
  WHERE packages.shipment_id = NEW.shipment_id)
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages
  BEGIN ATOMIC
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    SET @totalPrices = (SELECT SUM(price)
                        FROM packages
                        WHERE packages.shipment_id = NEW.shipment_id
                              AND ISNULL(deleted_at));
    UPDATE shipments
    SET shipments.total = @totalPrice
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT
                                             shipments_payments.shipment_id,
                                             CONCAT('[', GROUP_CONCAT(shipments_payments.payment_id), ']') AS payments,
                                             CONCAT('[', GROUP_CONCAT(shipments_payments.invoice_id), ']') AS invoices,
                                             SUM(shipments_payments.total)                                 AS payed,
                                             shipments.total                                               AS total,
                                             shipments.total - SUM(shipments_payments.total)               AS balancce,
                                             MIN(shipments_payments.created_at)                            AS created_at,
                                             MAX(shipments_payments.updated_at)                            AS updated_at
                                           FROM shipments_payments
                                             INNER JOIN shipments ON shipments.id = shipments_payments.shipment_id
                                                                     AND ISNULL(shipments.deleted_at)
                                           WHERE ISNULL(shipments_payments.deleted_at)
;-- -. . -..- - / . -. - .-. -.--
SELECT
                                             shipments_payments.shipment_id,
                                             CONCAT('[', GROUP_CONCAT(shipments_payments.payment_id), ']') AS payments,
                                             CONCAT('[', GROUP_CONCAT(shipments_payments.invoice_id), ']') AS invoices,
                                             SUM(shipments_payments.total)                                 AS payed,
                                             shipments.total                                               AS total,
                                             shipments.total - SUM(shipments_payments.total)               AS balancce,
                                             MIN(shipments_payments.created_at)                            AS created_at,
                                             MAX(shipments_payments.updated_at)                            AS updated_at
                                           FROM shipments_payments
                                             INNER JOIN shipments ON shipments.id = shipments_payments.shipment_id
                                                                     AND ISNULL(shipments.deleted_at)
                                           WHERE ISNULL(shipments_payments.deleted_at)
GROUP BY shipments.id
;-- -. . -..- - / . -. - .-. -.--
SELECT
                                             shipments_payments.shipment_id,
                                             CONCAT('[', GROUP_CONCAT(shipments_payments.payment_id), ']') AS payments,
                                             CONCAT('[', GROUP_CONCAT(shipments_payments.invoice_id), ']') AS invoices,
                                             SUM(shipments_payments.total)                                 AS payed,
                                             shipments.total                                               AS total,
                                             shipments.total - SUM(shipments_payments.total)               AS balancce,
                                             MIN(shipments_payments.created_at)                            AS created_at,
                                             MAX(shipments_payments.updated_at)                            AS updated_at
                                           FROM shipments_payments
                                             INNER JOIN shipments ON shipments.id = shipments_payments.shipment_id
                                                                     AND ISNULL(shipments.deleted_at)
                                           WHERE ISNULL(shipments_payments.deleted_at)
GROUP BY shipments.id
ORDER BY shipments.id DESC
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    SET @totalPrices = (SELECT SUM(price)
                        FROM packages
                        WHERE packages.shipment_id = NEW.shipment_id);
    UPDATE shipments
    SET shipments.total = @totalPrice
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
BEGIN
;-- -. . -..- - / . -. - .-. -.--
UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id)
    WHERE id = NEW.shipment_id
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = 12
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id)
                          +
                          (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id
                                 AND ISNULL(shipments_extras.deleted_at))
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id
                                 AND ISNULL(packages.deleted_at))
                          +
                          (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id
                                 AND ISNULL(shipments_extras.deleted_at))
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id
                                 AND ISNULL(packages.deleted_at))
                          +
                          (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id
                                 AND ISNULL(packages.deleted_at))
                          +
                          (SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id
                                 AND ISNULL(shipments_extras.deleted_at))
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = IFNULL((SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id),0)
                          +
                          IFNULL((SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id
                                 AND ISNULL(shipments_extras.deleted_at)),0)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = IFNULL((SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id
                                 AND ISNULL(packages.deleted_at)),0)
                          +
                          IFNULL((SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id
                                 AND ISNULL(shipments_extras.deleted_at)),0)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = IFNULL((SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id
                                 AND ISNULL(packages.deleted_at)),0)
                          +
                          IFNULL((SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id),0)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = IFNULL((SELECT SUM(packages.price)
                           FROM packages
                           WHERE packages.shipment_id = NEW.shipment_id
                                 AND ISNULL(packages.deleted_at)),0)
                          +
                          IFNULL((SELECT SUM(shipments_extras.price)
                           FROM shipments_extras
                           WHERE shipments_extras.shipment_id = NEW.shipment_id
                                 AND ISNULL(shipments_extras.deleted_at)),0)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal (s_id INT, delivery int)
  RETURNS float
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN IFNULL((SELECT SUM(packages.price)
FROM packages
WHERE packages.shipment_id = NEW.shipment_id),0)
  +
  IFNULL((SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = NEW.shipment_id
AND ISNULL(shipments_extras.deleted_at)),0)
  +
  IFNULL((SELECT ),0)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS FLOAT
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN IFNULL((SELECT SUM(packages.price)
                 FROM packages
                 WHERE packages.shipment_id = s_id), 0)
         +
         IFNULL((SELECT SUM(shipments_extras.price)
                 FROM shipments_extras
                 WHERE shipments_extras.shipment_id = s_id
                       AND ISNULL(shipments_extras.deleted_at)), 0)
         +
         IF(delivery, IFNULL((SELECT delivery
                              FROM destinations
                              WHERE destinations.id = d_id), 0), 0)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = s_id
      AND ISNULL(shipments_extras.deleted_at)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(packages.price)
FROM packages
WHERE packages.shipment_id = 14
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
;-- -. . -..- - / . -. - .-. -.--
SELECT delivery
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS FLOAT(10,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN IFNULL((SELECT SUM(packages.price)
                 FROM packages
                 WHERE packages.shipment_id = s_id), 0)
         +
         IFNULL((SELECT SUM(shipments_extras.price)
                 FROM shipments_extras
                 WHERE shipments_extras.shipment_id = s_id
                       AND ISNULL(shipments_extras.deleted_at)), 0)
         +
         IF(delivery, IFNULL((SELECT delivery
                              FROM destinations
                              WHERE destinations.id = d_id), 0), 0)
;-- -. . -..- - / . -. - .-. -.--
SELECT shippingSubTotal(14,2,16)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(packages.price)
FROM packages
WHERE packages.shipment_id = 14
UNION 
SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
union
SELECT delivery
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(packages.price)
FROM packages
WHERE packages.shipment_id = 14
UNION 
SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
union
SELECT delivery
FROM destinations
WHERE destinations.id = 2
UNION 
SELECT shippingSubTotal(14,2,16)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS FLOAT(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN IFNULL((SELECT SUM(packages.price)
                 FROM packages
                 WHERE packages.shipment_id = s_id), 0)
         +
         IFNULL((SELECT SUM(shipments_extras.price)
                 FROM shipments_extras
                 WHERE shipments_extras.shipment_id = s_id
                       AND ISNULL(shipments_extras.deleted_at)), 0)
         +
         IF(delivery, IFNULL((SELECT delivery
                              FROM destinations
                              WHERE destinations.id = d_id), 0), 0)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN IFNULL((SELECT SUM(packages.price)
                 FROM packages
                 WHERE packages.shipment_id = s_id), 0)
         +
         IFNULL((SELECT SUM(shipments_extras.price)
                 FROM shipments_extras
                 WHERE shipments_extras.shipment_id = s_id
                       AND ISNULL(shipments_extras.deleted_at)), 0)
         +
         IF(delivery, IFNULL((SELECT delivery
                              FROM destinations
                              WHERE destinations.id = d_id), 0), 0)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(packages.price)
FROM packages
WHERE packages.shipment_id = 14
group by id
;-- -. . -..- - / . -. - .-. -.--
SELECT (packages.price)
FROM packages
WHERE packages.shipment_id = 14
group by id
;-- -. . -..- - / . -. - .-. -.--
SELECT id,SUM(packages.price)
FROM packages
WHERE packages.shipment_id = 14
group by id
;-- -. . -..- - / . -. - .-. -.--
SELECT ROUND(NULL ,2)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN IFNULL((SELECT ROUND(SUM(packages.price),2)
                 FROM packages
                 WHERE packages.shipment_id = s_id), 0)
         +
         IFNULL((SELECT ROUND(SUM(shipments_extras.price),2)
                 FROM shipments_extras
                 WHERE shipments_extras.shipment_id = s_id
                       AND ISNULL(shipments_extras.deleted_at)), 0)
         +
         IF(delivery, IFNULL((SELECT ROUND(delivery, 2)
                              FROM destinations
                              WHERE destinations.id = d_id), 0), 0)
;-- -. . -..- - / . -. - .-. -.--
SELECT SUM(packages.price)
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT SUM(shipments_extras.price)
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
union
SELECT delivery
FROM destinations
WHERE destinations.id = 2
UNION
SELECT shippingSubTotal(14,2,16)
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(amount)
FROM (SELECT packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
union
SELECT delivery AS amount
FROM destinations
WHERE destinations.id = 2) AS sectiosAmount
;-- -. . -..- - / . -. - .-. -.--
SELECT packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
union
SELECT delivery AS amount
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN (SELECT sum(amount)
         FROM (SELECT id, packages.price AS amount
               FROM packages
               WHERE packages.shipment_id = 14
               UNION
               SELECT id, shipments_extras.price AS amount
               FROM shipments_extras
               WHERE shipments_extras.shipment_id = 14
                     AND ISNULL(shipments_extras.deleted_at)
               union
               SELECT id, delivery AS amount
               FROM destinations
               WHERE destinations.id = 2) AS sectiosAmount
LIMIT 1)
;-- -. . -..- - / . -. - .-. -.--
SELECT shippingSubTotal(14, 2, 8 & 16)
;-- -. . -..- - / . -. - .-. -.--
SELECT shippingSubTotal(14, 2, 16 & 16)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN (SELECT sum(amount)
         FROM (SELECT id, packages.price AS amount
               FROM packages
               WHERE packages.shipment_id = 14
               UNION
               SELECT id, shipments_extras.price AS amount
               FROM shipments_extras
               WHERE shipments_extras.shipment_id = 14
                     AND ISNULL(shipments_extras.deleted_at)
               ) AS sectiosAmount
LIMIT 1)
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(amount)
FROM (SELECT id, packages.price AS amount
      FROM packages
      WHERE packages.shipment_id = 14
      UNION
      SELECT id, shipments_extras.price AS amount
      FROM shipments_extras
      WHERE shipments_extras.shipment_id = 14
            AND ISNULL(shipments_extras.deleted_at)
      ) AS sectiosAmount
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN (SELECT sum(amount)
         FROM (SELECT id, packages.price AS amount
               FROM packages
               WHERE packages.shipment_id = 14
               UNION
               SELECT id, shipments_extras.price AS amount
               FROM shipments_extras
               WHERE shipments_extras.shipment_id = 14
                     AND ISNULL(shipments_extras.deleted_at)
               UNION
               SELECT id, delivery AS amount
               FROM destinations
               WHERE destinations.id = 2) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN (SELECT sum(amount)
         FROM (SELECT id, packages.price AS amount
               FROM packages
               WHERE packages.shipment_id = 14
               UNION
               SELECT id, shipments_extras.price AS amount
               FROM shipments_extras
               WHERE shipments_extras.shipment_id = 14
                     AND ISNULL(shipments_extras.deleted_at)
               UNION
               SELECT id, ROUND(delivery,2) AS amount
               FROM destinations
               WHERE destinations.id = 2) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8,2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN (SELECT sum(amount)
         FROM (SELECT id, packages.price AS amount
               FROM packages
               WHERE packages.shipment_id = 14
               UNION
               SELECT id, shipments_extras.price AS amount
               FROM shipments_extras
               WHERE shipments_extras.shipment_id = 14
                     AND ISNULL(shipments_extras.deleted_at)
               UNION
               SELECT id, ROUND(delivery,5) AS amount
               FROM destinations
               WHERE destinations.id = 2) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
SELECT shippingSubTotal(14, 2, 24 & 16)
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER shippingPackagesTriggerInsert
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER shippingPackagesTriggerUpdate
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER shippingExtrasInsertTrigger
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER shippingExtrasUpdateTrigger
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(amount)
FROM (SELECT id, packages.price AS amount
      FROM packages
      WHERE packages.shipment_id = 14
      UNION
      SELECT id, shipments_extras.price AS amount
      FROM shipments_extras
      WHERE shipments_extras.shipment_id = 14
            AND ISNULL(shipments_extras.deleted_at)
      union
      SELECT id, delivery AS amount
      FROM destinations
      WHERE destinations.id = 2) AS sectiosAmount
;-- -. . -..- - / . -. - .-. -.--
SELECT id, packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT id, shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
union
SELECT id, delivery AS amount
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
SELECT shippingSubTotal(14, 2, 24 & 16), null
;-- -. . -..- - / . -. - .-. -.--
DROP FUNCTION shippingSubTotal
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8, 2)
  COMMENT 'Obtiene el subtotal del envio calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id = 14
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = 14
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery, 5) AS amount
                FROM destinations
                WHERE destinations.id = 2) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = 14
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = 14
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = 2) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = 14
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = 14
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = 2) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = 14
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = 14
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = 2) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = 14
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = 14
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = 2) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = NEW.shipment_id
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = NEW.shipment_id
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = shipments.destination_id) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT sum(amount)
FROM (SELECT
        id,
        packages.price AS amount
      FROM packages
      WHERE packages.shipment_id = 14
      UNION
      SELECT
        id,
        shipments_extras.price AS amount
      FROM shipments_extras
      WHERE shipments_extras.shipment_id = 14
            AND ISNULL(shipments_extras.deleted_at)
      UNION
      SELECT
        id,
        delivery AS amount
      FROM destinations
      WHERE destinations.id = 2) AS sectiosAmount
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT
  id,
  shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
UNION
SELECT
  id,
  delivery AS amount
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8, 2)
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id =s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery, 5) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = shippingSubTotal(NEW.shipment_id, shipments.destination_id, shipments.ocurre & 16)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = NEW.shipment_id
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = NEW.shipment_id
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = shipments.destination_id) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = NEW.shipment_id
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = NEW.shipment_id
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = shipments.destination_id) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = (SELECT sum(amount)
                           FROM (SELECT
                                   id,
                                   packages.price AS amount
                                 FROM packages
                                 WHERE packages.shipment_id = NEW.shipment_id
                                 UNION
                                 SELECT
                                   id,
                                   shipments_extras.price AS amount
                                 FROM shipments_extras
                                 WHERE shipments_extras.shipment_id = NEW.shipment_id
                                       AND ISNULL(shipments_extras.deleted_at)
                                 UNION
                                 SELECT
                                   id,
                                   delivery AS amount
                                 FROM destinations
                                 WHERE destinations.id = shipments.destination_id) AS sectiosAmount)
    WHERE id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id =s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery, 5) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS VARCHAR()
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id =s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery, 5) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS VARCHAR(32)
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id =s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery, 5) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8, 2)
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id =s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery-1, 5) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.updated_at = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.updated_at = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.updated_at = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.updated_at = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, delivery INT)
  RETURNS DECIMAL(8, 2)
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id = s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  ROUND(delivery - 1, 5) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT
  id,
  shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
UNION
SELECT
  id,
  ROUND(delivery - 1, 5) AS amount
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT
  id,
  shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
UNION
SELECT
  id,
  IF(TRUE , destinations.delivery,0) AS amount
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
SHOW PROCEDURE STATUS
;-- -. . -..- - / . -. - .-. -.--
DROP FUNCTION IF EXISTS shippingSubTotal
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER IF EXISTS shippingPackagesTriggerInsert
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER IF EXISTS shippingPackagesTriggerUpdate
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER IF EXISTS shippingExtrasInsertTrigger
;-- -. . -..- - / . -. - .-. -.--
DROP TRIGGER IF EXISTS shippingExtrasUpdateTrigger
;-- -. . -..- - / . -. - .-. -.--
SELECT
  id,
  packages.price AS amount
FROM packages
WHERE packages.shipment_id = 14
UNION
SELECT
  id,
  shipments_extras.price AS amount
FROM shipments_extras
WHERE shipments_extras.shipment_id = 14
      AND ISNULL(shipments_extras.deleted_at)
UNION
SELECT
  id,
  IF(false , destinations.delivery,0) AS amount
FROM destinations
WHERE destinations.id = 2
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION shippingSubTotal(s_id INT, d_id INT, use_delivery INT)
  RETURNS DECIMAL(8, 2)
  COMMENT 'Obtiene el subtotal del envío calculando en base a los registro'
  RETURN (SELECT sum(amount)
          FROM (SELECT
                  id,
                  packages.price AS amount
                FROM packages
                WHERE packages.shipment_id = s_id
                UNION
                SELECT
                  id,
                  shipments_extras.price AS amount
                FROM shipments_extras
                WHERE shipments_extras.shipment_id = s_id
                      AND ISNULL(shipments_extras.deleted_at)
                UNION
                SELECT
                  id,
                  IF(use_delivery, destinations.delivery,0) AS amount
                FROM destinations
                WHERE destinations.id = d_id) AS sectiosAmount)
;-- -. . -..- - / . -. - .-. -.--
SELECT
  shippingSubTotal(14, 2, 24 & 16),
  NULL
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerInsert
AFTER INSERT
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.sub_total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingPackagesTriggerUpdate
AFTER UPDATE
ON packages FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.sub_total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasInsertTrigger
AFTER INSERT
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.sub_total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TRIGGER shippingExtrasUpdateTrigger
AFTER UPDATE
ON shipments_extras FOR EACH ROW
  BEGIN
    UPDATE shipments
    SET shipments.sub_total = shippingSubTotal(NEW.shipment_id, shipments.destination_id,
                                                shipments.ocurre & 16)
    WHERE shipments.id = NEW.shipment_id;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE clientesImport (
  IdCliente VARCHAR(255) DEFAULT NULL,
  Nombre_Empresa VARCHAR(255) DEFAULT NULL,
  Calle VARCHAR(255) DEFAULT NULL,
  Colonia VARCHAR(255) DEFAULT NULL,
  CP VARCHAR(5) DEFAULT NULL,
  IdCiudad VARCHAR(255) DEFAULT NULL,
  Ciudad VARCHAR(255) DEFAULT NULL,
  Telefono VARCHAR(255) DEFAULT NULL,
  EntreCalle1 VARCHAR(255) DEFAULT NULL,
  EntreCalle2 VARCHAR(255) DEFAULT NULL,
  Observaciones VARCHAR(255) DEFAULT NULL,
  RFC VARCHAR(15) DEFAULT NULL,
  FechaAlta VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (IdCliente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='La actividad de los vehículos'
;-- -. . -..- - / . -. - .-. -.--
LOAD DATA INFILE 'D:/Personal/GDrive/AltosPack/Migración/Clientes_20160720_IMP.csv'
    INTO TABLE clientesImport
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;-- -. . -..- - / . -. - .-. -.--
LOAD DATA INFILE 'D:\\Personal\\GDrive\\AltosPack\\Migración\\Clientes_20160720_IMP.csv'
    INTO TABLE clientesImport
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;-- -. . -..- - / . -. - .-. -.--
LOAD DATA INFILE 'D:\\Personal\\GDrive\\AltosPack\\Migración\\Clientes_20160720_IMP.csv'
INTO TABLE clientesImport
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;-- -. . -..- - / . -. - .-. -.--
LOAD DATA INFILE 'D:\Personal\GDrive\AltosPack\Migración\Clientes_20160720_IMP.csv'
INTO TABLE clientesImport
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE clientesImport (
  IdCliente      VARCHAR(255) DEFAULT NULL,
  Nombre_Empresa VARCHAR(255) DEFAULT NULL,
  Calle          VARCHAR(255) DEFAULT NULL,
  Colonia        VARCHAR(255) DEFAULT NULL,
  CP             VARCHAR(5)   DEFAULT NULL,
  IdCiudad       VARCHAR(255) DEFAULT NULL,
  Ciudad         VARCHAR(255) DEFAULT NULL,
  Telefono       VARCHAR(255) DEFAULT NULL,
  EntreCalle1    VARCHAR(255) DEFAULT NULL,
  EntreCalle2    VARCHAR(255) DEFAULT NULL,
  Observaciones  VARCHAR(255) DEFAULT NULL,
  RFC            VARCHAR(15)  DEFAULT NULL,
  FechaAlta      VARCHAR(10)  DEFAULT NULL,
  PRIMARY KEY (IdCliente)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  COMMENT = 'La actividad de los vehículos'
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE clientesImport (
  IdCliente      VARCHAR(255) DEFAULT NULL,
  Nombre_Empresa VARCHAR(255) DEFAULT NULL,
  Calle          VARCHAR(255) DEFAULT NULL,
  Colonia        VARCHAR(255) DEFAULT NULL,
  CP             VARCHAR(5)   DEFAULT NULL,
  IdCiudad       VARCHAR(255) DEFAULT NULL,
  Ciudad         VARCHAR(255) DEFAULT NULL,
  Telefono       VARCHAR(255) DEFAULT NULL,
  EntreCalle1    VARCHAR(255) DEFAULT NULL,
  EntreCalle2    VARCHAR(255) DEFAULT NULL,
  Observaciones  VARCHAR(255) DEFAULT NULL,
  RFC            VARCHAR(15)  DEFAULT NULL,
  FechaAlta      VARCHAR(10)  DEFAULT NULL,
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  COMMENT = 'La actividad de los vehículos'
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE clientesImport (
  IdCliente      VARCHAR(255) DEFAULT NULL,
  Nombre_Empresa VARCHAR(255) DEFAULT NULL,
  Calle          VARCHAR(255) DEFAULT NULL,
  Colonia        VARCHAR(255) DEFAULT NULL,
  CP             VARCHAR(5)   DEFAULT NULL,
  IdCiudad       VARCHAR(255) DEFAULT NULL,
  Ciudad         VARCHAR(255) DEFAULT NULL,
  Telefono       VARCHAR(255) DEFAULT NULL,
  EntreCalle1    VARCHAR(255) DEFAULT NULL,
  EntreCalle2    VARCHAR(255) DEFAULT NULL,
  Observaciones  VARCHAR(255) DEFAULT NULL,
  RFC            VARCHAR(15)  DEFAULT NULL,
  FechaAlta      VARCHAR(10)  DEFAULT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  COMMENT = 'La actividad de los vehículos'
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE IF EXISTS clientesImport
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE clientesImport (
  IdCliente      INTEGER(10) DEFAULT NULL,
  Nombre_Empresa VARCHAR(255) DEFAULT NULL,
  Calle          VARCHAR(255) DEFAULT NULL,
  Colonia        VARCHAR(255) DEFAULT NULL,
  CP             VARCHAR(5)   DEFAULT NULL,
  IdCiudad       VARCHAR(255) DEFAULT NULL,
  Ciudad         VARCHAR(255) DEFAULT NULL,
  Telefono       VARCHAR(255) DEFAULT NULL,
  EntreCalle1    VARCHAR(255) DEFAULT NULL,
  EntreCalle2    VARCHAR(255) DEFAULT NULL,
  Observaciones  VARCHAR(255) DEFAULT NULL,
  RFC            VARCHAR(15)  DEFAULT NULL,
  FechaAlta      VARCHAR(10)  DEFAULT NULL
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci
  COMMENT = 'La actividad de los vehículos'
;-- -. . -..- - / . -. - .-. -.--
LOAD DATA INFILE 'clientesimport.csv'
INTO TABLE clientesImport
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `destinations`
WHERE `country` LIKE 'MX' AND `filtered` LIKE true AND `municipality` LIKE 'Guadalajara' AND `orderBy` LIKE 'type' AND
      `page` LIKE 1 AND `state` LIKE 'JAL' AND `destinations`.`deleted_at` IS NULL
ORDER BY `type` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `destinations`
WHERE (`country` LIKE 'MX' OR `municipality` LIKE 'Guadalajara' OR `state` LIKE 'Guadalajara') AND
      `destinations`.`deleted_at` IS NULL
ORDER BY `type` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `destinations`
WHERE (`country` LIKE 'MX' OR `municipality` LIKE 'Tlaquepaque' OR `state` LIKE 'Tlaquepaque') AND
      `destinations`.`deleted_at` IS NULL
ORDER BY `type` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `destinations`
WHERE (`country` LIKE 'MX' OR `municipality` LIKE 'Ocotlán' OR `state` LIKE 'JAL') AND
      `destinations`.`deleted_at` IS NULL
ORDER BY `type` ASC
;-- -. . -..- - / . -. - .-. -.--
SELECT soundex(full_name) AS sound, count(id) AS counting, GROUP_CONCAT(id) AS ids
FROM clients
GROUP BY soundex(full_name)
HAVING counting >1
;-- -. . -..- - / . -. - .-. -.--
SELECT full_name, soundex(full_name) AS sound, count(id) AS counting, GROUP_CONCAT(id) AS ids
FROM clients
GROUP BY soundex(full_name)
HAVING counting >1
;-- -. . -..- - / . -. - .-. -.--
SELECT registry_type, full_name, soundex(full_name) AS sound, count(id) AS counting, GROUP_CONCAT(id) AS ids
FROM clients
GROUP BY soundex(full_name)
HAVING counting >1
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM `activities` WHERE `activities`.`deleted_at` IS NULL ORDER BY `scheduled_at` DESC, `id` ASC LIMIT 25 offset 0
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `activities`
WHERE `activities`.`deleted_at` IS NULL
ORDER BY `scheduled_at` ASC, `id` ASC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `activities`
WHERE `activities`.`deleted_at` IS NULL
ORDER BY `scheduled_at` DESC, `id` ASC
LIMIT 25 OFFSET 0
;-- -. . -..- - / . -. - .-. -.--
select * from information_schema.columns
where table_schema = 'matelangular'
order by table_name,ordinal_position
;-- -. . -..- - / . -. - .-. -.--
select * from information_schema.columns
where table_schema = 'matelangular' AND column_name='person_id'
order by table_name,ordinal_position
;-- -. . -..- - / . -. - .-. -.--
select * from information_schema.columns
where table_schema = 'matelangular' AND column_name LIKE 'user'
order by table_name,ordinal_position
;-- -. . -..- - / . -. - .-. -.--
select * from information_schema.columns
where table_schema = 'matelangular' AND column_name LIKE 'user%'
order by table_name,ordinal_position
;-- -. . -..- - / . -. - .-. -.--
select * from information_schema.columns
where table_schema = 'matelangular' AND column_name LIKE 'person%'
order by table_name,ordinal_position
;-- -. . -..- - / . -. - .-. -.--
SELECT
  TABLE_NAME,
  COLUMN_NAME,
  CONSTRAINT_NAME,
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'matelangular'
AND REFERENCED_COLUMN_NAME LIKE 'person%'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  TABLE_NAME,
  COLUMN_NAME,
  CONSTRAINT_NAME,
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'matelangular'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  TABLE_NAME,
  COLUMN_NAME,
  CONSTRAINT_NAME,
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'matelangular'
ORDER BY REFERENCED_TABLE_NAME
;-- -. . -..- - / . -. - .-. -.--
SELECT
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME,
  COUNT(full_name)        AS columns_count,
  GROUP_CONCAT(full_name) AS target
FROM (
       SELECT
         TABLE_NAME,
         COLUMN_NAME,
         concat_ws('.', TABLE_NAME,
                   COLUMN_NAME) AS full_name,
         CONSTRAINT_NAME,
         REFERENCED_TABLE_NAME,
         REFERENCED_COLUMN_NAME
       FROM
         INFORMATION_SCHEMA.KEY_COLUMN_USAGE
       WHERE
         REFERENCED_TABLE_SCHEMA = 'matelangular') AS tmp1
HAVING columns_count > 3
ORDER BY REFERENCED_TABLE_NAME
;-- -. . -..- - / . -. - .-. -.--
SELECT
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME,
  COUNT(full_name)        AS columns_count,
  GROUP_CONCAT(full_name) AS target
FROM (
       SELECT
         TABLE_NAME,
         COLUMN_NAME,
         concat_ws('.', TABLE_NAME,
                   COLUMN_NAME) AS full_name,
         CONSTRAINT_NAME,
         REFERENCED_TABLE_NAME,
         REFERENCED_COLUMN_NAME
       FROM
         INFORMATION_SCHEMA.KEY_COLUMN_USAGE
       WHERE
         REFERENCED_TABLE_SCHEMA = 'matelangular') AS tmp1
GROUP BY REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
HAVING columns_count > 3
ORDER BY REFERENCED_TABLE_NAME
;-- -. . -..- - / . -. - .-. -.--
SELECT
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME,
  COUNT(full_name)        AS columns_count,
  GROUP_CONCAT(full_name) AS target
FROM (
       SELECT
         TABLE_NAME,
         COLUMN_NAME,
         concat_ws('.', TABLE_NAME,
                   COLUMN_NAME) AS full_name,
         CONSTRAINT_NAME,
         REFERENCED_COLUMN_NAME = COLUMN_NAME AS sameName,
         REFERENCED_TABLE_NAME,
         REFERENCED_COLUMN_NAME
       FROM
         INFORMATION_SCHEMA.KEY_COLUMN_USAGE
       WHERE
         REFERENCED_TABLE_SCHEMA = 'matelangular') AS tmp1
  WHERE sameName
GROUP BY REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
HAVING columns_count > 1
ORDER BY REFERENCED_TABLE_NAME
;-- -. . -..- - / . -. - .-. -.--
SELECT
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME,
  COUNT(full_name)        AS columns_count,
  GROUP_CONCAT(full_name) AS target
FROM (
       SELECT
         TABLE_NAME,
         COLUMN_NAME,
         concat_ws('.', TABLE_NAME,
                   COLUMN_NAME) AS full_name,
         CONSTRAINT_NAME,
         REFERENCED_COLUMN_NAME = COLUMN_NAME AS sameName,
         REFERENCED_TABLE_NAME,
         REFERENCED_COLUMN_NAME
       FROM
         INFORMATION_SCHEMA.KEY_COLUMN_USAGE
       WHERE
         REFERENCED_TABLE_SCHEMA = 'matelangular') AS tmp1
  WHERE sameName=1
GROUP BY REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
HAVING columns_count > 1
ORDER BY REFERENCED_TABLE_NAME
;-- -. . -..- - / . -. - .-. -.--
SELECT
  TABLE_NAME,
  COLUMN_NAME,
  concat_ws('.', TABLE_NAME,
            COLUMN_NAME) AS full_name,
  CONSTRAINT_NAME,
  REFERENCED_COLUMN_NAME = COLUMN_NAME AS sameName,
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_SCHEMA = 'matelangular'
;-- -. . -..- - / . -. - .-. -.--
SELECT
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME,
  COUNT(full_name)        AS columns_count,
  GROUP_CONCAT(full_name) AS target
FROM (
       SELECT
         TABLE_NAME,
         COLUMN_NAME,
         concat_ws('.', TABLE_NAME,
                   COLUMN_NAME) AS full_name,
         CONSTRAINT_NAME,
         REFERENCED_COLUMN_NAME = COLUMN_NAME AS sameName,
         REFERENCED_TABLE_NAME,
         REFERENCED_COLUMN_NAME
       FROM
         INFORMATION_SCHEMA.KEY_COLUMN_USAGE
       WHERE
         REFERENCED_TABLE_SCHEMA = 'matelangular') AS tmp1
GROUP BY REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
HAVING columns_count > 1
ORDER BY REFERENCED_TABLE_NAME
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM `customers_tax`
WHERE `status` = 2 AND `customers_tax`.`deleted_at` IS NULL
;-- -. . -..- - / . -. - .-. -.--
SELECT 0 BETWEEN 0 AND 5
;-- -. . -..- - / . -. - .-. -.--
SELECT 3 BETWEEN 0 AND 5
;-- -. . -..- - / . -. - .-. -.--
SELECT 3 BETWEEN 1 AND 5
;-- -. . -..- - / . -. - .-. -.--
SELECT 5 BETWEEN 1 AND 5
;-- -. . -..- - / . -. - .-. -.--
SELECT 5 BETWEEN 1 AND 4
;-- -. . -..- - / . -. - .-. -.--
SHOW TRIGGERS
;-- -. . -..- - / . -. - .-. -.--
SHOW FUNCTION STATUS
;-- -. . -..- - / . -. - .-. -.--
SHOW FUNCTION
;-- -. . -..- - / . -. - .-. -.--
SELECT name, definition, type_desc
FROM sys.sql_modules m
  INNER JOIN sys.objects o
    ON m.object_id=o.object_id
WHERE type_desc like '%function%'
;-- -. . -..- - / . -. - .-. -.--
select
  OBJECT_DEFINITION(OBJECT_ID(routine_name)) AS [Object Definition]
from
functions
;-- -. . -..- - / . -. - .-. -.--
select definition
from sys.sql_modules
;-- -. . -..- - / . -. - .-. -.--
select p.[type]
  ,p.[name]
  ,c.[definition]
from sys.objects p
  join sys.sql_modules c
    on p.object_id = c.object_id
where p.[type] = 'P'
                 --and c.[definition] like '%foo%'
ORDER BY p.[name]
;-- -. . -..- - / . -. - .-. -.--
SELECT OBJECT_NAME(object_id) ProcedureName,
  definition
FROM sys.sql_modules
WHERE objectproperty(object_id,'IsProcedure') = 1
ORDER BY OBJECT_NAME(object_id)
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM sys.procedures
;-- -. . -..- - / . -. - .-. -.--
CREATE PROCEDURE matelangular.simpleproc(OUT param1 INT)
  BEGIN
    SELECT COUNT(*)
    INTO param1
    FROM users;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT matelangular.simpleproc(tmp)
;-- -. . -..- - / . -. - .-. -.--
SELECT COUNT(*)
FROM users
;-- -. . -..- - / . -. - .-. -.--
SELECT matelangular.simpleproc()
;-- -. . -..- - / . -. - .-. -.--
SELECT matelangular.simpleproc() FROM users
;-- -. . -..- - / . -. - .-. -.--
CREATE PROCEDURE simpleproc(OUT param1 INT)
  BEGIN
    SELECT COUNT(*)
    INTO param1
    FROM users;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT simpleproc() FROM users
;-- -. . -..- - / . -. - .-. -.--
CALL simpleproc()
;-- -. . -..- - / . -. - .-. -.--
CALL simpleproc(@a)
;-- -. . -..- - / . -. - .-. -.--
SELECT @a
;-- -. . -..- - / . -. - .-. -.--
CREATE PROCEDURE simpleproc()
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM users;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
DROP PROCEDURE simpleproc
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION simpleproc()
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM users;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION simpleproc()
  RETURNS DECIMAL(10,2) DETERMINISTIC
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM users;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION simpleproc()
  RETURNS INTEGER(10) DETERMINISTIC
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM users;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT simpleproc()
;-- -. . -..- - / . -. - .-. -.--
DROP FUNCTION simpleproc
;-- -. . -..- - / . -. - .-. -.--
DROP FUNCTION ClientsCount
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION ClientsCount()
  RETURNS INTEGER(10) DETERMINISTIC
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM clients;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION StudentsCount()
  RETURNS INTEGER(10) DETERMINISTIC
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM users;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
CREATE FUNCTION UsersCount()
  RETURNS INTEGER(10) DETERMINISTIC
  BEGIN
    SELECT COUNT(*)
    INTO @r
    FROM users;
    RETURN @r;
  END
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM shipments
WHERE created_at BETWEEN '2016-01-01'AND '2017-01-01'
;-- -. . -..- - / . -. - .-. -.--
USE matelangular
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.vehicles_logs DROP FOREIGN KEY FK_vehicle_log
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_panel_permissions DROP FOREIGN KEY user_panel_permissions_panel_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_panel_permissions DROP FOREIGN KEY user_panel_permissions_permission_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_panel_permissions DROP FOREIGN KEY user_panel_permissions_user_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_panel DROP FOREIGN KEY user_panel_panel_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_panel DROP FOREIGN KEY user_panel_user_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_group DROP FOREIGN KEY user_group_group_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.user_group DROP FOREIGN KEY user_group_user_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.subsidiaries_desks DROP FOREIGN KEY FK_subsidiary_cashier
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.subsidiaries_desks DROP FOREIGN KEY FK_subsidiary_desk
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments_status DROP FOREIGN KEY FK_shipment_status
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments_payments DROP FOREIGN KEY FK_ps_invoice
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments_payments DROP FOREIGN KEY FK_ps_payment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments_payments DROP FOREIGN KEY FK_ps_shipment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments_extras DROP FOREIGN KEY FK_se_extra
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments_extras DROP FOREIGN KEY FK_se_shipment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.prices DROP FOREIGN KEY FK_price_container
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.packages_status DROP FOREIGN KEY FK_activity_staff
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.packages_status DROP FOREIGN KEY FK_package_activity
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.packages_status DROP FOREIGN KEY FK_package_status
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.packages_status DROP FOREIGN KEY FK_subsidiary_activity
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.invoice_assignments DROP FOREIGN KEY invoice_assignments_invoice_datum_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.group_permission DROP FOREIGN KEY group_permission_group_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.group_permission DROP FOREIGN KEY group_permission_permission_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.group_panel DROP FOREIGN KEY group_panel_group_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.group_panel DROP FOREIGN KEY group_panel_panel_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.customers_tax DROP FOREIGN KEY customers_tax_public_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.cashiers_drops DROP FOREIGN KEY FK_cashier_id
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.cashiers_drops DROP FOREIGN KEY FK_people_cashier
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.activities_logs DROP FOREIGN KEY FK_activity_log
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments DROP FOREIGN KEY FK_shipment_agreement
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments DROP FOREIGN KEY FK_shipment_destination
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments DROP FOREIGN KEY FK_shipment_receiver
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments DROP FOREIGN KEY FK_shipment_sender
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments DROP FOREIGN KEY FK_shipment_staff
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.shipments DROP FOREIGN KEY FK_subsidiary_shipment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.activities DROP FOREIGN KEY FK_activity_driver
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.activities DROP FOREIGN KEY FK_activity_periplo
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.activities DROP FOREIGN KEY FK_activity_vehicle
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.subsidiaries_staff DROP FOREIGN KEY FK_ss_staff
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.subsidiaries_staff DROP FOREIGN KEY FK_ss_subsidiary
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.subsidiaries DROP FOREIGN KEY FK_subsidiaries_administrator
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.subsidiaries DROP FOREIGN KEY FK_subsidiaries_manager
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.periplos DROP FOREIGN KEY FK_periplo_destination
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.periplos DROP FOREIGN KEY FK_periplo_origin
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.payments DROP FOREIGN KEY FK_cashier_payment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.payments DROP FOREIGN KEY FK_people_payment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.packages DROP FOREIGN KEY FK_package_container
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.packages DROP FOREIGN KEY FK_package_shipment
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.users DROP FOREIGN KEY users_person_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.invoices DROP FOREIGN KEY invoices_person_id_foreign
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.drivers DROP FOREIGN KEY FK_driver_people
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.destinations DROP FOREIGN KEY FK_dest_subsidiary
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE matelangular.address_assignments DROP FOREIGN KEY address_assignments_address_id_foreign
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.vehicles_logs
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.user_panel_permissions
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.user_panel
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.user_group
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.subsidiaries_desks
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.shipments_status
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.shipments_payments
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.shipments_extras
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.prices
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.packages_status
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.invoice_assignments
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.group_permission
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.group_panel
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.customers_tax
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE matelangular.cashiers_drops
;-- -. . -..- - / . -. - .-. -.--
SELECT LOCATE('::','Modelo::1')
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1'))
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2,-1)
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', (LOCATE('::','Modelo::1')+2)*-1)
;-- -. . -..- - / . -. - .-. -.--
SELECT left('Modelo::1', LOCATE('::','Modelo::1')+2)
;-- -. . -..- - / . -. - .-. -.--
SELECT right('Modelo::1', LOCATE('::','Modelo::1')+2)
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2)
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2, 0)
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2),
  substr('Modelo::1',0, LOCATE('::','Modelo::1'))
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2),
  right('Modelo::1',LOCATE('::','Modelo::1'))
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2),
  left('Modelo::1',LOCATE('::','Modelo::1'))
;-- -. . -..- - / . -. - .-. -.--
SELECT substr('Modelo::1', LOCATE('::','Modelo::1')+2),
  left('Modelo::1',LOCATE('::','Modelo::1')-1)
;-- -. . -..- - / . -. - .-. -.--
CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Sub-dominio',
  `implementation` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre del tipo de Implementación',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre completo de la institución',
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Numero/Código de cliente',
  `short_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Nombre corto de la escuela',
  `contact` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Datos de contacto',
  `contract` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Datos de contrato',
  `billing` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'Configuración de facturación',
  `config` text COLLATE utf8_unicode_ci COMMENT 'Configuración de general',
  `database` text COLLATE utf8_unicode_ci COMMENT 'Configuración de base de datos',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_nick_unique` (`nick`),
  KEY `customers_nick_index` (`nick`),
  KEY `customers_implementation_index` (`implementation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Definición de instalaciones/clientes'
;-- -. . -..- - / . -. - .-. -.--
drop table IF EXISTS `customers`
;-- -. . -..- - / . -. - .-. -.--
DROP TABLE IF EXISTS `customers`
;-- -. . -..- - / . -. - .-. -.--
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
  COMMENT = 'Definición de instalaciones/clientes'
;-- -. . -..- - / . -. - .-. -.--
SELECT groups.name, permissions.name
FROM groups
LEFT JOIN group_permission ON groups.id = group_permission.group_id
LEFT JOIN permissions ON permissions.id = group_permission.permission_id
;-- -. . -..- - / . -. - .-. -.--
SELECT groups.name, permissions.name
FROM groups
LEFT JOIN group_permission ON groups.id = group_permission.group_id
LEFT JOIN permissions ON permissions.id = group_permission.permission_id
WHERE groups.id =  11
;-- -. . -..- - / . -. - .-. -.--
ALTER TABLE invoices AUTO_INCREMENT = 25