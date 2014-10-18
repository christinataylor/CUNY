SELECT
	employeetable.employee_name,
	titletable.title_name,
	departmenttable.department_name
FROM
	identitytable
INNER JOIN employeetable ON identitytable.employee_id = employeetable.employee_id
INNER JOIN titletable ON identitytable.title_id = titletable.title_id
INNER JOIN departmenttable ON identitytable.department_id = departmenttable.department_id;

INSERT INTO employeetable (employee_id, employee_name)
VALUES
(13, 'Susan Wojcicki');

UPDATE identitytable
SET employee_id = 13
WHERE employee_id = 9;

UPDATE identitytable
SET employee_id = 9
WHERE employee_id = 1;