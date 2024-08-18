use humanmanagerment ; 
alter table employees add foreign key employees (departmentID) references department(departmentID);
alter table employees add foreign key employees (managerID) references employees(employeeID);

select * from employees where managerid not in ( select employeeid from employees);
update employees set managerId = NULL where employeeid = 888;