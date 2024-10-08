create database sales_management ; 
use sales_management ; 

create table customers (
	CUSTOMERS_CODE char(4) Primary key , 
    FULL_NAME varchar(40) , 
    ADDRESS varchar(50) , 
    PHONE varchar(10) , 
    BIRTH_DATE date , 
    QUANTITY_SELL decimal( 15,2), 
    REGISTRATION_DATE date 
); 

insert into customers values
('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '0809823451', STR_TO_DATE('22-10-
1960', '%d-%m-%Y'), '13060000', STR_TO_DATE('22-07-2006', '%d-%m-%Y')),
('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', STR_TO_DATE('03-04-
1974', '%d-%m-%Y'), '280000', STR_TO_DATE('30-07-2006', '%d-%m-%Y')),
('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', STR_TO_DATE('12-
06-1980', '%d-%m-%Y'), '3860000', STR_TO_DATE('05-08-2006', '%d-%m-%Y')),
('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', STR_TO_DATE('09-
03-1965', '%d-%m-%Y'), '250000', STR_TO_DATE('02-10-2006', '%d-%m-%Y')),
('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '0824645108', STR_TO_DATE('10-03-1950',
'%d-%m-%Y'), '21000', STR_TO_DATE('28-10-2006', '%d-%m-%Y')),
('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '0863109738', STR_TO_DATE('31-
12-1981', '%d-%m-%Y'), '915000', STR_TO_DATE('24-11-2006', '%d-%m-%Y')),
('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', STR_TO_DATE('06-
04-1971', '%d-%m-%Y'), '12500', STR_TO_DATE('01-12-2006', '%d-%m-%Y')),
('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', STR_TO_DATE('10-
01-1971', '%d-%m-%Y'), '365000', STR_TO_DATE('13-12-2006', '%d-%m-%Y')),
('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '0865674763', STR_TO_DATE('03-09-
1979', '%d-%m-%Y'), '70000', STR_TO_DATE('14-01-2007', '%d-%m-%Y')),
('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '0873468904', STR_TO_DATE('02-05-
1983', '%d-%m-%Y'), '675000', STR_TO_DATE('16-01-2007', '%d-%m-%Y'));

create table SALESMAN (
	SALESMAN_CODE char(4) Primary key , 
    FULL_NAME varchar(40) NOT NULL , 
    BEGINNING_DATE date , 
    PHONE char(10)  
);

insert into salesman values 
('NV01', 'Nguyen Nhu Nhut', STR_TO_DATE('13-04-2006', '%d-%m-%Y'), '0927345678'),
('NV02', 'Le Thi Phi Yen', STR_TO_DATE('21-04-2006', '%d-%m-%Y'), '0987567390'),
('NV03', 'Nguyen Van B', STR_TO_DATE('27-04-2006', '%d-%m-%Y'), '0997047382'),
('NV04', 'Ngo Thanh Tuan', STR_TO_DATE('24-06-2006', '%d-%m-%Y'), '0913758498'),
('NV05', 'Nguyen Thi Truc Thanh', STR_TO_DATE('20-07-2006', '%d-%m-%Y'), '0918590387');

create table PRODUCTS (
	PRODUCT_CODE char(4) primary key , 
    PRODUCT_NAME varchar(40) NOT NULL , 
    UNIT varchar(20) , 
    MANUFACTURE_COUNTRY varchar(40) not null , 
    PRICE decimal(15,2) not null , 
    check ( price <> 0 )
); 

insert into products values 
('BC01', 'But chi', 'cay', 'Singapore', '3000'),
('BC02', 'But chi', 'cay', 'Singapore', '5000'),
('BC03', 'But chi', 'cay', 'Viet Nam', '3500'),
('BC04', 'But chi', 'hop', 'Viet Nam', '30000'),
('BB01', 'But bi', 'cay', 'Viet Nam', '5000'),
('BB02', 'But bi', 'cay', 'Trung Quoc', '5000'),
('BB03', 'But bi', 'hop', 'Thai Lan', '100000'),
('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', '2500'),
('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', '4500'),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', '3000'),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', '5500'),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', '23000'),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', '53000'),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', '34000'),
('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', '40000'),
('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', '55000'),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', '51000'),
('ST04', 'So tay', 'quyen', 'Thai Lan', '55000'),
('ST05', 'So tay mong', 'quyen', 'Thai Lan', '20000'),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', '5000'),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', '7000'),
('ST08', 'Bong bang', 'cai', 'Viet Nam', '5000'),
('ST09', 'But long', 'cay', 'Viet Nam', '5000'),
('ST10', 'But long', 'cay', 'Trung Quoc', '7000');


create table INVOICE (
	INVOICE_CODE char(4) primary key , 
    PURCHASE_DATE date not null , 
    CUSTOMERS_CODE char(4)  , 
    SALESMAN_CODE char(4)  , 
    TOTAL_AMOUNT decimal(15,2) 
);

insert into invoice values
('1001', STR_TO_DATE('23-07-2006', '%d-%m-%Y'), 'KH01', 'NV01', 320000),
('1002', STR_TO_DATE('12-08-2006', '%d-%m-%Y'), 'KH01', 'NV02', 840000),
('1003', STR_TO_DATE('23-08-2006', '%d-%m-%Y'), 'KH02', 'NV01', 100000),
('1004', STR_TO_DATE('01-09-2006', '%d-%m-%Y'), 'KH02', 'NV01', 180000),
('1005', STR_TO_DATE('20-10-2006', '%d-%m-%Y'), 'KH01', 'NV02', 3800000),
('1006', STR_TO_DATE('16-10-2006', '%d-%m-%Y'), 'KH01', 'NV03', 2430000),
('1007', STR_TO_DATE('28-10-2006', '%d-%m-%Y'), 'KH03', 'NV03', 510000),
('1008', STR_TO_DATE('28-10-2006', '%d-%m-%Y'), 'KH01', 'NV03', 440000),
('1009', STR_TO_DATE('28-10-2006', '%d-%m-%Y'), 'KH03', 'NV04', 200000),
('1010', STR_TO_DATE('01-11-2006', '%d-%m-%Y'), 'KH01', 'NV01', 5200000),
('1011', STR_TO_DATE('04-11-2006', '%d-%m-%Y'), 'KH04', 'NV03', 250000),
('1012', STR_TO_DATE('30-11-2006', '%d-%m-%Y'), 'KH05', 'NV03', 21000),
('1013', STR_TO_DATE('12-12-2006', '%d-%m-%Y'), 'KH06', 'NV01', 5000),
('1014', STR_TO_DATE('31-12-2006', '%d-%m-%Y'), 'KH03', 'NV02', 3150000),
('1015', STR_TO_DATE('01-01-2007', '%d-%m-%Y'), 'KH06', 'NV02', 910000),
('1016', STR_TO_DATE('01-01-2007', '%d-%m-%Y'), 'KH07', 'NV02', 12500),
('1017', STR_TO_DATE('02-01-2007', '%d-%m-%Y'), 'KH08', 'NV03', 35000),
('1018', STR_TO_DATE('13-01-2007', '%d-%m-%Y'), 'KH01', 'NV03', 330000),
('1019', STR_TO_DATE('13-01-2007', '%d-%m-%Y'), 'KH01', 'NV03', 30000),
('1020', STR_TO_DATE('14-01-2007', '%d-%m-%Y'), 'KH09', 'NV04', 70000),
('1021', STR_TO_DATE('16-01-2007', '%d-%m-%Y'), 'KH10', 'NV03', 67500),
('1022', STR_TO_DATE('16-01-2007', '%d-%m-%Y'), NULL, 'NV03', 7000),
('1023', STR_TO_DATE('17-01-2007', '%d-%m-%Y'), NULL, 'NV01', 330000);

alter table invoice add foreign key (Customers_code) references customers; 


create table DETAILINVOICE (
	INVOICE_CODE char(4) not null , 
    PRODUCT_CODE char(4) not null , 
    QUANTITY int not null 
);

drop table detailinvoice ; 

insert into detailinvoice values
('1001', 'TV02', '10'),
('1001', 'ST01', '5'),
('1001', 'BC01', '5'),
('1001', 'BC02', '10'),
('1001', 'ST08', '10'),
('1001', 'BC04', '20'),
('1002', 'BB01', '20'),
('1002', 'BB02', '20'),
('1003', 'BB03', '10'),
('1004', 'TV01', '20'),
('1004', 'TV02', '10'),
('1004', 'TV03', '10'),
('1004', 'TV04', '10'),
('1005', 'TV05', '50'),
('1005', 'TV06', '50'),
('1006', 'TV07', '20'),
('1006', 'ST01', '30'),
('1006', 'ST02', '10'),
('1007', 'ST03', '10'),
('1008', 'ST04', '8'),
('1009', 'ST05', '10'),
('1010', 'TV07', '50'),
('1010', 'ST07', '50'),
('1010', 'ST08', '100'),
('1010', 'ST04', '50'),
('1010', 'TV03', '100'),
('1011', 'ST06', '50'),
('1012', 'ST07', '3'),
('1013', 'ST08', '5'),
('1014', 'BC02', '80'),
('1014', 'BB02', '100'),
('1014', 'BC04', '60'),
('1014', 'BB01', '50'),
('1015', 'BB02', '30'),
('1015', 'BB03', '7'),
('1016', 'TV01', '5'),
('1017', 'TV02', '1'),
('1017', 'TV03', '1'),
('1017', 'TV04', '5'),
('1018', 'ST04', '6'),
('1019', 'ST05', '1'),
('1019', 'ST06', '2'),
('1020', 'ST07', '10'),
('1021', 'ST08', '5'),
('1021', 'TV01', '7'),
('1021', 'TV02', '10'),
('1022', 'ST07', '1'),
('1023', 'ST04', '6');



alter table customers add constraint chkCode check ( customers_code like 'KH%');  
alter table products add constraint chkProduct check ( unit in ( 'cay', 'hop', 'cai', 'quyen', 'chuc' )); 
alter table customers add constraint chkPhoneNumber check (PHONE = "");  




use sales_management ; 
-- 1. Print out a list of products (PRODUCT_CODE, PRODUCT_NAME) made by "Trung
-- Quoc" that cost from 30,000 to 40,000.
select * from products ; 

select product_code , product_name from products where manufacture_country = 'Trung Quoc' and price between 30000 and 40000 ; 

-- 2. Find invoice code sold by salesperson named 'Nguyen Nhu Nhut' and code order by
-- decreasing.
select i.invoice_code from invoice i
inner join salesman sm on i.salesman_code = sm.salesman_code 
where full_name = 'Nguyen Nhu Nhut'
order by invoice_code desc ; 


-- 3. Print product code and the sum of quantity per product.
select product_code , sum(quantity) from detailinvoice 
group by product_code ; 



-- 4. Print out a list of invoices (PURCHASE_DATE, Revenue_Per_Day – total amount of a
-- day) where the purchase date must have sales revenue higher than 1,000,000 and ordered by
-- increasing revenue.

--  i.purchase_date , i.total_amount from invoice i 




-- 5. Find the customer's name and the product name has a total number of products sold greater
-- than 50 that customer purchased. Then sort by number of products sold.
select * from products ; 

select cus.full_name,  pro.product_name, sum(di.quantity) totalProducts from customers cus 
inner join invoice i on cus.customers_code = i.customers_code 
inner join detailinvoice di on i.invoice_code = di.invoice_code 
inner join products pro on pro.product_code = di.product_code 
group by full_name , product_name 
having totalProducts > 50 
order by totalProducts ; 

-- 6. Print out a list of customers (CUSTOMERS_CODE, FULL_NAME, ADDRESS) live in
-- District 5 and have the total amount of invoice higher than average amount of invoice.
select * from customers ; 
select * from invoice ; 
select * from detailinvoice ; 

-- select cus.customers_code , cus.full_name , cus.address from customers cus
-- where cus.address =


-- 7. Add 2 columns to DETAILINVOICE: price(decimal (15,2)), amount(decimal(15,2)). Then
-- calculate product price and amount (price * quantity).
select * from detailinvoice ; 

alter table detailinvoice add column price decimal (15,2) ; 
alter table detailinvoice add column amount decimal(15,2) ; 

set sql_safe_updates = 0 ;
-- select price from detailinvoice di 
-- inner join product pro on pro.product_code = di.product_code

update detailinvoice di inner join products pro on pro.product_code = di.product_code set di.price = pro.price ; 
update detailinvoice set amount = quantity * price ; 


-- 8. Update total_amount from INVOICE table with amount value from DETAILINVOICE
-- table.



-- 9. Create a store procedure to find customer information that have total amount more than
-- average of all customers with input address of customer.
delimiter $$ 
create procedure 
	


-- 10. Create a stored procedure to find the N best-selling products with input N.




 
