--Using rollup for multiple aggergations and totals
SELECT
	cr.country_name,
	cr.region_name,
	count(e.*)
FROM data_sci.employees e
JOIN data_sci.company_regions cr
ON e.region_id = cr.id
GROUP BY ROLLUP(country_name, region_name);


--Count of employees in departments where the total salary paid in that 
--department is greater that 5
SELECT
	SUM(salary),
	Count(*),
	department_id
FROM data_sci.employees 
GROUP BY department_id
HAVING SUM(salary) > 5000000
ORDER BY SUM(salary) desc;


--Returning employee information and the min salary by department
SELECT
	last_name,
	job_title,
	department_id,
	salary,
	Min(salary) OVER(PARTITION BY department_id ORDER BY salary) as min_salary_by_department
FROM data_sci.employees


--Looking at the second highest salary relative to the rest of the department
SELECT
	department_id,
	salary,
	nth_value(salary, 2) Over (PARTITION BY department_id ORDER BY salary desc)
FROM data_sci.employees
	

--Ranking salary for employees from highest to lowest
SELECT
	last_name,
	department_id,
	salary,
	RANK() OVER (ORDER BY salary desc)
FROM data_sci.employees


--Looking at the salary gap between each employee and the empolyee with the closes salary to them
--Showing the largest disparities in pay gaps
SELECT e2.*,
	e2.salary - e2.next_salary as salary_gap
FROM
	(SELECT
		last_name,
		department_id,
		salary,
		LEAD(salary, 2) OVER (PARTITION BY department_id ORDER BY salary desc) as next_salary
	FROM data_sci.employees) e2
ORDER BY salary_gap DESC




	