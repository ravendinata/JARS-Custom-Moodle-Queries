/* QUERY NAME: [Grade] New Grades On Date */

/* DESCRIPTION FOR MOODLE - Copy and paste the HTML code below
<p>
    Set the <code>day to check</code> parameter with the date you want to see new grades for. You should enter in this format:<br>
    yyyy-mm-dd (such that: if the date is a single digit, please pad it with a 0 (zero))<br>
    For example, if the date is 2023-07-01, it will only show grades that were entered on that date.<br>
    <em>Note: Admin should update this to the beginning of the current semester if all goes well</em>
</p>
*/

SELECT
log.id AS 'Log ID',
DATE_FORMAT(FROM_UNIXTIME(log.timecreated), '%T') AS 'Time Logged',
log.other AS 'JSON Info',
CONCAT(u.firstname, " ", u.lastname) AS 'Grader',
CONCAT(s.firstname, " ", s.lastname) AS 'Gradee',
c.fullname AS 'Course Name'

FROM prefix_logstore_standard_log AS log
JOIN prefix_user AS u ON u.id = log.userid
JOIN prefix_user AS s ON s.id = log.relateduserid
JOIN prefix_course AS c ON c.id = log.courseid

WHERE log.action = "graded"
AND DATE_FORMAT(FROM_UNIXTIME(log.timecreated), '%Y-%m-%d') = :day_to_check

ORDER BY log.timecreated DESC