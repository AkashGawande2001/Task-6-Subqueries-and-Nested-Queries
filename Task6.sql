create  Database Task6

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT
);

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO employees (emp_id, emp_name, dept_id, salary) VALUES
(101, 'Akash', 1, 40000),
(102, 'Ketan', 2, 60000),
(103, 'Ravi', 2, 55000),
(104, 'Mayank', 3, 70000),
(105, 'Vaibhav', 4, 45000),
(106, 'Samarth', 3, 65000),
(107, 'Arjun', 1, 38000);

-- Show employee name with department name
SELECT e.emp_name,
       (SELECT d.dept_name 
        FROM departments d 
        WHERE d.dept_id = e.dept_id) AS department
FROM employees e;

-- Employees earning more than average salary
SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Departments with average salary > 50,000
SELECT dept_id, avg_salary
FROM (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
) AS dept_avg
WHERE avg_salary > 50000;

-- Employees earning more than their department’s average
SELECT emp_name, salary, dept_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE dept_id = e.dept_id
);

-- Departments that have employees
SELECT dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);