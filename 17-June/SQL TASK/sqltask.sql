create database amazon;

use amazon;

create table products(pid int(3) primary key,pname varchar(50) not null,price int(10) not null,stock int(5),location varchar(30) check(location in ('Mumbai','Delhi')));

create table customer(cid int(3) primary key,cname varchar(30) not null,age int(3),addr varchar(50));

create table orders(oid int(3) primary key,cid int(3),pid int(3),amt int(10) not null,foreign key(cid) references customer(cid),foreign key(pid) references products(pid));

create table payment(pay_id int(3) primary key,oid int(3),amount int(10) not null,mode varchar(30) check(mode in('upi','credit','debit')),status varchar(30),foreign key(oid) references orders(oid));

drop table products ;

drop database amazon;

alter table customer add phone varchar(10);
 
alter table customer drop column phone;

alter table orders rename column amt to amount;

ALTER TABLE orders CHANGE amt amount DECIMAL(10, 2);

alter table products modify column price varchar(10) ;

alter table products modify column location varchar(30) check(location in ('Mumbai','Delhi' , 'chennai')) ;

truncate table products;

alter table customer modify column age int(2) not null;

alter table customer modify column phone varchar(10) unique ;

alter table payment modify column status varchar(30) check( status in ('pending' , 'cancelled' , 'completed'));

alter table products modify column location varchar(30) default 'Mumbai' check(location in ('Mumbai','Delhi' , 'chennai')) ;

insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

insert into customer (cid, cname, age, addr) values
(101,'Ravi',30,'fdslfjl'),
(102,'Rahul',25,'fdslfjl'),
(103,'Simran',32,'fdslfjl'),
(104,'Purvesh',28,'fdslfjl'),
(105,'Sanjana',22,'fdslfjl');

insert into orders values(10001,102,3,2700);
insert into orders values(10002,104,2,18000);
insert into orders values(10003,105,5,900);
insert into orders values(10004,101,1,46000);


insert into payment values(1,10001,2700,'upi','completed');
insert into payment values(2,10002,18000,'credit','completed');
insert into payment values(3,10003,900,'debit','in process');

update product set locaiton='chennai' where pname='Mac Book' ;


delete from customer where cname='Ravi';

UPDATE employees SET salary=80000 WHERE id=1;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM employees WHERE id = 1;

SET SQL_SAFE_UPDATES = 1;


CREATE TABLE students(student_id INT PRIMARY KEY,name VARCHAR(100) NOT NULL,email VARCHAR(100) UNIQUE,age INT CHECK (age >= 18),course_id INT,grade CHAR(1) DEFAULT 'F');

CREATE TABLE courses(course_id INT PRIMARY KEY,course_name VARCHAR(100) NOT NULL);

ALTER TABLE students ADD CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES courses (course_id)ON DELETE CASCADE;

INSERT INTO students (student_id,name,email,age,course_id,grade) VALUES (1, 'Alice Johnson', 'alice@example.com', 21, 101, 'A'); 

INSERT INTO students (student_id,name,email,age,course_id,grade)VALUES(1,'Bob Smith','bob@example.com',22,102,'B');

INSERT INTO students (student_id,email,age,course_id,grade) VALUES (3, 'charlie@example.com', 19, 103, 'B');

INSERT INTO students (student_id,name,email,age,course_id,grade) VALUES(4,'David Brown','david@example.com',16,104,'C');  

SELECT * FROM products WHERE price>100 AND release_date>'2022-01-01';

UPDATE products SET price = 1100.00,last_updated=NOW() WHERE product_id = 1;

DELETE FROM products WHERE stock<100;