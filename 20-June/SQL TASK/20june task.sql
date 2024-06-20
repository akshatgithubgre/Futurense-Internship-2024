drop database amazon;

create database amazon;
use amazon;

create table products(pid int(3) primary key,pname varchar(50) not null,price int(10) not null,stock int(5),location varchar(30) check(location in ('Mumbai','Delhi')));

create table customer(cid int(3) primary key,cname varchar(30) not null,age int(3),addr varchar(50));

create table orders(oid int(3) primary key,cid int(3),pid int(3),amt int(10) not null,foreign key(cid) references customer(cid),foreign key(pid) references products(pid));

create table payment(pay_id int(3) primary key,oid int(3),amount int(10) not null,mode varchar(30) check(mode in('upi','credit','debit')),status varchar(30),foreign key(oid) references orders(oid));

ALTER TABLE payment ADD COLUMN timestamp TIMESTAMP;

insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');
insert into products values(8 , 'Asus Laptop',50000,15,'Delhi');

insert into customer values(101,'Ravi',30,'fdslfjl');
insert into customer values(102,'Rahul',25,'fdslfjl');
insert into customer values(103,'Simran',32,'fdslfjl');
insert into customer values(104,'Purvesh',28,'fdslfjl');
insert into customer values(105,'Sanjana',22,'fdslfjl');

insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);

insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

UPDATE payment SET timestamp = '2024-05-01 08:00:00' WHERE pay_id = 1;

UPDATE payment SET timestamp = '2024-05-01 08:10:00' WHERE pay_id = 2;

UPDATE payment SET timestamp = '2024-05-01 08:15:00' WHERE pay_id = 3;






create database june20task;
use june20task;

CREATE TABLE Customers(customer_id INT PRIMARY KEY AUTO_INCREMENT,customer_name VARCHAR(255) NOT NULL,state VARCHAR(50));

CREATE TABLE Products(product_id INT PRIMARY KEY AUTO_INCREMENT,product_name VARCHAR(255) NOT NULL,category VARCHAR(50));

CREATE TABLE Employees(employee_id INT PRIMARY KEY AUTO_INCREMENT,last_name VARCHAR(255) NOT NULL,department_id INT,salary DECIMAL(10,2));

CREATE TABLE Departments(department_id INT PRIMARY KEY AUTO_INCREMENT,department_name VARCHAR(255) NOT NULL,num_employees INT);

CREATE TABLE Orders(order_id INT PRIMARY KEY AUTO_INCREMENT,customer_id INT NOT NULL,order_date DATE NOT NULL,order_total DECIMAL(10,2) NOT NULL,FOREIGN KEY (customer_id) REFERENCES Customers(customer_id));

CREATE TABLE Order_Items(order_id INT NOT NULL,product_id INT NOT NULL,quantity INT NOT NULL,price DECIMAL(10,2) NOT NULL,FOREIGN KEY (order_id) REFERENCES Orders(order_id),FOREIGN KEY (product_id) REFERENCES Products(product_id));

CREATE TABLE States(state_id INT PRIMARY KEY AUTO_INCREMENT, state_name VARCHAR(50) NOT NULL, state_abbreviation VARCHAR(2) NOT NULL);

INSERT INTO States (state_name, state_abbreviation) VALUES ('California', 'CA'),('Texas', 'TX'),('New York', 'NY');

INSERT INTO Customers (customer_name, state)VALUES ('Alice Johnson', 'CA'),('Bob Smith', 'TX'),('Charlie Brown', 'CA');

INSERT INTO Products (product_name, category)VALUES ('Laptop', 'Electronics'),('Headphones', 'Electronics'),('T-Shirt', 'Clothing');

INSERT INTO Employees (last_name, department_id, salary)VALUES ('Williams', 1, 80000.00),('Jones', 2, 75000.00),('Miller', 1, 68000.00);

INSERT INTO Orders (customer_id, order_date, order_total)VALUES (1, '2024-06-10', 1200.00),(2, '2024-06-15', 500.00),(1, '2024-06-18', 800.00);

INSERT INTO Order_Items (order_id, product_id, quantity, price)VALUES (1, 1, 1, 1000.00),(1, 2, 1, 200.00),(2, 3, 2, 250.00),(3, 1, 1, 800.00);



-- Single-row subqueries
SELECT c.customer_name, o.order_total FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id WHERE o.order_total=(SELECT MAX(order_total) FROM Orders);

-- Multi-row subauery
SELECT o.order_id, c.customer_name FROM Orders o INNER JOIN Customers c ON o.customer_id = c.customer_id WHERE c.state IN(SELECT state_abbreviation FROM States WHERE state_name = 'California');

-- correlated subqueries
SELECT o.order_id, c.customer_name, o.order_total FROM Orders o INNER JOIN Customers c ON o.customer_id=c.customer_id WHERE o.order_total>(SELECT AVG(order_total) FROM Orders WHERE customer_id = o.customer_id);

-- Joins with subqueries
SELECT e.employee_id, e.last_name FROM Employees e INNER JOIN Departments d ON e.department_id = d.department_id WHERE d.num_employees>(SELECT COUNT(*) FROM Employees WHERE department_id = d.department_id);

-- Joins with aggregate functions
SELECT p.category, SUM(oi.quantity * oi.price) AS total_sales FROM Products p INNER JOIN Order_Items oi ON p.product_id = oi.product_id INNER JOIN Orders o ON oi.order_id = o.order_id GROUP BY p.category;

-- Joins with date and time functions
SELECT o.order_id, c.customer_name, o.order_date FROM Orders o INNER JOIN Customers c ON o.customer_id = c.customer_id WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- RANK
SELECT e.employee_id, e.last_name, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank FROM Employees e;

-- DENSE_RANK
SELECT c.customer_id, c.customer_name, DENSE_RANK() OVER (ORDER BY order_count DESC) AS customer_rank FROM Customers c LEFT JOIN(SELECT customer_id, COUNT(*) AS order_count FROM Orders GROUP BY customer_id) o ON c.customer_id = o.customer_id;

-- ROW NUMBER
SELECT o.order_id, c.customer_name, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY order_date) AS order_number FROM Orders o INNER JOIN Customers c ON o.customer_id = c.CustomerID;

-- CUME DISTANCE
SELECT e.employee_id, e.last_name, e.salary,CUME_DIST() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_percentile FROM Employees e;

-- LAG
SELECT o.order_id, c.customer_name, o.order_total, LAG(o.order_total) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_total FROM Orders o INNER JOIN Customers c ON o.customer_id = c.customer_id;

SELECT o.order_id, c.customer_name, p.category, LEAD(p.category) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_category FROM Orders o INNER JOIN Order_Items oi ON o.order_id = oi.order_id INNER JOIN Products p ON oi.product_id = p.product_id INNER JOIN Customers c ON o.customer_id = c.customer_id;


-- SUBQUERIES:-

/* The single-row subquery returns one row. Multiple-row subqueries return sets of rows. 
These queries are commonly used to generate result sets that will be passed to a DML or SELECT statement for further processing. 
Both single-row and multiple-row subqueries will be evaluated once, before the parent query is run. 
"Single-row and multiple-row subqueries can be used in the WHERE and HAVING clauses of the parent query." */

/*CORELATED SUBQUERIES: SQL Correlated Subqueries are used to select data from a table referenced in the outer query.
The subquery is known as a correlated because the subquery is related to the outer query. In this type of queries,
 a table alias (also called a correlation name) must be used to specify which table reference is to be used.*/

# 1. RANK
-- RANK() gives a 'rank' to each row within a partition, based on an ordered set. If rows have the same value, they get the same rank. 
-- However, the ranks will have gaps when there are ties.

#2. DENSE_RANK
-- DENSE_RANK() is similar to RANK(), but it does not create gaps when there are ties. 
-- Rows with the same value will get the same rank, but the next rank will be consecutive.

#3. ROW_NUMBER
-- ROW_NUMBER() assigns a unique row number to each record in a partitioned or ordered set. 
-- This always gives unique numbers, even if there are ties.

#4. CUME_DIST
--  It shows the relative position of a row within a data set, indicating what fraction of the data set is at or below a particular value.
-- The value is always between 0 and 1.
-- The values which will have be closer to 0 will have better score and thus will be identified as being in top percentages

#5. LAG
-- The LAG() function provides access to a row at a specified physical offset prior to the current row within the partition.
-- It's often used to retrieve values from a previous row in the result set without using a self-join.
-- for example, you might use LAG() to retrieve the value of the previous row's amount.

-- 4. LEAD
-- The LEAD() function provides access to a row at a specified physical offset after the current row within the partition.
-- It's useful for fetching values from subsequent rows in the result set without a self-join.
-- For instance, you could use LEAD() to get the value of the next row's amount.

-- SUBQUERIES
# Question 1: Find the name of the customer who placed the order with the highest total amount.  
# Question 2: Retrieve the names of all customers who have placed orders for products located in the same city as the customer named "Rahul". 
# Question 3: Retrieve the names of all customers who have placed orders for products that have a price higher than the average price of products bought by each customer.

-- JOINS
# Question 4: Retrieve the names of customers who have placed orders for products with a price higher than the average price of all products in the same city as the customer, and also display the total amount spent by each customer on such orders.
# Question 5: Retrieve the names of all customers along with the total amount they have spent on orders, including customers who have not placed any orders yet.
# Question 6: Retrieve all customer details along with their corresponding order details, even if there are no corresponding orders, and display 'No order' instead of NULL. If there are no corresponding orders, also display the reason for no order (e.g., 'Out of stock').

-- Advance Functions
# Question 7: Retrieve the names of products along with their prices and the ranking of each product based on their prices, where the products are ranked in descending order of price.
# Question 8: Retrieve the names of products along with their prices and the dense ranking of each product based on their prices, where products are ranked in descending order of price.
# Question 9: Retrieve the names of products along with their prices and the row number of each product, where products are ordered by their prices in descending order.
# Question 10: Retrieve the names of products along with their prices and the cumulative distribution of each product's price, indicating what fraction of products have prices less than or equal to the price of each product.
# Question 11:  Retrieve the names of products along with their prices and the price of the previous product in the list, ordered by price in ascending order.
# Question 12:  Retrieve the names of products along with their prices and the price of the next product in the list, ordered by price in ascending order.

# Question 1
SELECT c.name FROM customer c INNER JOIN orders o ON c.id = o.customer_id ORDER BY o.total_amount DESC LIMIT 1;
-- This query finds the customer with the highest order total by:
-- Joining the customer and order tables on the customer_id.
-- Ordering the results by total_amount in descending order.
-- Limiting the results to 1 row, which will be the customer with the highest total.

# Question 2
SELECT c.name FROM customer c INNER JOIN orders o ON c.id = o.customer_id INNER JOIN product p ON o.product_id = p.id INNER JOIN customer rahul ON rahul.name = 'Rahul' WHERE p.city = rahul.city;
-- This query retrieves customers who ordered products in the same city as Rahul by:
-- Joining multiple tables:
-- customer and order on customer_id.
-- order and product on product_id.
-- A special case joining customer table with an alias (rahul) to filter by name.
-- Filtering for products with the same city as Rahul using the rahul.city alias.

# Question 3
SELECT c.name FROM customer c INNER JOIN orders o ON c.id = o.customer_id INNER JOIN product p ON o.product_id = p.id GROUP BY c.id HAVING AVG(p.price) < SUM(p.price) / COUNT(p.id);
-- This query finds customers who ordered products above their average order price by:
-- Joining customer, order, and product tables.
-- Grouping results by customer_id.
-- Using HAVING clause to filter customers where the average product price (AVG(p.price)) is less than the total price divided by the number of products ordered (SUM(p.price) / COUNT(p.id)).

# Question 4
WITH city_avg_price AS(SELECT city, AVG(price) AS avg_price FROM product GROUP BY city) SELECT c.name, SUM(o.total_amount) AS total_spent FROM customer c INNER JOIN orders o ON c.id = o.customer_id INNER JOIN product p ON o.product_id = p.id INNER JOIN city_avg_price cap ON p.city = cap.city WHERE p.price>cap.avg_price GROUP BY c.id;
-- This query retrieves customers who spent money on products exceeding the city's average price by:
-- Creating a Common Table Expression (CTE) named city_avg_price to calculate the average price per city.
-- Joining the customer, order, product, and city_avg_price tables.
-- Filtering for products exceeding the city's average price using the cap.avg_price alias from the CTE.
-- Grouping results by customer_id and summing the total amount spent.

# Question 5
SELECT c.name, COALESCE(SUM(o.total_amount), 0) AS total_spent FROM customer c LEFT JOIN orders o ON c.id = o.customer_id GROUP BY c.id;
-- This query retrieves all customers with their total spent, including those with no orders, by:
-- Using a LEFT JOIN between customer and order.
-- Using COALESCE to replace NULL values in SUM(o.total_amount) with 0 for customers with no orders.
-- Grouping by customer_id and summing the total amount spent.

# Question 6
SELECT c.name, c.address, c.phone, o.id AS order_id, o.total_amount,COALESCE(o.status, 'No order') AS order_status FROM customer c LEFT JOIN orders o ON c.id = o.customer_id;
-- This query retrieves all customer details with their corresponding order information, including those with no orders, by:
-- Using a LEFT JOIN between customer and order.
-- Using COALESCE to replace NULL values in o.id, o.total_amount, and o.status with specific values like 'No order' for missing orders.

# Question 7
SELECT name, price, RANK() OVER (ORDER BY price DESC) AS ranki FROM product ORDER BY price DESC;
-- This query uses the RANK() function to assign a rank to each product based on its price in descending order.

# Question 8
SELECT name, price, DENSE_RANK() OVER (ORDER BY price DESC) AS ranki FROM product ORDER BY price DESC;
-- This query uses the DENSE_RANK() function, which assigns ranks without gaps, even if there are ties in price.

# Question 9
SELECT name, price, ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num FROM product ORDER BY price DESC;
-- This query uses the ROW_NUMBER() function to assign a sequential number to each product based on the order (descending price in this case).

# Question 10
SELECT name,price,PERCENT_RANK() OVER (ORDER BY price) AS percentile FROM product;
-- This query uses the PERCENT_RANK() function to calculate the percentile for each product's price. This indicates the fraction of products with a price less than or equal to the current product's price.

# Question 11
WITH previous_price AS(SELECT name, price, LAG(price) OVER (ORDER BY price) AS prev_price FROM product)SELECT name, price, prev_price FROM previous_price WHERE prev_price IS NOT NULL ORDER BY price;
-- This query uses a Common Table Expression (CTE) and the LAG() function. It retrieves the previous product's price based on the order by price (ascending). We filter out the first row since it won't have a previous price.

# Question 12
WITH next_price AS(SELECT name, price, LEAD(price) OVER (ORDER BY price) AS next_price FROM product)SELECT name, price, next_price FROM next_price WHERE next_price IS NOT NULL ORDER BY price;
-- This query also uses a CTE and the LEAD() function. It retrieves the next product's price based on the order by price (ascending). We filter out the last row since it won't have a next price.