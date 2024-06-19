drop database amazon;
create database amazon;
use amazon;
create table products(pid int(3) primary key,pname varchar(50) not null, price int(10) not null, stock int(5), location varchar(30) check(location in ('Mumbai','Delhi')));

create table customer(cid int(3) primary key,cname varchar(30) not null, age int(3), addr varchar(50));
create table orders(oid int(3) primary key,cid int(3),pid int(3),amt int(10) not null,foreign key(cid) references customer(cid), foreign key(pid) references products(pid));
create table payment(pay_id int(3) primary key,oid int(3), amount int(10) not null, mode varchar(30) check(mode in('upi','credit','debit')),status varchar(30), foreign key(oid) references orders(oid));
create table employee(eid int(4) primary key,ename varchar(40) not null, phone_no int(10) not null, deparrtment varchar(40) not null,manager_id int(4));


insert into products values(1,'HP Laptop',50000,15,'Mumbai'),(2,'Realme Mobile',20000,30,'Delhi'),(3,'Boat earpods',3000,50,'Delhi'),(4,'Levono Laptop',40000,15,'Mumbai'),(5,'Charger',1000,0,'Mumbai'),(6, 'Mac Book', 78000, 6, 'Delhi'),(7, 'JBL speaker', 6000, 2, 'Delhi');

insert into customer values(101,'Ravi',30,'fdslfjl'),(102,'Rahul',25,'fdslfjl'),(103,'Simran',32,'fdslfjl'),(104,'Purvesh',28,'fdslfjl'),(105,'Sanjana',22,'fdslfjl');

insert into orders values(10001,102,3,2700),(10002,101,2,18000),(10003,103,5,900),(10004,101,1,46000);

insert into payment values(1,10001,2700,'upi','completed'),(2,10002,18000,'credit','completed'),(3,10003,900,'debit','in process');

insert into employee values(401, "Rohan", 364832549, "Analysis", 404),(402, "Rahul", 782654123, "Delivery", 406),(403, "Shyam", 856471235, "Delivery", 402),(404, "Neha", 724863287, "Sales", 402),(405, "Sanjana", 125478954, "HR", 404),(406, "Sanjay", 956478535, "Tech",null);

SELECT * FROM products;

SELECT * FROM customer;

SELECT * FROM orders;

SELECT * FROM orders;

SELECT * FROM employee;

--  INNER JOIN : Matching values from both tables should be present
-- For getting the name of customers who placed the order, we need to inner join customer and orders table
SELECT customer.cid, cname, orders.oid FROM orders INNER JOIN customer ON orders.cid=customer.cid;
-- getting the name of the customers and products that were ordered, we need to inner join orders, products and customer table
SELECT customer.cid, cname, products.pid, pname, oid FROM orders INNER JOIN products ON orders.pid = products.pid INNER JOIN customer ON orders.cid = customer.cid;

-- LEFT OUTER JOIN
-- All the rows from the left table should be present and matching rows from the right table are present
-- Getting the product id, product name, amount to be paid in an order, we need to left join products and orders table
SELECT products.pid, pname, amt, orders.oid FROM products LEFT JOIN orders ON orders.pid = products.pid;

-- RIGHT JOIN
-- All the rows from the right table should be present and only matching rows from the left table are present
-- Displaying order details in paymnets table, we need to right join payment and orders table
SELECT * FROM payment RIGHT JOIN orders ON orders.oid = payment.oid;

-- Full Join
-- All the rows from both the table should be present
-- Displaying the details of all the orders and products, we need to full join orders and products tables
SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders LEFT JOIN products ON orders.pid = products.pid UNION SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders RIGHT JOIN products ON orders.pid = products.pid;

SELECT orders.oid, products.pid, pname, amt, price, stock, location FROM orders FULL JOIN products ON orders.pid = products.pid;

-- SELF JOIN
SELECT e1.ename AS Employee, e2.ename AS Manager FROM employee e1 JOIN employee e2 ON e1.manager_id = e2.eid;

-- CROSS JOIN
-- It is used to view all the possible combinations of the rows of one table and with all the rows from second table
SELECT customer.cid,cname,orders.oid,amt FROM customer CROSS JOIN orders ON customer.cid = orders.cid WHERE amt>3000;



-- color
-- Red
-- Blue
-- Green


-- size
-- Small
-- Medium
-- Large


-- color	size
-- Red	Small
-- Red	Medium
-- Red	Large
-- Blue	Small
-- Blue	Medium
-- Blue	Large
-- Green	Small
-- Green	Medium
-- Green	Large

-- QUESTIONS
#q1. Display details of all orders which were delivered from "Mumbai"
select * from orders left join products on orders.pid=products.pid where location="Mumbai";

#q2. Display details of all orders whose payment was made through "UPI"
select * from orders right join payment on orders.oid=payment.oid where mode="UPI";

#q3. Dispaly oid, amt, cname, payment mode of orders which were made by people below 30 years
select orders.oid,orders.amt,customer.cname,payment.mode from orders inner join payment on orders.oid=payment.oid inner join customer on orders.cid=customer.cid where age<30;

#q4. Dispaly oid, amt, cname, paymentmode of orders which were made by people below 30 years and payment was made through "Credit"
SELECT orders.oid, cname, amt, mode FROM orders INNER JOIN payment ON orders.oid = payment.oid INNER JOIN customer ON orders.cid = customer.cid WHERE age<30 AND mode="Credit";

#q5. Display oid, amount, cname, pname, location of the orders whose payment is still pending or in process
SELECT orders.oid, cname, pname, amount, status, location FROM orders CROSS JOIN products ON orders.pid = products.pid CROSS JOIN customer ON orders.cid = customer.cid CROSS JOIN payment ON orders.oid = payment.oid WHERE status IN ("in process", "pending");

#q6. We have order table, want to also display details of product ordered and details of customer who placed the order
SELECT orders.cid, cname, pname FROM orders INNER JOIN customer ON orders.cid = customer.cid INNER JOIN products ON orders.pid = products.pid;