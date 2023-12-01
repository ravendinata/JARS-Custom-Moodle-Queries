CREATE OR REPLACE VIEW student_count AS
SELECT c.id AS cid, COUNT(DISTINCT u.id) AS student_count

FROM prefix_user AS u
JOIN prefix_user_enrolments AS ue ON ue.userid = u.id
JOIN prefix_enrol AS e ON e.id = ue.enrolid
JOIN prefix_course AS c ON c.id = e.courseid
JOIN prefix_role_assignments AS ra ON ra.userid = u.id
JOIN prefix_role AS r ON r.id = ra.roleid

WHERE r.id = 5

GROUP BY c.id;