--CREATE TABLE employeetable
--(
--	employee_id integer,
--	employee_name varchar,
--	title varchar,
--	department varchar,
--	CONSTRAINT employee_pkey PRIMARY KEY (employee_id)
--);

CREATE TABLE employeetable
(
	employee_id integer,
	employee_name varchar,
	CONSTRAINT employee_pkey PRIMARY KEY (employee_id)
);

CREATE TABLE titletable
(
	title_id integer,
	title_name varchar,
	CONSTRAINT title_pkey PRIMARY KEY (title_id)
);

CREATE TABLE departmenttable
(
	department_id integer,
	department_name varchar,
	CONSTRAINT department_pkey PRIMARY KEY (department_id)
);

CREATE TABLE identitytable
(
	employee_id integer,
	title_id integer,
	department_id integer,
	CONSTRAINT identity_pkey PRIMARY KEY (employee_id)
);