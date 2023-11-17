SELECT
cat.id AS "ID",
cat.name AS "Category",
IF(cat.parent = 0, "0 (Top)", cat.parent) AS "Parent_id",
cat.path AS "Path IDs"

FROM prefix_course_categories cat

ORDER BY cat.id