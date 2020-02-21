SELECT department_name FROM 
  (SELECT AVG(salary) AS avg_salary, department_name 
  FROM employees 
  INNER JOIN salaries 
  ON employees.employee_id = salaries.employee_id 
  GROUP BY department_name) AS avg_salary_per_department
  WHERE avg_salary < 500;
