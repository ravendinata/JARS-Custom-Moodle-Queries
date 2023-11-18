SELECT 
classname AS "Cron Task Name",
DATE_FORMAT(FROM_UNIXTIME(lastruntime), '%H:%i [%d/%m]') AS "Last Run",
DATE_FORMAT(FROM_UNIXTIME(nextruntime), '%H:%i [%d/%m]') AS "Next Scheduled Run (NSR)",
DATE_FORMAT(FROM_UNIXTIME(UNIX_TIMESTAMP() - nextruntime), '%i mins') AS "To NSR (mins)"

FROM prefix_task_scheduled

WHERE now() > FROM_UNIXTIME(nextruntime)