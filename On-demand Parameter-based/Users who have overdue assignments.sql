/* QUERY NAME: [Overdue] Users who have overdue assignments */

/* DESCRIPTION FOR MOODLE - Copy and paste the HTML code below
<p>In the filter role field, enter the following for filtering options:</p>
<ul>
<li><code>student</code> for students</li>
<li><code>teacher-syswide</code> for teachers</li>
</ul>
*/

SELECT DISTINCT
CONCAT(u.firstname, " ", u.lastname) AS "Name",
c.fullname AS "Course",
a.name AS "Assignment",
DATE_FORMAT(FROM_UNIXTIME(a.gradingduedate), '%Y-%m-%d %H:%i') AS "Due Date",
DATEDIFF(NOW(), FROM_UNIXTIME(a.gradingduedate)) AS "Days Late"

FROM prefix_user_enrolments ue
JOIN prefix_enrol AS e ON e.id = ue.enrolid
JOIN prefix_course AS c ON c.id = e.courseid
JOIN prefix_user AS u ON u.id = ue.userid
JOIN prefix_assign a ON a.course = c.id
JOIN prefix_role_assignments ra ON ra.userid = ue.userid
JOIN prefix_role AS r ON r.id = ra.roleid

/* Only show assignments that are due in the past 180 days */
WHERE DATEDIFF(NOW(), FROM_UNIXTIME(a.gradingduedate)) > 0 
AND DATEDIFF(NOW(), FROM_UNIXTIME(a.gradingduedate)) < 180
AND ue.userid NOT IN 
 (SELECT asub.userid
  FROM prefix_assign_submission AS asub
  JOIN prefix_assign AS a ON a.id = asub.assignment 
  JOIN prefix_course c on a.course = c.id
  WHERE asub.status = 'submitted')
AND u.username != 'admin'
AND r.shortname = :filter_role

ORDER BY days_late DESC, u.firstname, u.lastname, c.fullname, a.id, a.name, LENGTH(a.name)