SELECT
DATE_FORMAT(FROM_UNIXTIME(g.timemodified), '%Y-%m-%d') AS date,
u.username AS "User",
g.name AS "Setting",
CASE
    WHEN g.plugin IS NULL THEN "core"
    ELSE g.plugin
END AS "Plugin",
g.value AS "New Value",
g.oldvalue AS "Original Value"

FROM prefix_config_log g
JOIN prefix_user AS u ON g.userid = u.id

ORDER BY date DESC