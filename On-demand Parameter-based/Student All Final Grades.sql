SELECT
cc.name AS 'Category',
c.fullname AS 'Course',
ROUND(gg.finalgrade,2) AS Grade

FROM prefix_course AS c
JOIN prefix_context AS ctx ON c.id = ctx.instanceid
JOIN prefix_role_assignments AS ra ON ra.contextid = ctx.id
JOIN prefix_user AS u ON u.id = ra.userid
JOIN prefix_grade_grades AS gg ON gg.userid = u.id
JOIN prefix_grade_items AS gi ON gi.id = gg.itemid
JOIN prefix_course_categories as cc ON cc.id = c.category

WHERE  gi.courseid = c.id 
AND u.firstname = :first_name
AND u.lastname = :last_name
AND gi.itemtype = 'course'

ORDER BY cc.name, c.fullname