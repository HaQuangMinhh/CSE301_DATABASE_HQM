use SaleManagerment ; 
show tables ; 

--  1. Show the all-clients details who lives in “Binh Duong”
select * from clients where Province = 'Binh Duong'; 

-- 2. Find the client’s number and client’s name who do not live in “Hanoi”.
select client_number , client_name from clients where Province <> 'Hanoi';
-- or
select * from clients where Province <> 'Hanoi';

-- 3. Identify the names of all products with less than 25 in stock.
select * from product where Quantity_On_Hand < '25';

-- 4. Find the product names where company making losses. 
select * from product where Sell_Price < cost_price ;  

-- 5. Find the salesman’s details who are able achieved their target.
select * from salesman where Target_Achieved >= Sales_Target ; 

-- 6. Select the names and city of salesman who are not received salary between 10000 and 17000
select salesman_name , city, salary from salesman where salary NOT BETWEEN 10000 and 17000 ;

-- 7. Show order date and the clients_number of who bought the product between '2022-01-01' and 
-- '2022-02-15'.
select Order_Date , Client_Number from salesorder where Order_Date between '2022-01-01' and '2022-02-15' ; 

-- Question B 
-- 8.  Find the names of cities in clients table where city name starts with "N"
select city from clients where city like 'T%';    -- starts at T

-- 9. Display clients’ information whose names have "u" in third position.
select * from clients where client_name like '__u%';

-- 10. Find the details of clients whose names have "u" in second last position.
select * from clients where client_name like '%u_';

-- 11. Find the names of cities in clients table where city name starts with "D" and ends with “n”
select city from clients where client_name like 'D%n';

-- 12. . Select all clients details who belongs from Ho Chi Minh, Hanoi and Da Lat.
select * from clients where city in ('Ho Chi Minh' , 'Hanoi' , 'Da lat');

-- 13.  Choose all clients data who do not reside in Ho Chi Minh, Hanoi and Da Lat.
select * from clients where city not in ('Ho Chi Minh' , 'Hanoi' , 'Da Lat');

-- Question C 

-- 14. Find the average salesman’s salary. 
select avg(salary) from salesman ;

-- 15. Find the name of the highest paid salesman.
select max(salary) from salesman ;
select salesman_name from salesman where salary = ( select max(salary) from salesman );

-- 16. Find the name of the salesman who is paid the lowest salary.
select salesman_name from salesman where salary = ( select min(salary) from salesman );  	-- truy van long

-- 17. Determine the total number of salespeople employed by the company
select count(salesman_name) from salesman ; 

-- 18. . Compute the total salary paid to the company's salesman
select sum(salary) from salesman ; 

-- Using Order by keyword, limit clause

-- 19. Select the salesman’s details sorted by their salary.
select * from salesman order by salary DESC ; 
select * from salesman order by salary ASC ; 

-- 20. Display salesman names and phone numbers based on their target achieved (in ascending order) 
-- and their city (in descending order).
select salesman_name , phone , city from salesman order by Target_Achieved ASC , city DESC ; 

-- 21. Display 3 first names of the salesman table and the salesman’s names in descending order
select salesman_name 
from salesman 
order by Salesman_Name DESC 
limit 3; 

-- 22. Find salary and the salesman’s names who is getting the highest salary.
select salesman_name 
from salesman where salary = ( select max(salary) from salesman ) ;

-- 23. Find salary and the salesman’s names who is getting second lowest salary
select salary , salesman_name from salesman order by salary ASC limit 1 offset 1 ; 

-- 24. Display the first five sales orders in formation from the sales order table.
select * from salesorder limit 5 ; 

-- 25. Display next ten sales order information from sales order table except first five sales order.
select * from salesorder limit 10 offset 5 ; 

-- 26. If there are more than one client, find the name of the province and the number of clients in each 
-- province, ordered high to low.
		-- Kết hợp Group by and Having 
select province , count(*) totalclient
from clients
group by province
having count(*) > 1
order by count(*) DESC ;   

-- 27. Display information clients have number of sales order more than 1.
select * from clients where Client_Number in ( select client_number 
from salesorder   
group by Client_Number 
having count(*) >1 ) ; 

-- 		Practice to grade
-- 28. Display the name and due amount of those clients who lives in “Hanoi”.
select client_name , amount_due from clients where city = 'Hanoi';

-- 29. Find the clients details who has due more than 3000.
select * from clients where Amount_Due > 3000 ; 

-- 30. Find the clients name and their province who has no due.
select client_name, province from clients where Amount_Due = 0 ;  

-- 31. Show details of all clients paying between 10,000 and 13,000.
select * from clients where amount_paid between 10000 and 13000;

-- 32. Find the details of clients whose name is “Dat”.
select * from clients where client_name = 'Dat';

-- 33. Display all product name and their corresponding selling price. 
select product_name , sell_price from product ;

-- 34. How many TVs are in stock
select * from product ; 
select product_name , quantity_on_hand from product where product_name in ('TV');  

-- 35. Find the salesman’s details who are not able achieved their target.
select * from salesman ; 
select * from salesman where Sales_Target > Target_Achieved ;

-- 36. Show all the product details of product number ‘P1005’
select * from product where Product_Number = 'P1005' ;  

-- 37. Find the buying price and sell price of a Mouse.
select * from product ; 
select product_name , sell_price, cost_price from product where product_name = 'mouse' ; 

-- 38. Find the salesman names and phone numbers who lives in Thu Dau Mot
select salesman_name , phone from salesman where city = 'Thu Dau Mot' ; 

-- 39. Find all the salesman’s name and salary.
select salesman_name , salary from salesman ; 

-- 40. Select the names and salary of salesman who are received between 10000 and 17000.
select salesman_name , salary from salesman where salary between 10000 and 17000; 

-- 41. Display all salesman details who are received salary between 10000 and 20000 and achieved 
-- their target.
	select * from salesman where salary between 10000 and 20000 and Target_Achieved >= sales_target  ; 
    
-- 42. Display all salesman details who are received salary between 20000 and 30000 and not achieved 
-- their target. 
select * from salesman where salary between 20000 and 30000 and Target_Achieved <= sales_target  ; 

-- 43. Find information about all clients whose names do not end with "h".
select * from clients where client_name not like '%h';

-- 44. Find client names whose second letter is 'r' or second last letter 'a'.
select client_name from clients where client_name like '_r%' or '%a_' ;  

-- 45. Select all clients where the city name starts with "D" and at least 3 characters in length.
select * from clients where city like 'D%' and length(city) >= 3 ;  

-- 46. Select the salesman name, salaries and target achieved sorted by their target_achieved in 
-- descending order.
select salesman_name , salary , target_achieved from salesman order by target_achieved DESC;  

-- 47. Select the salesman’s details sorted by their sales_target and target_achieved in ascending order.
select * from salesman order by Sales_Target and Target_Achieved ASC ; 

-- 48. Select the salesman’s details sorted ascending by their salary and descending by achieved target.
select * from salesman order by salary ASC , Target_Achieved DESC ; 

-- 49. Display salesman names and phone numbers in descending order based on their sales target.
select salesman_name , phone from salesman order by Sales_Target DESC ; 

-- 50. Display the product name, cost price, and sell price sorted by quantity in hand.
select product_name, cost_price , sell_price from product order by quantity_on_hand DESC ; 

-- 51. Retrieve the clients’ names in ascending order
select * from clients order by client_name ASC ; 

-- 52. Display client information based on order by their city.
select * from clients order by city ; 

-- 53. Display client information based on order by their address and city
select * from clients order by address and city ; 

-- 54. Display client information based on their city, sorted high to low based on amount due
select * from clients order by amount_due DESC ; 

-- 55. Display the data of sales orders depending on their delivery status from the current date to the 
-- old date
select * from salesorder order by Delivery_Status DESC , Order_Date DESC ; 

-- 56. Display last five sales order in formation from sales order table
select * from salesorder order by order_date limit 5 ; 

-- 57. Count the pincode in client table.
select count(pincode) as total_pincodes from clients ;  

-- 58. How many clients are living in Binh Duong
select count(client_number) as totalClients from clients where province like 'Binh Duong' ; 

-- 59. Count the clients for each province.
select count(*) , province from clients group by province ; 

-- 60. If there are more than three clients, find the name of the province and the number of clients in each 
-- province.
select province , count(*) NumberClient from clients 
group by province 
Having count(*) > 3 ; 


-- 61. Display product number and product name and count number orders of each product more than 1 
-- (in ascending order)
-- select * from product ;

select product.product_number , product_name 
from product inner join salesorderdetails on product.product_number = salesorderdetails.product_number
group by product.product_number
having count(*) > 1 
order by count(*) ASC ;  
 

-- 62. Find products which have more quantity on hand than 20 and less than the sum of average
select * from product where quantity_on_hand > 20 and Quantity_On_Hand < (select AVG(Quantity_On_Hand) from product ) ; 












 



 





















 


