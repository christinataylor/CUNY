--INSERT INTO employeetable (employee_id, employee_name, title, department)
--VALUES
--(1, 'Steve Jobs', 'CEO', 'Company-Wide'),
--(2, 'Scott Forstall', 'SVP', 'IOS Software'),
--(3, 'Kim Vorrath', 'VP', 'IOS Software'),
--(4, 'Isabel Ge Mahe', 'VP', 'IOS Software'),
--(5, 'Henri Lamiraux', 'VP', 'IOS Software'),
--(6, 'Peter Oppenheimer', 'SVP', 'Finance'),
--(7, 'Gary Wipfler', 'VP', 'Finance'),
--(8, 'Betsy Rafael', 'VP', 'Finance'),
--(9, 'Timoothy Cook', 'COO', 'Company-Wide'),
--(10, 'John Brandon', 'VP', 'Operations'),
--(11, 'Michael Fenger', 'VP', 'Operations'),
--(12, 'Douglas Beck', 'VP', 'Operations');

INSERT INTO employeetable (employee_id, employee_name)
VALUES
(1, 'Steve Jobs'),
(2, 'Scott Forstall'),
(3, 'Kim Vorrath'),
(4, 'Isabel Ge Mahe'),
(5, 'Henri Lamiraux'),
(6, 'Peter Oppenheimer'),
(7, 'Gary Wipfler'),
(8, 'Betsy Rafael'),
(9, 'Timothy Cook'),
(10, 'John Brandon'),
(11, 'Michael Fenger'),
(12, 'Douglas Beck');

INSERT INTO titletable (title_id, title_name)
VALUES
(1, 'CEO'),
(2, 'COO'),
(3, 'SVP'),
(4, 'VP');

INSERT INTO departmenttable (department_id, department_name)
VALUES
(1, 'Company-Wide'),
(2, 'IOS Software'),
(3, 'Finance'),
(4, 'Operations');

INSERT INTO identitytable (employee_id, title_id, department_id)
VALUES
(1, 1, 1),
(2, 3, 2),
(3, 4, 2),
(4, 4, 2),
(5, 4, 2),
(6, 3, 3),
(7, 4, 3),
(8, 4, 3),
(9, 2, 1),
(10, 4, 4),
(11, 4, 4),
(12, 4, 4);