SELECT
l.id AS "Log ID",
IF(c.id IS NULL, CONCAT("Name not found! (Deleted ID: ", l.courseid, ")"), c.shortname) AS "Course",
IF(l.action='restored', "Restore", "Create") AS "Action",
IF(u.id IS NULL, CONCAT("Username not found! Deleted ID: ", l.userid, ")"), u.username) As "By",
DATE_FORMAT(FROM_UNIXTIME(l.timecreated),'%Y-%m-%d %H:%i') AS "Operation Time"

FROM prefix_logstore_standard_log l
LEFT JOIN prefix_course c ON c.id = l.courseid
LEFT JOIN prefix_user u ON u.id = l.userid

WHERE l.eventname =  '\\core\\event\\course_created' 
OR l.eventname = '\\core\\event\\course_restored'