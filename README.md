This repository contains a collection of SQL queries that can be used with Moodle to gain a more insightful information on the students, cohort, and others.

# How to use the queries?
## Requirements
**Ad-hoc database queries**  
If you have not installed this plugin, please download it from [here](https://moodle.org/plugins/report_customsql) and install it on your Moodle server.
> [!NOTE]
> The queries are designed to be used with, tested, and validated for Ad-hoc database queries. But, the query structure is basically the same. Hence, these queries can also be used with other custom report plugins such as the [Cofigurable Reports](https://moodle.org/plugins/block_configurable_reports) plugin with some modification to match the plugin requirements. By simply changing `prefix_` to `mdl_` you can also use the queries with data querying tools such as MySQL Workbench.

> [!IMPORTANT]
> Please check if the tables used in the queries are still active in your Moodle version. Some tables might have been deprecated in your Moodle version.  
> The SQL queries in this collection is tested with:
> - Moodle 4.2.3 (2023042403)[^1]
> - MySQL 10.4.28-MariaDB[^2]
> - Ad-hoc database queries 4.2 for Moodle 3.9+ (2022031800)[^3]

> [!IMPORTANT]
> Some queries in the collection is made for the custom plugin [Attendance](https://moodle.org/plugins/mod_attendance). Those queries **_will not work_** if this plugin is not installed since the associated tables do not exist in the base Moodle database[^4].
## Usage Steps
1. Navigate to your **Ad-hoc database queries** page. This should be accessible through Admin > Reports > Ad-hoc database queries. Or, you can simply append `/report/customsql/index.php` to the end of your Moodle server root URL.
2. Click on _Add a new query_
3. Fill in the information fields according to your needs.
> [!TIP]
> The queries within this collection also include "Query Name" and "Query Description" that we have created. Feel free to use them in your custom queries!
5. Copy and paste only the SQL code section into the Query SQL textbox. The beginning of the code section should always begin with the `SELECT` statement. Select the code from the beginning to the end of the file.
6. Click on the _Verify the Query SQL text and updatet the form_ button. This will check the query for parameters and will create a field for it. If you do have parameters, you can set the default values for the parameters.
7. Adjust the remaining settings to your needs.
8. Click on _Save changes_. If all goes well, you should be brought to the query page. If there are issues, check the error message under the Query SQL text field.
9. Try out your new query and see if it works as intended. If not, try to modify the query yourself to fit your needs.

# Contributors
[Raven Limadinata](https://github.com/ravendinata) (JAC School Research and Development Team)  

# Credits
Some of the queries here are either an adaptation of or a direct adoption of the queries shared by other Moodle admins on [this page](https://docs.moodle.org/311/en/ad-hoc_contributed_reports). So credits where it is due to the original authors.

***

> **Disclaimer**  
> This repository, the owner of this repository, and the contributors who are internal to the repository's organization are not affiliated with Moodle, the maintainers of Ad-hoc database queries, the authors of the original SQL queries nor other parties whose products are mentioned in this repository. The original owner and maintainer of this repository, Raven Limadinata, at the time of creating the repository, is a full-time employee of PT. Putra Putri Harapan and is/was solely affiliated with the employer. If you are the author of an adopted query shared in this repository and seeks to have yourself creditted for the work, or wants the query to not be shared within this repository, please contact the active repository owner.

[^1]: https://moodledev.io/general/releases/4.2/4.2.3
[^2]: https://mariadb.com/kb/en/mariadb-10-4-28-release-notes/
[^3]: https://moodle.org/plugins/report_customsql/4.2-for-moodle-3.9/26177
[^4]: https://www.examulator.com/er/4.0/
