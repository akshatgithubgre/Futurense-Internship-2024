SELECT DISTINCT cname,addr FROM customer;

SELECT * FROM orders;

SELECT oid FROM orders;

SELECT * FROM customer WHERE cname LIKE "%Ra%";

SELECT * FROM customer WHERE cname LIKE "Ra%";

SELECT * FROM customer WHERE cname LIKE "%vi";

SELECT cid,cname,CASE WHEN cid > 102 THEN 'Pass' ELSE 'Fail' END AS 'Remark' FROM customer;

SELECT cid,cname,IF(cid > 102, 'Pass', 'Fail')AS 'Remark' FROM customer;

SELECT * FROM customer ORDER BY cid LIMIT 2;

SELECT * FROM customer WHERE cname = "Ravi";

/*
1) Write a query to retrieve the distinct locations of products from the products table.
2) Write a query to retrieve the customer ID, customer name, and the length of their address
   as address_length from the customer table.
3) Write a query to retrieve the order ID, customer name, product name, and the concatenated
   string 'Order for [product name] by [customer name]' as order_description from the orders, customer,
   and products tables.
4) Write a query to retrieve the product ID, product name, price, and a new column price_category that categorizes
   the products based on their price range (e.g., 'Low' for prices less than 10000, 'Medium' for prices between 10000
   and 50000, and 'High' for prices greater than 50000).
5) Write a query to retrieve the customer ID, customer name, and the total order amount for each customer.
   The total order amount should be retrieved from a subquery that calculates the sum of order amounts for each
   customer.
*/

SELECT DISTINCT location FROM products;

SELECT cid, cname, LENGTH(addr) AS address_length FROM customer;

SELECT o.oid, c.cname, p.pname, CONCAT('Order for ', p.pname, ' by ', c.cname) AS order_description FROM orders o JOIN customer c ON o.cid = c.cid JOIN products p ON o.pid = p.pid;

SELECT pid, pname, price,CASE WHEN price < 10000 THEN 'Low' WHEN price BETWEEN 10000 AND 50000 THEN 'Medium' ELSE 'High' END AS price_category FROM products;

SELECT c.cid, c.cname, (SELECT SUM(amt) FROM orders o WHERE o.cid = c.cid) AS total_order_amount;