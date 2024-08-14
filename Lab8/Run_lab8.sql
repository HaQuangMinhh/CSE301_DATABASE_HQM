use copy_salemanagerment ; 



-- 1 
select * from product ; 

delimiter // 
create trigger before_total_quantity_update  
before update 
on product 
for each row 
begin 
	-- Kiểm tra nếu quantity_on_hand hoặc quantity_sell thay đổi 
	if new.quantity_on_hand <> old.quantity_on_hand or new.quantity_sell <> old.quantity_sell then 
    
    -- cập nhật total_quantity dựa trên các giá trị mới 
    set new.total_quantity = new.quantity_on_hand + new.quantity_sell ; 
	end if ;
end 
// delimiter ;

Update product set quantity_on_hand = 30 , quantity_sell = 35 
where product_number = 'P1004' ; 

select * from product ; 

Drop trigger if exists before_total_quantity_update ; 


-- 2 
select * from salesman ; 
alter table salesman add column per_marks int ; 

delimiter // 
create trigger before_remark_salesman_update 
before update 
on salesman 
for each row 
begin 
	if new.sales_target <> old.sales_target or old.target_achieved <> new.target_achieved then 
		update salesman set new.per_marks = new.target_achieved * 100 / new.sales_target ; 
    end if ; 
end 
// delimiter ; 




drop trigger before_remark_salesman_update ; 


-- 3 
select * from product ; 

delimiter // 
create trigger before_product_insert 
before insert on product 
for each row 
begin 
	insert into product value ( inserted.product_number , inserted.product_name , inserted.quantity_on_hand 
    , inserted.quantity_sell , inserted.sell_price ,inserted.cost_price
    , inserted.profit , inserted.total_quantity, inserted.discount_rate , inserted.exp_date);
end 
// delimiter ; 

insert into product value ( "P1009" , "Test" , 60 , 40 , 400.000 , 500.000 , 25 , 100 , 10 , "2024-05-08" ) ; 



-- 4 
select * from salesorder ; 

delimiter // 
create trigger before_update_the_delivery 
before update on salesorder 
for each row 
begin 
	if new.order_status = "Successful" then 
    set new.delivery_status = "Delivered" ; 
    end if ; 
end 
// delimiter ;



-- 5 
select * from salesman ; 

delimiter // 
create trigger update_the_remarks 
after insert on salesman 
for each row 
begin 
	update salesman set achievement = "Good"; 
end 
// delimiter ; 


-- 6  Create a trigger to enforce that the first digit of the pin code in the "Clients" table must be 7. 
DELIMITER $$
CREATE TRIGGER before_client_insert_update
BEFORE INSERT ON clients
FOR EACH ROW
BEGIN
  IF LENGTH(NEW.Pincode) < 1 OR SUBSTRING(NEW.Pincode, 1, 1) != '7' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pincode must start with 7';
  END IF;
END $$
DELIMITER ;

-- 7. Create a trigger to update the city for a specific client to "Unknown" when the client is deleted 
DELIMITER $$
CREATE TRIGGER before_client_delete
BEFORE DELETE ON clients
FOR EACH ROW
BEGIN
  UPDATE clients
  SET City = 'Unknown'; 
  END $$
DELIMITER ;

-- 8. Create a trigger after_product_insert to insert a product and update profit and total_quantity in product table. 
select * from product;
Delimiter $$
create trigger after_product_insert
after insert on product
for each row
begin
	update product
	set new.profit = new.sell_price - new.cost_price,
     new.total_quantity = new.quantity_on_hand + new.quantity_sell;
end $$
Delimiter ;

-- 9. Create a trigger to update the delivery status to "On Way" for a specific order when an order is inserted. \
select * from salesorder;
Delimiter $$
create trigger auto_OnWay_Delivery
after insert on salesorder
for each row
begin
	update salesorder
    set delivery_status  = 'On Way'
      WHERE Order_Number = NEW.Order_Number;
end $$
Delimiter ;

-- 10. Create a trigger before_remark_salesman_update to update Percentage of per_remarks in a salesman 
-- table (will be stored in PER_MARKS column)  If  per_remarks >= 75%, his remarks should be ‘Good’. 
-- If 50% <= per_remarks < 75%, he is labeled as 'Average'. If per_remarks <50%, he is considered  'Poor'. 
select * from salesman;
Delimiter $$
create  trigger before_remark_salesman_update
before update on salesman
for each row

begin
	if( new.target_achieved <> old.target_achieved or new.sales_target <> old.sales_target) then
		set new.per_mark = (new.target_achieved *100)/new.sales_target;
    if(new.per_mark>=75) then
		set new.note= 'Good';
    else if (new.per_mark>=50) then
		set new.note = 'Average';
    else 
		set new.note = 'Poor';
    
    end if;
    end if;
    end if;
end $$

Delimiter ;

-- 11. Create a trigger to check if the delivery date is greater than the order date, if not, do not insert it
select * from salesorder; 

Delimiter $$
create trigger check_delivery_date
before insert on salesorder
for each row
begin
	if(new.delivery_date < new.order_date) then
    set message_text = 'Error';
    end if;
end $$
Delimiter ;

-- 12. Create a trigger to update Quantity_On_Hand when ordering a product (Order_Quantity). 
select * from product;
select * from salesorderdetails;

Delimiter $$
create trigger change_quantity_on_hand_when_ordering
after update on salesorderdetails
for each row
begin 
	update product
    set Quantity_On_Hand = Quantity_On_Hand - new.order_quantity,
     Quantity_Sell = Quantity_Sell + new.order_quantity;
end $$
Delimiter ;

-- 1. Find the average salesman’s salary.
DELIMITER $$
CREATE FUNCTION average_salesman_salary()
RETURNS DECIMAL(15,4)
READS SQL DATA
BEGIN
    DECLARE avg_salary DECIMAL(15,4);
    SELECT AVG(Salary) INTO avg_salary FROM salesman;
    RETURN avg_salary;
END $$
DELIMITER ;

-- 2. Find the name of the highest paid salesman. 
Delimiter $$
create function highest_paid_salesman_name()
returns varchar(25)
reads sql data
begin
	declare highest_paid_name varchar(25);
    select salesman_name into highest_paid_name from salesman
    where salary = ( select max(salary) from salesman )
    limit 1;
    return highest_paid_name;
end $$
delimiter ;

select highest_paid_salesman_name();

-- 3. Find the name of the salesman who is paid the lowest salary. 

Delimiter $$
create function lowest_paid_salesman_name()
returns varchar(25)
reads sql data
begin
	declare lowest_paid_name varchar(25);
    select salesman_name into lowest_paid_name from salesman
    where salary = ( select min(salary) from salesman )
    limit 1;
    return lowest_paid_name;
end $$
delimiter ;

select lowest_paid_salesman_name();


-- 4. Determine the total number of salespeople employed by the company. 
select * from salesman;
Delimiter $$
create function count_salesman()
returns int
reads sql data
begin 
declare count_salespeople int;
	select count(*) into count_salespeople from salesman;
    return count_salespeople;
    
end $$  
Delimiter ;

select count_salesman();


-- 5. Compute the total salary paid to the company's salesman. 
select sum(salary) from salesman;

Delimiter $$
create function count_salary()
returns decimal(15,4)
reads sql data
begin 
	declare count_salary decimal(15,4);
	select sum(salary) into count_salary from salesman;
    return count_salary;
    
end $$  
Delimiter ;

select count_salary();

-- 6. Find Clients in a Province 

DELIMITER $$
CREATE PROCEDURE find_clients_in_province(IN p_province CHAR(25))
BEGIN
  SELECT Client_Number, Client_Name, Address, City, Pincode, Province, Amount_Paid, Amount_Due
  FROM clients
  WHERE Province = p_province;
END $$
DELIMITER ;

CALL find_clients_in_province('Binh Duong');

-- 7. Calculate Total Sales 
select * from salesorderdetails;
select * from salesorder;
select * from product;
DELIMITER $$
CREATE FUNCTION calculate_total_sales()
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_sales DECIMAL(10,2) DEFAULT 0;
    SELECT SUM(sod.Order_Quantity * p.Sell_Price) INTO total_sales
    FROM salesorderdetails sod
    INNER JOIN product p ON sod.Product_Number = p.Product_Number;
    RETURN total_sales;
END $$
DELIMITER ;
select calculate_total_sales();

-- 8. Calculate Total Order Amount 

DELIMITER $$
CREATE FUNCTION calculate_total_order_amount(order_number INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_amount DECIMAL(10,2) DEFAULT 0;
    SELECT SUM(sod.Order_Quantity * p.Sell_Price) INTO total_amount
    FROM salesorderdetails sod
    INNER JOIN product p ON sod.Product_Number = p.Product_Number
    WHERE sod.Order_Number = order_number;
    RETURN total_amount;
END $$
DELIMITER ;






