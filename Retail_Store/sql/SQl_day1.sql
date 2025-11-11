select * from customers ;

--  Create a new table called Returns

create table Returns(

returnid int primary key ,
orderdetail varchar(10)
)

-- Insert a new customer named “Priya Verma” from “Kolkata”
insert into customers (CustomerName , CustomerID , Email , city)
values('priya' , 101 , 'prya@123' , 'kolkata') ;

-- Update the stock of product with ProductID = 1 to a new value of 80.

update products 
set stock = 80
where productID = 1 ;

-- find the all orders place by customer in hyderabad 
select  o.*
from orders o 
join customers c 
on o.customerid = c.customerid 
where c.city = 'hyderabad';

-- Average product price per category > ₹2000
select * from products;

select Category , avg(price) as avgprice 
from products
group by category 
having  avg(price) > 2000;

-- joins 
-- Display all orders along with customer names

select * from orders;
select * from customers;

select o.orderid , c.CustomerName
from orders o
join customers c on o.customerid = c.customerid ;

-- List all customers and their orders, including customers with no orders
select o.orderid , c.CustomerName
from customers c
left join orders o on o.customerid = c.customerid ;


-- functions - string , numeric 

-- Display order dates in the format DD-MM-YYYY
select * from orders ;

select orderid , date_format(orderdate , '%d-%m-%Y') as formatdate
from orders ;

-- Calculate total amount (price × quantity) for each order
select orderid , sum(price * quantity) as total_amount
from orderdetails 
group by 1; 

--   Round product prices to the nearest 10 

select * from products ;

select * , round(price , -1 ) as roundprice 
from products ; 

-- sub queries  

-- Products above average price  
select productname , price 
from products 
where price > (
select avg(price) from products 
);

-- Orders where total value > ₹5000 -- total value - quantity*price 

(select o.orderid 
from orders  o
where  
select sum(od.quantity * od.price) 
from orderdetails od 
where od.orderid = o.orderid 
) > 5000 ;


-- Create a view named ProductSalesSummary showing total quantity sold per product
create view ProductSalesSummary as 
select productid  , sum(quantity) as totalquantitysold 
from orderdetails 
group by ProductID ;

select * from productsalessummary ;

-- Create a stored procedure UpdateProductStock that takes a ProductID 
-- and a newStock value, and updates the stock for that product in the Products table.

delimiter $$

create procedure UpdateProductStock (
IN pid int ,
IN newstock int
)
begin 
update products
set stock = newstock
where productid = pid;
end $$

delimiter ;

call UpdateProductStock(1 ,  80);

select * from products where productid =2 ; 

call UpdateProductStock(2 , 90);

-- Create a stored function CustomerLifetimeValue that takes a
-- CustomerID and returns the total amount spent by that   customer across all orders.

delimiter $$ 
create function CustomerLifetimeValue(cid int)
returns decimal(10 ,2)
deterministic
BEGIN
	declare total decimal(10 , 2);
    select sum( od.quantity * od.price) 
    into total
    from oders o 
    join orderdetails od on o.orderid = od.orderid 
    where o.customerid = cid ;
    return ifnull(total ,0);
    end $$
    
delimiter ;
    

select customerid , CustomerLifetimeValue(customerid) as totalspent
from customers
order by totalspent desc ;

