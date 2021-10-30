-- Select all the employees who were born between January 1, 1952 and December 31, 1955 and their titles and title date ranges
-- Order the results by emp_no

with emps as (select * from employees 
where birth_date between '1952-01-01' and '1955-12-31')
select emps.emp_no, 
	   emps.first_name,
	   emps.last_name,
	   titles.title,
	   emps.birth_date,
	   titles.from_date,
	   titles.to_date
	   from emps join titles 
	   on emps.emp_no=titles.emp_no
	   order by emp_no;
	   
-- Select only the current title for each employee

with emp_data as (
with retirees as (select * from employees 
where birth_date between '1952-01-01' and '1955-12-31')
	
select  retirees.emp_no, 
		retirees.first_name,
		retirees.last_name,
		retirees.birth_date,
		titles.title,
		titles.from_date,
		titles.to_date
		from retirees join titles 
		on retirees.emp_no=titles.emp_no
		order by emp_no),
		
latest_emp as (
select emp_no, max(from_date) as most_recent from titles group by emp_no)

select emp_data.emp_no, emp_data.first_name, emp_data.last_name, emp_data.title as current_title from emp_data join latest_emp on ((emp_data.emp_no=latest_emp.emp_no) and (emp_data.from_date=latest_emp.most_recent));

-- Count the total number of employees about to retire by their current job title

with modified_title as (
with emp_data as (
with retirees as (select * from employees 
where birth_date between '1952-01-01' and '1955-12-31')
	
select  retirees.emp_no, 
		retirees.first_name,
		retirees.last_name,
		retirees.birth_date,
		titles.title,
		titles.from_date,
		titles.to_date
		from retirees join titles 
		on retirees.emp_no=titles.emp_no
		order by emp_no),
		
latest_emp as (
select emp_no, max(from_date) as most_recent from titles group by emp_no)

select emp_data.emp_no, emp_data.first_name, emp_data.last_name, emp_data.title as current_title from emp_data join latest_emp on ((emp_data.emp_no=latest_emp.emp_no) and (emp_data.from_date=latest_emp.most_recent)))

select count (*) as emp_cnt,current_title from modified_title group by current_title ORDER BY emp_cnt DESC;

-- Count the total number of employees per department

with count_by_dept as(
select dept_no, count(emp_no) as emp_cnt from dept_emp group by dept_no )
select dept_name, count_by_dept.emp_cnt from departments join count_by_dept on (departments.dept_no=count_by_dept.dept_no) order by emp_cnt desc;

-- Bonus: Find the highest salary per department and department manager

--Highest salary per department
with emp_salary as (
with new_date as(
with new_employee as (select emp_no, max(from_date) as from_date from dept_emp group by emp_no)
select new_employee.emp_no, 
		new_employee.from_date, 
		dept_emp.dept_no
		from new_employee join dept_emp 
		on new_employee.emp_no=dept_emp.emp_no
			and dept_emp.from_date=new_employee.from_date)
			select new_date.emp_no,
					new_date.dept_no,
					salaries.salary
					from new_date join salaries
					on new_date.emp_no=salaries.emp_no
					and new_date.from_date=salaries.from_date
					order by emp_no)
		select dept_no, 
				max(salary) as highest_salary from
				emp_salary
				group by dept_no
				order by dept_no

--Highest salary per department manager

with man_salaries as (
with new_salary as (
with new_emp as( 
select emp_no,
		max(from_date) as latest_appt 
		from salaries group by emp_no)
select new_emp.*, 
		salaries.salary 
		from salaries join new_emp 
		on salaries.emp_no=new_emp.emp_no 
		and salaries.from_date=new_emp.latest_appt
		order by emp_no),

current_managers as(
select dept_no, emp_no, from_date from dept_manager where to_date= '9999-01-01')
	
select current_managers.dept_no, 
		new_salary.emp_no, 
		new_salary.salary 
		from current_managers join
		new_salary on current_managers.emp_no=new_salary.emp_no)
select max(salary) from man_salaries







