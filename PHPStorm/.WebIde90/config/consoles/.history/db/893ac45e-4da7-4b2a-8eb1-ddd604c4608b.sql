DELETE FROM users_groups
WHERE user_id > 12
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM throttle
WHERE user_id > 12
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM users
WHERE id > 12
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM o2_test.users_groups
WHERE user_id > 12
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM o2_test.throttle
WHERE user_id > 12
;-- -. . -..- - / . -. - .-. -.--
DELETE FROM o2_test.users
WHERE id > 12
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM student_registration
JOIN registrations ON student_registration.registration_id = registrations.id
;-- -. . -..- - / . -. - .-. -.--
SELECT count(registrations.student_id) as user_count, student_registration.status, student_registration.degree_id'
FROM student_registration
JOIN registrations ON student_registration.registration_id = registrations.id
;-- -. . -..- - / . -. - .-. -.--
SELECT count(registrations.student_id) as user_count, student_registration.status, student_registration.degree_id
FROM student_registration
JOIN registrations ON student_registration.registration_id = registrations.id
WHERE registrations.intention = 0
AND student_registration.status !='Baja'
GROUP BY student_registration.degree_id,student_registration.status
;-- -. . -..- - / . -. - .-. -.--
SHOW DATABASES