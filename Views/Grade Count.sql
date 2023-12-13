CREATE OR REPLACE VIEW grade_count AS
SELECT gi.id AS itemid, COUNT(DISTINCT gg.userid) AS grade_count

FROM prefix_grade_items AS gi
JOIN prefix_grade_grades AS gg ON gg.itemid = gi.id
JOIN prefix_course AS c ON c.id = gi.courseid
JOIN student_count AS sc ON sc.cid = c.id

WHERE gi.itemname IS NOT NULL
AND gi.itemname != ''

GROUP BY gi.id