


-- Retrieving demographic information across employee and department tables to return results of
--users that make less than 120000 salary
SELECT e.last_name,
	e.email,
	cd.department_name
FROM data_sci.employees e
INNER JOIN data_sci.company_departments cd
ON e.department_id = cd.id
WHERE e.salary > 120000;


-- Creating emails for each user
SELECT
	concat(e.id, '-', e.last_name, '@work.com')
FROM data_sci.employees e;


--Improving email format by only taking the first 5 letters of the last name and changing the order.
SELECT concat(substring(e.last_name, 1, 5),'-', e.id, '@work.com')
FROM data_sci.employees e;


-- Retrieving all job titles with assistance in them
SELECT *
FROM(
	SELECT *, UPPER(job_title) as job --subquery creates formatted job title column 
	FROM data_sci.employees)
WHERE job like '%ASSISTANT%';



--retrieving each record of employees with thier average department salary
SELECT
	e1.last_name,
	e1.salary,
	e1.department_id,
	(SELECT AVG(e2.salary) FROM data_sci.employees e2 WHERE e2.department_id = e1.department_id)
FROM data_sci.employees e1;

--Same query as above but improving time efficiency and readability
SELECT
	last_name,
	salary,
	department_id,
	AVG(ROUND(salary, 2)) OVER (PARTITION BY department_id)
FROM data_sci.employees;


--Find the department with the employee with the highest salary
SELECT e.department_id, cd.department_name 
FROM data_sci.employees e
INNER JOIN data_sci.company_departments cd
ON e.department_id = cd.id
WHERE salary = 
	(SELECT max(salary)
	FROM data_sci.employees);






