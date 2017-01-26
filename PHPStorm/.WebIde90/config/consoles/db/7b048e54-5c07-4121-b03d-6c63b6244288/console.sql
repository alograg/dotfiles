SELECT *
FROM registrations
WHERE degree_id BETWEEN 316 AND 337;
UPDATE registrations SET degree_id= degree_id+3
WHERE degree_id BETWEEN 316 AND 337;

SELECT *
FROM group_student
WHERE group_id BETWEEN 288 AND 308;

REPLACE INTO group_student
  SELECT group_id+28+3, student_id
  FROM group_student
  WHERE group_id BETWEEN 288 AND 305;
