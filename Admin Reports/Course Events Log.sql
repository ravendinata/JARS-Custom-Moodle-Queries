SELECT
l.id AS "Log ID",
IF(c.id IS NULL, "Course not found! Potentially Deleted.", c.shortname) AS "Course",
l.courseid AS "Course ID",
IF(c.id IS NULL, "Course does not exist!", cc.name) AS "Category",
CASE
    WHEN l.action = 'created' THEN 'Created'
    WHEN l.action = 'restored' THEN 'Restored'
    WHEN l.action = 'deleted' THEN 'Deleted'
    ELSE 'Unknown'
END AS "Action",
IF(u.id IS NULL, "Username not found! Potentially Deleted.", u.username) As "By",
l.userid AS "User ID",
DATE_FORMAT(FROM_UNIXTIME(l.timecreated),'%Y-%m-%d %H:%i') AS "When"

FROM mdl_logstore_standard_log l
LEFT JOIN mdl_course c ON c.id = l.courseid
LEFT JOIN mdl_user u ON u.id = l.userid
LEFT JOIN mdl_course_categories cc ON cc.id = c.category

WHERE l.eventname =  '\\core\\event\\course_created' 
OR l.eventname = '\\core\\event\\course_restored'
OR l.eventname = '\\core\\event\\course_deleted'