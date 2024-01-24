SELECT 
c.id AS 'Course ID',
cc.name AS 'Category Name',
c.fullname AS 'Course Name',
gi.itemname AS 'Item Name',
(SELECT CONCAT(u.firstname, " ", u.lastname)
FROM prefix_role_assignments AS ra
JOIN prefix_context AS ctx ON ra.contextid = ctx.id
JOIN prefix_user AS u ON ra.userid = u.id
WHERE ra.roleid = 3 AND ctx.instanceid = c.id) AS 'Teacher'

FROM prefix_course AS c
JOIN prefix_grade_items AS gi ON  gi.courseid = c.id
JOIN prefix_course_categories AS cc ON cc.id = c.category
JOIN prefix_grade_categories AS gc ON gc.id = gi.categoryid

WHERE (
	gi.id IN (
		SELECT gi.id

		FROM prefix_course AS c
		JOIN prefix_context AS ctx ON c.id = ctx.instanceid
		JOIN prefix_role_assignments AS ra ON ra.contextid = ctx.id
		JOIN prefix_user AS u ON u.id = ra.userid
		JOIN prefix_grade_grades AS gg ON gg.userid = u.id
		JOIN prefix_grade_items AS gi ON gi.id = gg.itemid AND gi.courseid = c.id
		JOIN prefix_grade_categories AS gc ON gc.id = gi.categoryid
		JOIN prefix_course_categories as cc ON cc.id = c.category

		WHERE gg.aggregationstatus = 'novalue'
		AND gg.userid NOT IN (
			SELECT u.id
			FROM prefix_role_assignments AS ra
			JOIN prefix_context AS ctx ON ra.contextid = ctx.id
			JOIN prefix_user AS u ON ra.userid = u.id
			WHERE ra.roleid = 3 AND ctx.instanceid = c.id)
		AND cc.name != 'Teachers Only'
	)
	OR gi.id NOT IN (
		-- Select all items that do not have a grade
		SELECT gi.id

		FROM prefix_course AS c
		JOIN prefix_grade_items AS gi ON gi.courseid = c.id
		JOIN prefix_grade_grades AS gg ON gg.itemid = gi.id
	)
    OR gi.id IN (
        SELECT gi.id

        FROM prefix_grade_items AS gi
        JOIN prefix_course AS c ON c.id = gi.courseid
        JOIN student_count AS sc ON sc.cid = c.id
        JOIN grade_count AS gc ON gc.itemid = gi.id

        WHERE gi.itemname IS NOT NULL
        AND gi.itemname != ''
        AND sc.student_count > gc.grade_count
    )
)
AND c.id != 1 -- Exclude the front page
AND cc.name != 'Teachers Only' -- Exclude the Teachers Only category
AND gc.fullname = 'CP'

ORDER BY c.fullname, gc.path, gi.id, LENGTH(gi.itemname), gi.itemname