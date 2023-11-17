SELECT
DATE_FORMAT(FROM_UNIXTIME(g.timemodified), '%Y-%m-%d') AS date,
u.username AS user,
g.name AS setting,
CASE
    WHEN g.plugin IS NULL THEN "core"
    ELSE g.plugin
END AS plugin,
g.value AS new_value,
g.oldvalue AS original_value

FROM prefix_config_log g
JOIN prefix_user AS u ON g.userid = u.id

ORDER BY date DESC