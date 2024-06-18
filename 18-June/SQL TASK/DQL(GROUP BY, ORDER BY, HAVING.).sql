use sql_futurense_june;

SELECT cname, COUNT(*) AS Number FROM customer GROUP BY cname HAVING Number >= 1;

SELECT location, GROUP_CONCAT(DISTINCT pname) AS product_names FROM products GROUP BY location

SELECT pid, pname, price FROM products ORDER BY price ASC;

SELECT cid, cname, age FROM customer ORDER BY age DESC;

SELECT pid, pname, stock FROM products GROUP BY pid, pname, stock HAVING stock < 10;

SELECT location, SUM(stock) AS total_stock FROM products GROUP BY location HAVING SUM(stock) > 50;

/*
GROUP BY:
1) Write a query to find the total stock of products for each location.
2) Write a query to find the number of products in each price range (e.g., 0-10000, 10000-20000, 20000-50000, 50000+).
3) Write a query to find the average age of customers grouped by their location (based on the address).

ORDER BY:
1) Write a query to retrieve all products ordered by their price in descending order.
2) Write a query to retrieve all customers ordered by their age in ascending order.
3) Write a query to retrieve all orders ordered by the order amount in descending order
   and then by the customer name in ascending order.

HAVING:
1) Write a query to find the locations where the total stock of products is greater than 20.
2) Write a query to find the customers who have placed orders with a total amount greater than 10000.
3) Write a query to find the products that have a stock level between 10 and 20 and are located in Mumbai.
*/

SELECT location, SUM(stock) AS total_stock FROM products GROUP BY location;

SELECT CASE 
 WHEN price BETWEEN 0 AND 10000 THEN '0-10000' 
 WHEN price BETWEEN 10001 AND 20000 THEN '10000-20000'
 WHEN price BETWEEN 20001 AND 50000 THEN '20000-50000' 
 ELSE '50000+' 
 END AS price_range, COUNT(*) AS product_count
 FROM products 
 GROUP BY price_range;

SELECT SUBSTRING(addr, 1, 3) AS location, AVG(age) AS avg_age  FROM customer GROUP BY location;

SELECT * FROM products ORDER BY price DESC;

SELECT * FROM customer ORDER BY age ASC;

SELECT o.oid, c.cname, o.amt FROM orders o JOIN customer c ON o.cid = c.cid ORDER BY o.amt DESC, c.cname ASC;

SELECT location, SUM(stock) AS total_stock FROM products GROUP BY location HAVING SUM(stock) > 20;

SELECT c.cid, c.cname, SUM(o.amt) AS total_amount FROM customer c JOIN orders o ON c.cid = o.cid GROUP BY c.cid, c.cname HAVING SUM(o.amt) > 10000;

SELECT p.pid, p.pname, p.stock FROM products p WHERE p.location = 'Mumbai' GROUP BY p.pid, p.pname, p.stock HAVING p.stock BETWEEN 10 AND 20;