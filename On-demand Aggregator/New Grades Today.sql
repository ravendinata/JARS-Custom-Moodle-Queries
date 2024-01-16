SELECT
log.id AS 'Log ID',
DATE_FORMAT(FROM_UNIXTIME(log.timecreated), '%T') AS 'Time Logged',
log.other AS 'JSON Info',
CONCAT(u.firstname, " ", u.lastname) AS 'Grader',
CONCAT(s.firstname, " ", s.lastname) AS 'Gradee',
c.fullname AS 'Course Name',
gi.itemname AS 'Graded Item'

FROM prefix_logstore_standard_log AS log
JOIN prefix_user AS u ON u.id = log.userid
JOIN prefix_user AS s ON s.id = log.relateduserid
JOIN prefix_course AS c ON c.id = log.courseid
JOIN prefix_grade_items AS gi ON gi.id = JSON_UNQUOTE(JSON_EXTRACT(log.other, "$.itemid"))

WHERE log.action = "graded"
AND DATE_FORMAT(FROM_UNIXTIME(log.timecreated), '%Y-%m-%d') = DATE_FORMAT(NOW(), '%Y-%m-%d')
AND log.userid != log.relateduserid

ORDER BY log.timecreated DESC