use Copy_SaleManagerment ; 
show tables ; 

-- Update dữ liệu 
insert into salesman values
('S007','Quang','Chanh My','Da Lat',700032,'Lam Dong',25000,90,95,'0900853487'),
('S008','Hoa','Hoa Phu','Thu Dau Mot',700051,'Binh Duong',13500,50,75,'0998213659') ; 

insert into salesorder values 
('O20015','2022-05-12','C108','S007','On Way', '2022-05-15','Successful'),
('O20016','2022-05-16','C109','S008','Ready to Ship',null,'In Process');

insert into salesorderdetails values 
('O20015','P1008',15),
('O20015','P1007',10),
('O20016','P1007',20) ,
('O20016','P1003',5) ;

-- I .  Using Joining table to combine rows from more tables. (NATURAL JOIN, INNER JOIN, LEFT JOIN, 
-- RIGHT JOIN, CROSS JOIN, SEFT JOIN)

-- 1. Display the clients (name) who lives in same city.
-- truy vấn lòng cho câu 1 
select * from clients where city in ( select city 
from clients
group by city 
having count(*) >= 2 ) ; 

-- Sử dụng kết cho cho câu 1 =
select * from clients a inner join clients b on a.city = b.city and a.client_name <> b.client_name ; 

-- 2. Display city, the client names and salesman names who are lives in “Thu Dau Mot” city.
select distinct salesman.City , clients.Client_Name , salesman.Salesman_Name from salesman  
inner join clients on clients.city = salesman.city where clients.city = 'Thu Dau Mot' ;  

select * from salesman ; 
select * from clients ; 

-- 3. Display client name, client number, order number, salesman number, and product number for each 
-- order
-- có 3 bảng 
select c.client_name , sa.client_number , sa.order_number, sa.salesman_number , sod.product_number from salesorder sa 
inner join salesorderdetails sod on sa.order_number = sod.order_number
inner join clients c on sa.client_number = c.client_number ; 

-- 4. Find each order (client_number, client_name, order_number) placed by each client. 
select c.client_number , c.client_name , sod.order_number from clients c 
inner join salesorder sod on c.Client_Number = sod.client_number 
order by c.Client_number ; 


-- 5.Display the details of clients (client_number, client_name) and the number of orders which is paid by 
-- them
select * from salesorder ; 

select c.client_number, c.client_name , Count(sod.order_number) from clients c 
inner join salesorder sod on c.client_number = sod.client_number
where sod.order_number in ( select order_number from salesorder where order_status = 'Successful')
Group by c.client_number ; 

-- 6. Display the details of clients (client_number, client_name) who have paid for more than 2 orders. 
select c.client_number,  c.client_name , count(sod.order_number) from clients c 
inner join salesorder sod on c.client_number = sod.client_number 
where sod.order_number in ( select order_number from salesorder where order_status = 'Successful') 
group by c.client_number 
having count(sod.order_number) > 1 ; 

-- 7. Display details of clients who have paid for more than 1 order in descending order of client_number.
select c.client_number , c.client_name , count(sod.order_number) from clients c 
inner join salesorder sod on c.client_number = sod.client_number
where sod.order_number in ( select order_number from salesorder where order_status = 'Successful')
group by c.client_number 
having count(sod.order_number) > 1
order by c.Client_Number DESC ; 

-- 8. Find the salesman names who sells more than 20 products.
select salesman_name from salesman s 
inner join salesorder sod on sod.Salesman_Number = s.Salesman_Number 
inner join salesorderdetails sodd on sod.Order_Number = sodd.Order_Number 
group by salesman_name 
having sum(order_quantity) > 20 ; 

-- 9. Display the client information (client_number, client_name) and order number of those clients who 
-- have order status is cancelled.
select c.client_number , c.client_name , sod.order_number from clients c 
inner join salesorder sod on c.client_number = sod.client_number 
where sod.order_number in ( select order_number from salesorder where order_status = 'Cancelled' );

-- 10. Display client name, client number of clients C101 and count the number of orders which were 
-- received “successful”.
select c.client_name, c.client_number , Count(sod.Order_Number) from clients c 
inner join salesorder sod on c.client_number = sod.client_number 
where sod.order_number in ( select order_number from salesorder where order_status = 'Successful')
group by c.Client_Number, c.Client_Name ;
 -- having c.client_number = 'C101' ;   --> dong nay show ra chỉ 1 dòng 
 
-- 11. Count the number of clients orders placed for each product
select * from salesorder ;
select * from salesorderdetails ;  

select pro.product_number, pro.product_name, count(sod.client_number) numberClients from salesorder sod
inner join salesorderdetails sodd on sodd.order_number = sod.order_number
inner join product pro on sodd.product_number = pro.product_number
group by sodd.product_number;


-- 12. Find product numbers that were ordered by more than two clients then order in descending by product 
-- number


select pro.product_number , count(sod.client_number) numberClients from salesorder sod 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number
group by sodd.product_number
having numberClients > 2 
order by pro.product_number DESC ; 


select product_number , count(*) from ( select distinct client_number , product_number from salesorderdetails sodd inner join 
salesorder sod on sodd.order_number = sod.order_number ) as T 
group by product_number 
order by product_number DESC ; 




-- 13. Find the salesman’s names who is getting the second highest salary.
select salesman_name , salary 
from salesman 
order by salary DESC 
limit 1 offset 1 ;

-- 14. Find the salesman’s names who is getting second lowest salary. 
select salesman_name , salary 
from salesman 
order by salary ASC   
limit 1 offset 1 ;

-- 15. Write a query to find the name and the salary of the salesman who have
-- a higher salary than the salesman whose salesman number is S001.  
select * from salesman ; 

select salesman_name , salary 
from salesman where salary > ( select salary from salesman where salesman_number = 'S001');
  
-- 16. Write a query to find the name of all salesman who sold the product has number: P1002.
select * from product ; 

select distinct sm.salesman_name , sm.salesman_number from salesman sm 
inner join salesorder sod on sm.salesman_number = sod.salesman_number 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
where sodd.product_number = 'P1002' ; 

-- 17. Find the name of the salesman who sold the product to
--  client C108 with delivery status is “delivered”.
select * from salesman ; 
select * from salesorder ; 

select sm.salesman_name, sm.salesman_number from salesman sm 
inner join salesorder sod on sm.salesman_number = sod.salesman_number
where client_number = 'C108';

-- C2
SELECT Salesman_Number, Salesman_Name from salesman
 WHERE Salesman_Number in ( SELECT Salesman_Number from salesorder
 WHERE Client_Number = 'C108');

-- 18. Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity equal 
-- to 5.
select * from salesman ; 
select * from salesorder ; 
select * from salesorderdetails ; 

select sodd.product_number , pro.product_name from salesorderdetails sodd 
inner join product pro on sodd.product_number = pro.product_number 
where sodd.order_quantity = '5' ; 
-- C2  
SELECT Product_Name from product
WHERE Product_Number in ( SELECT Product_Number from salesorderdetails WHERE Order_Quantity = 5);

-- 19. Write a query to find the name and number of the salesman who sold pen or TV or laptop.
select * from product ; 

select salesman_number , salesman_name from salesman 
where salesman_number in ( select distinct salesman_number from salesorder
where order_number in ( select order_number from salesorderdetails 
where product_number in ( select product_number from product 
where product_name in ('pen' , 'TV' , 'Laptop' )))) 
order by salesman_number; 

-- 20. Lists the salesman’s name sold product with a product price less than 800 and Quantity_On_Hand
-- more than 50.
select salesman_name , salesman_number from salesman 
where salesman_number in ( select distinct salesman_number from salesorder
where order_number in ( select order_number from salesorderdetails
where product_number in ( select product_number from product 
where cost_price < 800 and quantity_on_hand > 50 )))
order by salesman_number ;  

select sm.salesman_name , sm.salesman_number , pro.product_number from salesman sm 
inner join salesorder sod on sod.salesman_number = sm.salesman_number 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number 
where cost_price < 800 and quantity_on_hand > 50 
order by salesman_number;


-- 21. Write a query to find the name and salary of the salesman whose salary is greater than the average 
-- salary.
select salesman_name , salary from salesman 
where salary > ( select AVG(salary) from salesman ) ; 


-- 22. Write a query to find the name and Amount Paid of the clients whose amount paid is greater than the 
-- average amount paid.
select client_name , amount_paid from clients 
where amount_paid > ( select AVG(amount_paid) from clients ) ; 

-- 23. Find the product price that was sold to Le Xuan.
select * from product ;
select * from clients ; 

select product_name , sell_price from product 
where product_number in ( select product_number from salesorderdetails 
where order_number in ( select order_number from salesorder
where client_number in ( select client_number from clients 
where client_name = 'Le Xuan')));

-- C2 
select pro.product_name , pro.sell_price from product pro
inner join salesorderdetails sodd on pro.product_number = sodd.product_number 
inner join salesorder sod on sodd.order_number = sod.order_number
inner join clients c on sod.client_number = c.client_number 
where client_name = 'Le Xuan' ; 


-- 24. Determine the product name, client name and amount due that was delivered.
select * from clients ; 
select * from product ;

select pro.product_name , c.client_name , c.amount_due from clients c 
inner join salesorder sod on c.client_number = sod.client_number 
inner join salesorderdetails sodd on sod.order_number = sodd.order_number 
inner join product pro on pro.product_number = sodd.product_number 
where sod.delivery_status = 'delivered' ;


-- 25. Find the salesman’s name and their product name which is cancelled.
select sm.salesman_name , pro.product_name from salesman sm 
inner join salesorder sod on sm.salesman_number = sod.salesman_number
inner join salesorderdetails sodd on sod.order_number = sodd.order_number 
inner join product pro on pro.product_number = sodd.product_number 
where sod.order_status = 'Cancelled'; 


-- 26. Find product names, prices and delivery status for those products purchased by Nguyen Thanh.
select * from clients ; 

select pro.product_name , pro.sell_price , sod.delivery_status , c.client_name from salesorder sod 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number 
inner join salesman sm on sm.salesman_number = sod.salesman_number 
inner join clients c on c.client_number = sod.client_number 
where c.client_name = 'Nguyen Thanh ';


-- 27. Display the product name, sell price, salesperson name, delivery status, and order quantity information 
-- for each customer.
select pro.product_name , pro.sell_price , sm.salesman_name , sod.delivery_status , sodd.order_quantity from salesorder sod
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number 
inner join salesman sm on sod.salesman_number = sm.salesman_number ;



-- 28. Find the names, product names, and order dates of all sales staff whose product order status has been 
-- successful but the items have not yet been delivered to the client.
select sm.salesman_name , pro.product_name , sod.order_date , sod.order_status , sod.delivery_status from salesorder sod
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number 
inner join salesman sm on sod.salesman_number = sm.salesman_number 
where Order_status = 'Successful' and Delivery_status <> 'Delivered';

-- 29. Find each clients’ product which in on the way.
select c.client_name , pro.product_name , sod.delivery_status from salesorder sod 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number
inner join product pro on pro.product_number = sodd.product_number
inner join salesman sm on sm.salesman_number = sod.salesman_number
inner join clients c on c.client_number = sod.client_number
WHERE Delivery_Status = 'On Way';

-- 30. Find salary and the salesman’s names who is getting the highest salary.
select salesman_name , salary from salesman 
where salary in ( select max(salary) from salesman ) ;  



-- 31. Find salary and the salesman’s names who is getting second lowest salary.
select * from salesman ; 

select salesman_name , salary from salesman 
where salary = ( select Min(salary) from salesman 
where salary > ( select Min(salary) from salesman )) ; 

select salesman_name , salary from salesman 
order by salary ASC  
limit 1 offset 1 ; 

-- 32. Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity more 
-- than 9.
select product_name from product pro 
where exists (
	select * from salesorderdetails sodd 
    where pro.product_number = sodd.product_number and sodd.order_quantity > 9 
);


-- 33. Find the name of the customer who ordered the same item multiple times.
SELECT  c.Client_Name, p.Product_Name
from salesorder so INNER JOIN salesorderdetails sod
on sod.order_number = so.order_number
INNER JOIN product p
on p.product_number = sod.product_number
INNER JOIN clients c 
on c.client_number = so.client_number
GROUP BY c.client_name, p.product_name
HAVING COUNT(*) >1;


-- 34. Write a query to find the name, number and salary of the salemans who earns less than the average 
-- salary and works in any of Thu Dau Mot city.
SELECT Salesman_Name, Salesman_Number, Salary from salesman
WHERE Salary < ( SELECT AVG(salary) from salesman ) and city ='Thu Dau Mot';



-- 35. Write a query to find the name, number and salary of the salemans who earn a salary that is higher than 
-- the salary of all the salesman have (Order_status = ‘Cancelled’). Sort the results of the salary of the lowest to 
-- highest.
SELECT Salesman_Name, Salesman_Number, Salary from salesman
WHERE Salary > all (SELECT salary from salesman
WHERE Salesman_Number in (SELECT DISTINCT Salesman_Number from salesorder
WHERE Order_Status = 'Cancelled'));



-- 36. Write a query to find the 4th maximum salary on the salesman’s table.
SELECT * from salesman
ORDER BY Salary DESC
limit 4;


-- 37. Write a query to find the 3th minimum salary in the salesman’s table
SELECT * from salesman
ORDER BY Salary asc
limit 3;









   


