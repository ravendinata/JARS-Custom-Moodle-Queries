SELECT
ch.name AS 'Class',
c.fullname AS 'Course',
CONCAT(u.firstname, ' ', u.lastname) AS 'Student Name',
ROUND(gg.finalgrade,2) AS Grade,
DATE_FORMAT(FROM_UNIXTIME(gg.timemodified),'%Y-%m-%d') AS Time

FROM prefix_course AS c
JOIN prefix_context AS ctx ON c.id = ctx.instanceid
JOIN prefix_role_assignments AS ra ON ra.contextid = ctx.id
JOIN prefix_user AS u ON u.id = ra.userid
JOIN prefix_grade_grades AS gg ON gg.userid = u.id
JOIN prefix_grade_items AS gi ON gi.id = gg.itemid
JOIN prefix_course_categories as cc ON cc.id = c.category
JOIN prefix_cohort_members as chm ON chm.userid = u.id
JOIN prefix_cohort as ch ON ch.id = chm.cohortid

WHERE gi.courseid = c.id
AND ch.idnumber IN (:cohort_1, :cohort_2, :cohort_3)
AND gi.itemtype = 'category'
AND gi.itemname LIKE '%cp%'

ORDER BY c.fullname, gi.id, ch.name, u.firstname, u.lastname