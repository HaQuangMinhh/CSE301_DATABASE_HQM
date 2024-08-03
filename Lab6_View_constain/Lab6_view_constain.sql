use copy_salemanagerment ; 
show tables ; 

-- 1. How to check constraint in a table ?
	SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	WHERE TABLE_NAME = 'salesman';

-- 2. Create a separate table name as “ProductCost” from “Product” table, which contains the information 
-- about product name and its buying price. 
	select * from product ; 
    
    create table ProductCost (
		Product_name varchar(255) NOT NULL, 
		Buying_price decimal(15,4) NOT NULL,
        Primary key (Product_name)
    );
    
    select * from ProductCost ; 
    
-- 3. Compute the profit percentage for all products. Note: profit = (sell-cost)/cost*100
select * from product ; 
alter table product add column profit float ; 

update product set profit = ( sell_price - cost_price ) / cost_price * 100 ; 


-- 4. If a salesman exceeded his sales target by more than equal to 75%, his remarks should be ‘Good’.
select * from salesman  ; 

alter table salesman add column Achievement varchar(255) ; 

update salesman set Achievement = case when target_achieved / sales_target >= 0.75 then 'Good' end ; 
								  

-- 5. If a salesman does not reach more than 75% of his sales objective, he is labeled as 'Average'.
select * from salesman ; 

update salesman set Achievement = case when target_achieved / sales_target >= 0.75 then 'Good' else
									'Average' end ; 
								  
-- 6. If a salesman does not meet more than half of his sales objective, he is considered 'Poor'.
select * from salesman ; 

update salesman set Achievement = case when target_achieved / sales_target >= 0.75 then 'Good' else
							      case when target_achieved / sales_target < 0.75 then 'Average' else 
                                  case when target_achieved / sales_target < 0.5 then 'Poor' end end end ; 
                                  
                                  
-- 7. Find the total quantity for each product. (Query)
select * from product ; 

select *  , ( Quantity_On_hand + Quantity_sell ) as Total_Quantity from product ; 

-- 8. Add a new column and find the total quantity for each product.

alter table product add column Total_Quantity int ; 

-- alter table product drop column Total_Quantity ; 
update product set Total_Quantity = quantity_on_hand + Quantity_sell ; 
 


-- 9. If the Quantity on hand for each product is more than 10, change the discount rate to 10 otherwise set to 5.
alter table product add column Discount_rate float ; 

update product set Discount_rate = case when quantity_on_hand > 10 then 10 else 5 end ; 
								   

-- 10. If the Quantity on hand for each product is more than equal to 20, change the discount rate to 10, if it is 
-- between 10 and 20 then change to 5, if it is more than 5 then change to 3 otherwise set to 0.
update product set Discount_rate = case when quantity_on_hand >= 20 then 10 else 
								   case when quantity_on_hand between 10 and 20 then 5 else 
                                   case when quantity_on_hand > 5 then 3 else 0 end end end ; 
                                   
update product set Discount_rate = case when quantity_on_hand >= 20 then 10 else 
								   case when quantity_on_hand <= 20 then 5 else 
                                   case when quantity_on_hand < 10 then 3 else 
                                   case when quantity_on_hand <= 5 then 0 end end end end ;                                    

-- 11. The first number of pin code in the client table should be start with 7
select * from salesman ; 
alter table salesman add constraint check ( pincode like '7%');  





-- creating and using view  
set sql_safe_updates = 0 ; 

-- 12. Creates a view name as clients_view that shows all customers information from Thu Dau Mot.
Create view clients_view as select * from clients where city = 'Thu Dau Mot' ;  

select * from clients_view ; 

-- 13. Drop the “client_view”.
drop view clients_view ; 


-- 14. Creates a view name as clients_order that shows all clients and their order details from Thu Dau Mot.
create view clients_order as select c.* from clients c 
inner join salesorder sod on c.client_number = sod.client_number 
where city = 'Thu Dau Mot';

drop view clients_order ; 

select * from clients_order ; 

--  15. Creates a view that selects every product in the "Products" table with a sell price higher than the average 
-- sell price.
select * from product ; 

create view Products as select * from product where sell_price > ( select AVG(sell_price) from product ) ; 

select * from products ; -- show views  


-- 16. Creates a view name as salesman_view that show all salesman information and products (product names, 
-- product price, quantity order) were sold by them.

Create view salesman_view as select sm.* , pro.product_name , pro.cost_price , sodd.order_quantity from salesman sm  
inner join salesorder sod on sm.salesman_number  = sod.salesman_number 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number ; 

select * from salesman_view ; 



-- 17. Creates a view name as sale_view that show all salesman information and product (product names, 
-- product price, quantity order) were sold by them with order_status = 'Successful'.
Create view sales_view as select sm.* , pro.product_name , pro.cost_price , sodd.order_quantity from salesman sm 
inner join salesorder sod on sm.salesman_number = sod.salesman_number 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number
inner join product pro on pro.product_number = sodd.product_number 
where sod.order_status = 'Successful'; 

drop view sales_view ; 

select * from sales_view ; 

-- 18. Creates a view name as sale_amount_view that show all salesman information and sum order quantity 
-- of product greater than and equal 20 pieces were sold by them with order_status = 'Successful'.
create view sale_amount_view as select sm.* , sum(order_quantity) as Total_Quantity from salesman sm 
inner join salesorder sod on sm.salesman_number = sod.salesman_number 
inner join salesorderdetails sodd on sodd.order_number = sod.order_number 
inner join product pro on pro.product_number = sodd.product_number 
where sod.order_status = 'Successful' 
group by sm.salesman_number 
having sum(order_quantity) >= 20 ; 

select * from sale_amount_view ; 





-- more exercise 
-- 19. Amount paid and amounted due should not be negative when you are inserting the data. 

alter table clients add constraint check ( amount_paid >= 0 and amount_due >= 0 );  
select * from clients ; 

-- 20. Remove the constraint from pincode;
alter table clients drop constraint clients_chk_1 ;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	WHERE TABLE_NAME = 'clients';


-- 21. The sell price and cost price should be unique.
select * from product ; 

Alter table product Add constraint unique (sell_price) ; 
Alter table product Add constraint unique (cost_price) ; 


-- 22. The sell price and cost price should not be unique.
alter table product drop constraint cost_price ; 
alter table product drop constraint sell_price ; 

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	WHERE TABLE_NAME = 'product';


-- 23. Remove unique constraint from product name.
alter table product drop constraint product_name ; 


-- 24. Update the delivery status to “Delivered” for the product number P1007.
select * from salesorder ; 
select * from product ; 

Update salesorder set delivery_status = 'Delivered' where order_number in 
( select order_number from salesorderdetails where product_number = 'P1007' ); 

select * from salesorder ; 
select * from salesorderdetails ; 


-- 25. Change address and city to ‘Phu Hoa’ and ‘Thu Dau Mot’ where client number is C104
select * from clients ; 
Update clients set address = 'Phu Hoa' , city = 'Thu Dau Mot' where client_number = 'C104'; 


-- 26. Add a new column to “Product” table named as “Exp_Date”, data type is Date.
select * from product ;

alter table product add column Exp_date date ; 

-- 27. Add a new column to “Clients” table named as “Phone”, data type is varchar and size is 15.

select * from clients ; 

alter table clients add column Phone varchar(15) ; 

-- 28. Update remarks as “Good” for all salesman.
select * from salesman ; 
update salesman set achievement = 'Good' ; 

-- 29. Change remarks to "bad" whose salesman number is "S004".
update salesman set achievement = 'bad' where salesman_number = 'S004';

--  30. Modify the data type of “Phone” in “Clients” table with varchar from size 15 to size is 10.
alter table clients modify column Phone varchar(10); 

select * from clients ; 

-- 31. Delete the “Phone” column from “Clients” table.
alter table clients drop column phone ; 


-- 33. Change the sell price of Mouse to 120.
select * from product ; 

update product set sell_price = 120 where product_name = 'Mouse' ; 


-- 34. Change the city of client number C104 to “Ben Cat”.
select * from clients ; 

update clients set city = 'Ben Cat' where client_number = 'C104';


-- 35. If On_Hand_Quantity greater than 5, then 10% discount. If On_Hand_Quantity greater than 10, then 15% 
-- discount. Othrwise, no discount
select * from product ; 

select Quantity_on_hand ,
	case when quantity_on_hand > 10 then 0.85 else 
	case when quantity_on_hand > 5 then 0.9 else 0 end end as QuantityText 
    from product ; 
                                       
                                       












