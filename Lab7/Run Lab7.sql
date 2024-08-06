use copy_salemanagerment ; 

-- 1. SQL statement returns the cities (only distinct values) from both the "Clients" and the "salesman" 
-- table.
select city from clients 
union 
select city from salesman ; 

-- 2. SQL statement returns the cities (duplicate values also) both the "Clients" and the "salesman" table.
select city from clients 
union all 
select city from salesman ; 

-- 3. SQL statement returns the Ho Chi Minh cities (only distinct values) from the "Clients" and the 
-- "salesman" table.
select client_name from clients
where city = 'Ho Chi Minh' 
union 
select salesman_name from salesman 
where city = 'Ho Chi Minh' ; 

-- 4. SQL statement returns the Ho Chi Minh cities (duplicate values also) from the "Clients" and the 
-- "salesman" table.
select client_name from clients 
where city = 'Ho Chi Minh'
union all 
select salesman_name from salesman 
where city = 'Ho Chi Minh'; 

-- 5. SQL statement lists all Clients and salesman.
select client_name as 'name', 'client' as `type` from clients 
union 
select salesman_name as 'name' , 'salesman' as `type` from salesman ; 


-- 6. Write a SQL query to find all salesman and clients located in the city of Ha Noi on a table with 
-- information: ID, Name, City and Type.
select Pincode , salesman_name as 'name' , city , address, 'salesman' as `type` from salesman 
where city = 'Hanoi'
union 
select Pincode , client_name as 'name' , city , address, 'clients' as `type` from clients 
where city = 'Hanoi';

select * from clients ; 

-- 7. Write a SQL query to find those salesman and clients who have placed more than one order. Return 
-- ID, name and order by ID.
select * from salesman ; 
select * from salesorder ; 
select * from salesorderdetails ; 

select * from 
	( select sm.salesman_number as ID , sm.salesman_name as `Name` , 'Salesman' as `Type` 
	from salesman sm inner join salesorder sod on sm.salesman_number = sod.salesman_number 
	group by sm.salesman_number 
	having count(*) > 1 
	Union 
	select c.client_number as ID , c.client_name as `Name` , 'Client' as `Type` 
	from clients c inner join salesorder sod on c.client_number = sod.client_number 
	group by c.client_number 
	having count(*) > 1 ) as T 
Order by ID ;  
   
  
-- 8. Retrieve Name, Order Number (order by order number) and Type of client or salesman with the client 
-- names who placed orders and the salesman names who processed those orders.
select c.client_name , sod.order_number , sm.salesman_number from clients c 
inner join salesorder sod on c.client_number = sod.client_number
inner join salesman sm on sm.salesman_number = sod.salesman_number 
order by order_number ; 

-- 9. Write a SQL query to create a union of two queries that shows the salesman, cities, and 
-- target_Achieved of all salesmen. Those with a target of 60 or greater will have the words 'High 
-- Achieved', while the others will have the words 'Low Achieved'.

select * from salesman ; 
select salesman_number, salesman_name , city , target_achieved ,
	case when target_achieved > 60 then 'High Achieved' end 'Mark' from salesman  
    where target_achieved > 60 
Union 
select salesman_number , salesman_name , city , target_achieved , 
	case when target_achieved < 60 then 'Low Achieved' end 'Mark' from salesman 
    where target_achieved < 60  ; 


-- 10. Write query to creates lists all products (Product_Number AS ID, Product_Name AS Name, 
-- Quantity_On_Hand AS Quantity) and their stock status. Products with a positive quantity in stock are 
-- labeled as 'More 5 pieces in Stock'. Products with zero quantity are labeled as ‘Less 5 pieces in Stock'
select * from product ; 

select Product_number as ID , Product_name as Name , Quantity_on_hand as Quantity , 
case when quantity_on_hand > 0 then 'More 5 pieces in Stock' else 
'Less 5 pieces in stock' end 'Stock Status' 
from product ;  

-- B . store procedures 

-- 11. Create a procedure stores get_clients _by_city () saves the all Clients in table. Then Call procedure 
-- stores.

delimiter $$
create procedure get_clients_by_city ( in Cityin varchar(30) )
begin 
	select * 
    from clients 
    where city = Cityin ; 
end 
$$ delimiter ; 

call get_clients_by_city("Hanoi");

-- 12. Drop get_clients _by_city () procedure stores.
drop procedure get_clients_by_city ;

-- 13. Create a stored procedure to update the delivery status for a given order number. Change value 
-- delivery status of order number “O20006” and “O20008” to “On Way”.

delimiter $$ 
	create procedure Update_status ()
    begin 
		update salesorder set delivery_status = 'On Way' 
        where order_number = '020006' or order_number = '020008' ; 
	end 
$$ delimiter ; 

call Update_status;
drop procedure Update_status ;  



-- 14. Create a stored procedure to retrieve the total quantity for each product.
select * from product ; 

-- xem lai 
delimiter $$ 
create procedure Total_quantity ( in Quantity int ) 
begin 
	select * from product where total_quantity = Quantity ; 
end
$$ delimiter 


delimiter $$ 
create procedure Quantity_ne() 
begin 
	select product_number , product_name , total_quantity from product ;
end 
$$ delimiter ; 

call Quantity_ne ; 
drop procedure Quantity_ne ; 


-- 15. Create a stored procedure to update the remarks for a specific salesman.
select * from salesman ; 

delimiter $$ 
create procedure Update_remarks( in sm_ID varchar(15) , in sm_Achievement varchar(255) ) 
begin 
	update salesman set Achievement = sm_Achievement 
    where salesman_number = sm_ID ; 
end 
$$ delimiter ; 

call Update_remarks('S005' , 'Bad') ; 


-- 16. Create a procedure stores find_clients() saves all of clients and can call each client by client_number.

select * from clients ; 

-- nhap
delimiter $$ 
	create procedure find_clients () 
	begin 
		select * from clients ; 
	end 
$$ delimiter 

Call find_clients ; 
drop procedure find_clients ; 
-- day ne 
delimiter $$ 
	create procedure find_clients ( in C_number varchar(15) )
    begin 
		select * from clients 
        where client_number = C_number ; 
	end 
$$ delimiter 

Call find_clients('C105') ; 


-- 17. Create a procedure stores salary_salesman() saves all of clients (salesman_number, salesman_name, 
-- salary) having salary >15000. Then execute the first 2 rows and the first 4 rows from the salesman 
-- table.

select * from salesman ;
delimiter $$ 
	create procedure salary_salesman( in show_salary INT ) 
    begin 
		select salesman_number , salesman_name , salary from salesman 
        group by salesman_number  
        having salary > 15000
        limit show_salary ; 
	end
$$ delimiter 

call salary_salesman(3);

drop procedure salary_salesman;

-- 18. Procedure MySQL MAX() function retrieves maximum salary from MAX_SALARY of salary table.

select * from salesman ; 

delimiter $$ 
	create procedure MySQL ( ) 
    begin 
		select salesman_number , salesman_name , salary from salesman 
        order by salary DESC 
        limit 1 ; 
	end
$$ delimiter ;

call MySQL() ;
drop procedure MySQL ; 


-- 19. Create a procedure stores execute finding amount of order_status by values order status of salesorder 
-- table

delimiter $$ 
	create procedure find_status() 
		begin 
        select Order_status , count(*) from salesorder 
        group by Order_Status ; 
        end 
$$ delimiter 



-- 21. Count the number of salesman with following conditions : SALARY < 20000; SALARY > 20000; 
-- SALARY = 20000.

delimiter $$ 
	create procedure count_salary() 
    begin 
    select 'SALARY < 20000' as 'TYPE' , count(*) as 'Number Of Salesman' from salesman 
    where salary < 20000
    
    union all 
    select 'SALARY = 20000' as 'TYPE' , count(*) as 'Number Of Salesman' from salesman 
    where salary = 20000
    
    union all 
    select 'SALARY > 20000' as 'TYPE' , count(*) as 'Number Of Salesman' from salesman 
    where salary > 20000 ; 
    end
$$ delimiter ; 

call count_salary ; 

-- 22. Create a stored procedure to retrieve the total sales for a specific salesman.

delimiter $$
	create procedure total_sales ( in smID varchar(15) , out totalsales int ) 
    
    begin 
    select sum(order_quantity) into totalsales 
    from salesorder as so, salesorderdetails sod 
    where so.order_number = sod.order_number and so.salesman_Number = smID ; 
    end 
$$ delimiter ; 
set @totalsales  = 0 ; 
call total_sales('S001' , @totalsales) ; 




-- 23. Create a stored procedure to add a new product:
-- Input variables: Product_Number, Product_Name, Quantity_On_Hand, Quantity_Sell, Sell_Price, 
-- Cost_Price.
delimiter $$
	create procedure add_new_product(in p_number varchar(15), in p_name varchar(25), in p_quantity_on_hand int,
									in p_quantity_sell int, in p_sell_price decimal(15,4), in p_cost_price decimal(15.4))
	begin
    insert into product value (p_number,p_name,p_quantity_on_hand,p_quantity_sell,p_sell_price,p_cost_price);
    end
$$ delimiter ;

