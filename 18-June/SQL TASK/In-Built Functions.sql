SELECT CHAR_LENGTH('Hello, World!');

SELECT ASCII('A');

SELECT ASCII('abc');

SELECT CONCAT('Hello', ' ','World');

SELECT INSTR('Hello, World!','o');

SELECT INSTR('Hello, World!','x');

SELECT LCASE('HELLO');

SELECT LOWER('SupPorT'); 

SELECT UCASE('hello');

SELECT UPPER('SupPorT');

SELECT SUBSTR('Hello, World!',8,5);

SELECT SUBSTR('Hello, World!',1,5);

SELECT LPAD('Hello',10,'*');

SELECT RPAD('Hello',10,'*');

SELECT TRIM('   Hello, World!   ');

SELECT RTRIM('   Hello, World!   ');

SELECT LTRIM('   Hello, World!   ');

SELECT CURRENT_DATE() AS today;

SELECT DATEDIFF('2023-05-10','2023-05-01') AS day_difference;

SELECT DATE('2023-05-01 12:34:56') AS result;

SELECT CURRENT_TIME() AS now;

SELECT LAST_DAY('2023-05-01') AS last_day_of_may;

SELECT SYSDATE() AS `Timestamp`;

SELECT ADDDATE('2023-05-01', INTERVAL 7 DAY) AS one_week_later;

SELECT AVG(price) AS avg_price FROM products;

SELECT COUNT(*) AS total_products FROM products;

SELECT POW(2, 3) AS result;

SELECT MIN(price) AS min_price FROM products;

SELECT MAX(stock) AS max_stock, location FROM products GROUP BY location;

SELECT ROUND(3.1416, 2) AS result;

SELECT ROUND(3.1416) AS result;

SELECT SQRT(25) AS result;

SELECT FLOOR(3.8) AS result;

SELECT FLOOR(-3.8) AS result;


# QUESTIONS TO PRACTICE
/* String Functions:

1) What is the purpose of the CONCAT() function in SQL? Give an example of how to use it.
2) Explain the difference between LCASE() and LOWER() functions. Which one would you prefer to use and why?
3) How would you extract a substring from the 5th position to the 10th position (inclusive) from the string "Hello, World!"?
4) What is the purpose of the LPAD() and RPAD() functions? Provide an example of how to use them.
5) Write a SQL query to trim both leading and trailing spaces from the string ' Hello, World! '.

Date and Time Functions:

1) What is the difference between CURRENT_DATE() and SYSDATE() functions?
2) How would you calculate the number of days between two dates, say '2023-06-15' and '2023-07-20'?
3) Explain the purpose of the LAST_DAY() function with an example.
4) Write a SQL query to add 3 months to the current date.
5) How would you extract the time component (hours, minutes, seconds) from a datetime value?

Numeric Functions:

1) What is the difference between AVG() and COUNT() functions? When would you use each of them?
2) Write a SQL query to calculate the square root of 144.
3) How would you round the number 3.14159 to two decimal places?
4) Explain the purpose of the MIN() and MAX() functions. Give an example of how to use them with the GROUP BY clause.
5) Write a SQL query to calculate the power of 2 raised to the 5th power. */


# ANSWERS
/*
String Functions:

1) The CONCAT() function is used to concatenate (combine) two or more string values.
   Example: SELECT CONCAT('Hello', ' ', 'World'); will output "Hello World".
2) Both LCASE() and LOWER() convert a string to lowercase letters. LOWER() is the standard SQL function,
   while LCASE() is a MySQL-specific alias. It's generally recommended to use LOWER() for better portability
   across different databases.
3) To extract a substring from the 5th position to the 10th position (inclusive) from "Hello, World!",
   you can use the SUBSTR() function: SELECT SUBSTR('Hello, World!', 5, 6); This will output "o, Wor".
4) The LPAD() function pads a string with a specified string on the left side to make it a certain length.
   RPAD() does the same but on the right side. Example: SELECT LPAD('Hello', 10, '*'); will output "*****Hello".
5) To trim both leading and trailing spaces from ' Hello, World! ', you can use the TRIM() function:
   SELECT TRIM(' Hello, World! '); This will output "Hello, World!".

Date and Time Functions:

1) CURRENT_DATE() returns the current date, while SYSDATE() returns the current date and time.
2) To calculate the number of days between '2023-06-15' and '2023-07-20', you can use the DATEDIFF() function:
   SELECT DATEDIFF('2023-07-20', '2023-06-15'); This will output 35.
3) The LAST_DAY() function returns the last day of the month for a given date.
   Example: SELECT LAST_DAY('2023-05-01'); will output "2023-05-31".
4) To add 3 months to the current date, you can use the ADDDATE() or DATE_ADD() function:
   SELECT ADDDATE(CURRENT_DATE(), INTERVAL 3 MONTH);
5) To extract the time component from a datetime value, you can use the TIME() function:
   SELECT TIME('2023-05-01 12:34:56'); This will output "12:34:56".

Numeric Functions:

1) AVG() calculates the average value of a set of values, while COUNT() returns the number of rows/values.
   AVG() is used to find the mean, and COUNT() is used to count the number of rows or non-null values.
2) To calculate the square root of 144, you can use the SQRT() function: SELECT SQRT(144); This will output 12.
3) To round the number 3.14159 to two decimal places, you can use the ROUND() function:
   SELECT ROUND(3.14159, 2); This will output 3.14.
4) The MIN() function returns the minimum value, and the MAX() function returns the maximum value in a group
   of values. Example with GROUP BY:
   SELECT MIN(price) AS min_price, MAX(price) AS max_price, category FROM products GROUP BY category;
5) To calculate the power of 2 raised to the 5th power, you can use the POW() function:
   SELECT POW(2, 5); This will output 32.
*/


-- String Functions:

 SELECT CONCAT('Hello', ' ', 'World');
 
 SELECT SUBSTR('Hello, World!', 5, 6); -- Output: "o, Wor"
 
 SELECT LPAD('Hello', 10, '*'); -- Output: "*****Hello"

SELECT TRIM(' Hello, World! ');

-- Date and Time Functions: 
SELECT DATEDIFF('2023-07-20', '2023-06-15');

SELECT LAST_DAY('2023-05-01'); -- LAST_DAY() returns the last day of the month for a given date.

SELECT ADDDATE(CURRENT_DATE(), INTERVAL 3 MONTH);

SELECT TIME('2023-05-01 12:34:56');
-- PRITNS THE TIME OUT OF COMPLETE DATETIME

-- Numeric Functions:

SELECT SQRT(144);

SELECT ROUND(3.14159, 2);

SELECT ROUND(3.14159, 2);

SELECT MIN(price) AS min_price, MAX(price) AS max_price, category FROM products GROUP BY category;

SELECT POW(2, 5);

