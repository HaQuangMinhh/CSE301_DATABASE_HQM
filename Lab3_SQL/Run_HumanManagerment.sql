use HumanManagerment ; 
show tables ; 

select * from assignment ; 
select * from department ; 

-- đã nhập dữ liệu 
-- dòng check lỗi 
select * from employees where managerID not in (select employeeID from employees);

-- dòng thiếu dữ liệu hoặc thay đổi dữ liệu 
update employees set managerID = NULL where managerID = '';

alter table employees add foreign key employees (managerID) references employees(employeeID); 

