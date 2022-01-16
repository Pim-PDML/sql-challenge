CREATE TABLE departments (
  	dept_no varchar(4) NOT NULL,
	dept_name varchar(20) NOT NULL
);

CREATE TABLE dept_emp (
emp_no varchar(6) NOT NULL,
dept_no varchar(4) NOT NULL
);

CREATE TABLE dept_manager (
dept_no varchar(4) NOT NULL,
emp_no varchar(6) NOT NULL
);

CREATE TABLE employees (
emp_no varchar(6) NOT NULL,
emp_title_id varchar(5) NOT NULL,
birth_date varchar(10) NOT NULL,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
sex varchar(1) NOT NULL,
hire_date varchar(10) NOT NULL
);

-- to_char, to_date
ALTER TABLE employees 
ALTER COLUMN hire_date TYPE DATE using to_date(hire_date, 'MM/DD/YYYY');

ALTER TABLE employees 
ALTER COLUMN birth_date TYPE DATE using to_date(birth_date, 'MM/DD/YYYY');


CREATE TABLE salaries (
emp_no varchar(6) NOT NULL,
salary decimal(18,0) NOT NULL
);

CREATE TABLE titles (
title_id varchar(5) NOT NULL,
title varchar(30) NOT NULL
);

/* select * from departments
select * from dept_emp
select * from dept_manager
select * from employees
select * from salaries
select * from titles */


--List the following details of each employee: employee number, last name, first name, sex, and salary.
create table employee_detail(
emp_no varchar(6) NOT NULL,
last_name varchar(30) NOT NULL,
first_name varchar(30) NOT NULL,
sex varchar(1) NOT NULL,
salary decimal(18,0) NOT NULL
);

insert into employee_detail
select 	a.emp_no as "employee number", a.last_name, a.first_name, a.sex, b.salary
from 	employees as a
		inner join salaries as b
		on a.emp_no = b.emp_no;


--select * from employee_detail

--List first name, last name, and hire date for employees who were hired in 1986.
create table employee_hired(
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
hire_date varchar(10) NOT NULL
);

insert into employee_hired
select first_name, last_name, hire_date
from	employees
where hire_date between '1986-01-01' and '1986-12-31';


--List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
create table manager_department(
dept_no varchar(4) NOT NULL,
dept_name varchar(20) NOT NULL,
emp_no varchar(6) NOT NULL,	
last_name varchar(30) NOT NULL,
first_name varchar(30) NOT NULL
);

insert into manager_department
select 	a.dept_no as "department number", a.dept_name as "department name",
		b.emp_no as "employee number", c.last_name, c.first_name
from	departments as a
		inner join dept_manager as b
		on a.dept_no = b.dept_no
		inner join employees as c
		on b.emp_no = c.emp_no;


--List the department of each employee with the following information: employee number, last name, first name, and department name.
create table employee_department(
	emp_no varchar(6) NOT NULL,	
	last_name varchar(30) NOT NULL,
	first_name varchar(30) NOT NULL,
	dept_name varchar(20) NOT NULL
);

insert into employee_department
select	b.emp_no as "employee number", c.last_name, c.first_name, a.dept_no as "department number"
from 	departments as a
		inner join dept_emp as b
		on a.dept_no = b.dept_no
		inner join employees as c
		on b.emp_no = c.emp_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
create table Hercules(
	first_name varchar(30) NOT NULL,
	last_name varchar(30) NOT NULL,
	sex varchar(1) NOT NULL
);

insert into Hercules
select	first_name, last_name, sex
from	employees 
where	first_name = 'Hercules' and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

create table sales(
	emp_no varchar(6) NOT NULL,	
	last_name varchar(30) NOT NULL,
	first_name varchar(30) NOT NULL,
	dept_name varchar(20) NOT NULL
);

insert into sales
select	b.emp_no as "employee number", c.last_name, c.first_name, a.dept_no as "department number"
from 	departments as a
		inner join dept_emp as b
		on a.dept_no = b.dept_no
		inner join employees as c
		on b.emp_no = c.emp_no
where a.dept_name = 'Sales'	;	

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

create table sales_Development(
	emp_no varchar(6) NOT NULL,	
	last_name varchar(30) NOT NULL,
	first_name varchar(30) NOT NULL,
	dept_name varchar(20) NOT NULL
);

insert into sales_Development
select	b.emp_no as "employee number", c.last_name, c.first_name, a.dept_no as "department number"
from 	departments as a
		inner join dept_emp as b
		on a.dept_no = b.dept_no
		inner join employees as c
		on b.emp_no = c.emp_no
where a.dept_name in ('Sales','Development')	;

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
create table last_name_frequency(
	last_name varchar(30) NOT NULL,
	frequency integer
);
insert into last_name_frequency
select  last_name, count(*) as frequency
from	employees
group by last_name 
order by last_name desc;







