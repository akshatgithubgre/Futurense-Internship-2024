SELECT 5+3;
SELECT 5-3;
SELECT 5*3;
SELECT 5/3;
SELECT 5%3;
SELECT 5=5;
SELECT 5>3;
SELECT 3<5;
SELECT 5>=5;
SELECT 5<=6;
SELECT 5<>6;
SELECT 59 & 47;
SELECT 59 | 47;
SELECT 59 ^ 47;
SELECT 4!=6 AND 12>6;
SELECT 5>4 AND 10=6;
SELECT 'Hello' LIKE '%o';
SELECT 5 BETWEEN 1 AND 10;

/*
Arithmetic Operators:
1) Write a query to calculate the total revenue by adding the prices of all products in the products table.
2) Write a query to find the products whose price is divisible by 3 using the modulo operator (%).
3) Write a query to subtract the average price from the price of each product and display the result as 
   price_difference.
   
Comparison Operators:
1) Write a query to retrieve all products whose price is greater than or equal to 50000.
2) Write a query to find the customers whose age is not equal to 30.
3) Write a query to retrieve all orders where the order amount is less than or equal to 10000.

Bitwise Operators:
1) Explain the bitwise AND (&) operator with an example.
2) Explain the bitwise OR (|) operator with an example.
3) Explain the bitwise XOR (^) operator with an example.

Logical Operators:
1) Write a query to retrieve the products that are located in Mumbai and have a stock level greater than 10.
2) Write a query to find the customers who are either from Mumbai or have placed an order with an amount greater
   than 20000.
3) Write a query to retrieve the orders where the payment mode is not 'upi' and the status is 'completed'.
*/

# ANSWERS
-- Arithmetic Operators:
-- 1)
SELECT SUM(price) AS total_revenue FROM products;
-- 2)
SELECT * 
FROM products WHERE price % 3 = 0;
-- 3)
SELECT pid,pname,price,(price - (SELECT AVG(price) FROM products)) AS price_difference FROM products;

-- Comparison Operators:
-- 1)
SELECT*FROM products WHERE price >= 50000;
-- 2)
SELECT*FROM customer WHERE age != 30;
-- 3) 
SELECT*FROM orders WHERE amt <= 10000;

-- Bitwise Operators:
-- 1) The bitwise AND (&) operator performs a binary AND operation on each pair of corresponding bits in the operands.
--    For example, 5 & 3 in binary is 0101 & 0011 which results in 0001, which is the decimal value 1.
-- 2) The bitwise OR (|) operator performs a binary OR operation on each pair of corresponding bits in the operands.
--    For example, 5 | 3 in binary is 0101 | 0011 which results in 0111, which is the decimal value 7.
-- 3) The bitwise XOR (^) operator performs a binary XOR operation on each pair of corresponding bits in the operands.
--    For example, 5 ^ 3 in binary is 0101 ^ 0011 which results in 0110, which is the decimal value 6.

-- Logical Operators:
-- 1)
SELECT * FROM products WHERE location = 'Mumbai' AND stock > 10;
-- 2)
SELECT*FROM customer WHERE addr LIKE '%Mumbai%' OR (SELECT SUM(amt) FROM orders o WHERE o.cid = customer.cid) > 20000;
-- 3)
SELECT*FROM payment WHERE mode != 'upi' AND status = 'completed';