/* QUERY NAME: [Attendance] Students whose attendance is below n% */

/* DESCRIPTION FOR MOODLE - Copy and paste the HTML code below
<ul>
<li>Set the <code>session_start</code> parameter with a date from which you want the query to look into. You should enter in this format: <br>yyyy-mm-dd (such that: if the date is a single digit, please pad it with a 0 (zero))<br>For example, if the session is set to 2023-07-01, it will only calculate from that date onwards up to today.<br><em>Note: Admin should update this to the beginning of the current semester if all goes well</em></li>
<li>Enter the minimum percentage to pass into the <code>minimum_percent</code> field. The query will show students whose attendance percentage is under this percentage set inside the <code>minimum_percent</code> field.</li>
</ul>
*/

SELECT
c.fullname AS "Course",
atl.studentid AS "User ID", 
CONCAT(u.firstname, " ", u.lastname) AS "Student Name", 
COUNT(DISTINCT ats.id) AS "Taken Sessions",
SUM(stg.grade) AS "Points", 
SUM(stm.maxgrade) AS "Maximum Points",
ROUND(SUM(stg.grade) / SUM(stm.maxgrade) * 100, 2) AS "Attendance Percent"

FROM prefix_attendance_sessions AS ats
JOIN prefix_attendance_log AS atl ON (atl.sessionid = ats.id)
JOIN prefix_attendance_statuses AS stg ON (stg.id = atl.statusid AND stg.deleted = 0 AND stg.visible = 1)
JOIN prefix_attendance AS a ON a.id = ats.attendanceid
JOIN prefix_course AS c ON c.id = a.course
JOIN prefix_user AS u ON u.id = atl.studentid
JOIN (
	SELECT setnumber, MAX(grade) AS maxgrade
	FROM prefix_attendance_statuses
	WHERE attendanceid = 2
	AND deleted = 0
	AND visible = 1
	GROUP BY setnumber) stm
ON (stm.setnumber = ats.statusset)

WHERE ats.sessdate >= unix_timestamp(:session_start)
AND ats.lasttaken != 0

GROUP BY atl.studentid
HAVING SUM(stg.grade) / SUM(stm.maxgrade) * 100 < :minimum_percent