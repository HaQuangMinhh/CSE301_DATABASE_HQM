use humanmanagerment ; 


-- Creating constraint for database:


-- 1. Check constraint to value of gender in “Nam” or “Nu”.
alter table employees 
add constraint check_gender Check ( gender in ( "Nam" , "Nu") ) ; 


-- 2. Check constraint to value of salary > 0.
alter table employees 
add constraint check_salary Check ( salary > 0 ) ; 



-- 3. Check constraint to value of relationship in Relative table in “Vo chong”, “Con trai”, “Con 
-- gai”, “Me ruot”, “Cha ruot”. 
alter table relative 
add constraint check_relative Check ( relationship in ( 'Vo chong', 'Con trai', 'Con gai' , 'Me ruot', 'Cha ruot' )); 


-- SQL 
-- 1. Look for employees with salaries above 25,000 in room 4 or employees with salaries above 
-- 30,000 in room 5.
select * from employees 
where ( salary > 25000 and departmentID = 4 ) or ( salary > 30000 and departmentID = 5 ); 

-- 2. Provide full names of employees in HCM city.
select * from employees ;

select concat( lastName, ' ',middleName, ' ',firstName) as FullName from employees 
where address like '%TPHCM%';


-- 3. Indicate the date of birth of Dinh Ba Tien staff.
select dateOfBirth from employees 
where concat( lastName, ' ',middleName, ' ',firstName) = 'Dinh Ba Tien';


-- 4. The names of the employees of Room 5 are involved in the "San pham X" project and this 
-- employee is directly managed by "Nguyen Thanh Tung".
select * from employees ; 
select * from Projects ; 



-- 5. Find the names of department heads of each department.
select * from employees ; 

select de.departmentName , em.lastName , em.middleName , em.firstName from employees em 
inner join department de on em.managerID = de.managerID ; 


-- 6. Find projectID, projectName, projectAddress, departmentID, departmentName,
-- departmentID, date0fEmployment.
select pro.projectID , pro.projectName , pro.projectAddress, de.departmentID , de.departmentName , 
de.departmentID , de.dateofemployment from projects pro
inner join department de on de.departmentID = pro.departmentID ; 


-- 7. Find the names of female employees and their relatives
select concat( em.lastname, '', em.middleName, '',em.firstName ) as FullName , re.relativeName from employees em
inner join relative re on em.employeeID = re.employeeID 
where em.gender = 'Nu' ; 


-- 8. For all projects in "Hanoi", list the project code (projectID), the code of the project lead 
-- department (departmentID), the full name of the manager (lastName, middleName, 
-- firstName) as well as the address (Address) and date of birth (date0fBirth) of the 
-- Employees.
SELECT p.projectID, p.departmentID, 
       CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName, 
       e.address, e.dateOfBirth
FROM PROJECTS p
JOIN DEPARTMENT d ON p.departmentID = d.departmentID
JOIN EMPLOYEES m ON d.managerID = m.employeeID
JOIN EMPLOYEES e ON e.departmentID = p.departmentID
WHERE p.projectAddress LIKE '%Hanoi%';



-- 9. For each employee, include the employee's full name and the employee's line manager.
SELECT e.employeeID, 
       CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName, 
       CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName
FROM EMPLOYEES e
LEFT JOIN EMPLOYEES m ON e.managerID = m.employeeID;


-- 10. For each employee, indicate the employee's full name and the full name of the head of the 
-- department in which the employee works.
SELECT e.employeeID, 
       CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName,
       CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS departmentHeadName
FROM EMPLOYEES e
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN EMPLOYEES m ON d.managerID = m.employeeID;


-- 11. Provide the employee's full name (lastName, middleName, firstName) and the names of 
-- the projects in which the employee participated, if any.
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS employeeName, 
       p.projectName
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID;


-- 12. For each scheme, list the scheme name (projectName) and the total number of hours 
-- worked per week of all employees attending that scheme.
SELECT p.projectName, SUM(a.workingHour) AS totalHoursWorked
FROM PROJECTS p
JOIN ASSIGNMENT a ON p.projectID = a.projectID
GROUP BY p.projectName;



-- 13. For each department, list the name of the department (departmentName) and the average 
-- salary of the employees who work for that department.
SELECT d.departmentName, AVG(e.salary) AS averageSalary
FROM DEPARTMENT d
JOIN EMPLOYEES e ON d.departmentID = e.departmentID
GROUP BY d.departmentName;


-- 14. For departments with an average salary above 30,000, list the name of the department and 
-- the number of employees of that department.
SELECT d.departmentName, COUNT(e.employeeID) AS numberOfEmployees
FROM DEPARTMENT d
JOIN EMPLOYEES e ON d.departmentID = e.departmentID
GROUP BY d.departmentName
HAVING AVG(e.salary) > 30000;

-- 15. Indicate the list of schemes (projectID) that has: workers with them (lastName) as 'Dinh' 
-- or, whose head of department presides over the scheme with them (lastName) as 'Dinh'.
SELECT DISTINCT p.projectID
FROM PROJECTS p
LEFT JOIN ASSIGNMENT a ON p.projectID = a.projectID
LEFT JOIN EMPLOYEES e ON a.employeeID = e.employeeID
LEFT JOIN DEPARTMENT d ON p.departmentID = d.departmentID
LEFT JOIN EMPLOYEES m ON d.managerID = m.employeeID
WHERE e.lastName = 'Dinh'
   OR m.lastName = 'Dinh';


-- 16. List of employees (lastName, middleName, firstName) with more than 2 relatives.
SELECT e.lastName, e.middleName, e.firstName
FROM EMPLOYEES e
JOIN RELATIVE r ON e.employeeID = r.employeeID
GROUP BY e.employeeID, e.lastName, e.middleName, e.firstName
HAVING COUNT(r.relativeName) > 2;


-- 17. List of employees (lastName, middleName, firstName) without any relatives.
SELECT e.lastName, e.middleName, e.firstName
FROM EMPLOYEES e
LEFT JOIN RELATIVE r ON e.employeeID = r.employeeID
WHERE r.employeeID IS NULL;


-- 18. List of department heads (lastName, middleName, firstName) with at least one relative.
SELECT DISTINCT m.lastName, m.middleName, m.firstName
FROM EMPLOYEES m
JOIN DEPARTMENT d ON m.employeeID = d.managerID
JOIN RELATIVE r ON m.employeeID = r.employeeID;


-- 19. Find the surname (lastName) of unmarried department heads.
SELECT DISTINCT m.lastName
FROM EMPLOYEES m
JOIN DEPARTMENT d ON m.employeeID = d.managerID
JOIN RELATIVE r ON m.employeeID = r.employeeID
WHERE r.relationship not like 'Vo chong';


-- 20. Indicate the full name of the employee (lastName, middleName, firstName) whose salary 
-- is above the average salary of the "Research" department.
SELECT CONCAT(e.lastName, ' ', e.middleName, ' ', e.firstName) AS fullName
FROM EMPLOYEES e
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM EMPLOYEES e2
    JOIN DEPARTMENT d2 ON e2.departmentID = d2.departmentID
    WHERE d2.departmentName = 'Nghien cuu' );


-- 21. Indicate the name of the department and the full name of the head of the department with 
-- the largest number of employees.
SELECT d.departmentName, CONCAT(m.lastName, ' ', m.middleName, ' ', m.firstName) AS managerName
FROM DEPARTMENT d
JOIN EMPLOYEES m ON d.managerID = m.employeeID
JOIN (
    SELECT departmentID, COUNT(employeeID) AS numEmployees
    FROM EMPLOYEES
    GROUP BY departmentID
    ORDER BY numEmployees DESC
    LIMIT 1
) dept_max ON d.departmentID = dept_max.departmentID;


-- 22. Find the full names (lastName, middleName, firstName) and addresses (Address) of 
-- employees who work on a project in 'HCMC' but the department they belong to is not 
-- located in 'HCMC'.
SELECT DISTINCT e.lastName, e.middleName, e.firstName, e.address
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN DEPARTMENTADDRESS da ON d.departmentID = da.departmentID
WHERE p.projectAddress LIKE '%TPHCM%'
  AND da.address NOT LIKE '%TPHCM%';


-- 23. Find the names and addresses of employees who work on a scheme in a city but the 
-- department to which they belong is not located in that city.
SELECT DISTINCT e.lastName, e.middleName, e.firstName, e.address
FROM EMPLOYEES e
JOIN ASSIGNMENT a ON e.employeeID = a.employeeID
JOIN PROJECTS p ON a.projectID = p.projectID
JOIN DEPARTMENT d ON e.departmentID = d.departmentID
JOIN DEPARTMENTADDRESS da ON d.departmentID = da.departmentID
WHERE p.projectAddress LIKE '%' || (SELECT DISTINCT SUBSTRING(p.projectAddress, LOCATE(',', p.projectAddress) + 1) FROM PROJECTS p WHERE p.projectID = a.projectID) || '%'
  AND da.address NOT LIKE '%' || (SELECT DISTINCT SUBSTRING(p.projectAddress, LOCATE(',', p.projectAddress) + 1) FROM PROJECTS p WHERE p.projectID = a.projectID) || '%';


-- 24. Create procedure List employee information by department with input data 
-- departmentName.
DELIMITER //
CREATE PROCEDURE ListEmployeeInfoByDepartment(IN deptName VARCHAR(255))
BEGIN
    SELECT e.lastName, e.middleName, e.firstName, e.address
    FROM EMPLOYEES e
    JOIN DEPARTMENT d ON e.departmentID = d.departmentID
    WHERE d.departmentName = deptName;
END //
DELIMITER ;


-- 25. Create a procedure to Search for projects that an employee participates in based on the 
-- employee's last name (lastName).
DELIMITER //
CREATE PROCEDURE SearchProjectsByEmployeeLastName(IN empLastName VARCHAR(255))
BEGIN
    SELECT p.projectID, p.projectName, p.projectAddress
    FROM PROJECTS p
    JOIN ASSIGNMENT a ON p.projectID = a.projectID
    JOIN EMPLOYEES e ON a.employeeID = e.employeeID
    WHERE e.lastName = empLastName;
END //
DELIMITER ;

-- 26. Create a function to calculate the average salary of a department with input data 
-- departmentID.
DELIMITER //
CREATE FUNCTION GetAverageSalary(deptID INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE avgSalary DECIMAL(10, 2);
    
    SELECT AVG(salary) INTO avgSalary
    FROM EMPLOYEES
    WHERE departmentID = deptID;
    
    RETURN avgSalary;
END //
DELIMITER ;



-- 27. Create a function to Check if an employee is involved in a particular project input data is 
-- employeeID, projectID
DELIMITER //
CREATE FUNCTION IsEmployeeInProject(empID INT, projID INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE isInvolved BOOLEAN;
    
    SELECT CASE
               WHEN COUNT(*) > 0 THEN TRUE
               ELSE FALSE
           END INTO isInvolved
    FROM ASSIGNMENT
    WHERE employeeID = empID AND projectID = projID;
    
    RETURN isInvolved;
END //
DELIMITER ;

