/* QUERY NAME: [Grade] Student CP Breakdown */

/* DESCRIPTION FOR MOODLE - Copy and paste the HTML code below
<p>Set the <code>firstname</code> and <code>lastname</code> parameters with the student's first and last name.</p>
*/

SELECT
cc.name AS "Category",
c.fullname AS "Course",
gi.itemname AS "Item Name",
ROUND(gg.finalgrade,2) AS "Grade",
DATE_FORMAT(FROM_UNIXTIME(gg.timemodified),'%Y-%m-%d') AS Time

FROM prefix_course AS c
JOIN prefix_context AS ctx ON c.id = ctx.instanceid
JOIN prefix_role_assignments AS ra ON ra.contextid = ctx.id
JOIN prefix_user AS u ON u.id = ra.userid
JOIN prefix_grade_grades AS gg ON gg.userid = u.id
JOIN prefix_grade_items AS gi ON gi.id = gg.itemid
JOIN prefix_grade_categories AS gc ON gc.id = gi.categoryid
JOIN prefix_course_categories as cc ON cc.id = c.category

WHERE  gi.courseid = c.id 
AND u.firstname = :firstname
AND u.lastname = :lastname
AND gc.fullname LIKE '%CP%'

ORDER BY cc.name, c.fullname, gi.id, LENGTH(gi.itemname), gi.itemname