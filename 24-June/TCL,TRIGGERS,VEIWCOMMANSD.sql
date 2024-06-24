create database ak;
use ak;

create table products(pid int(3) primary key,pname varchar(50) not null,price int(10) not null,stock int(5),location varchar(30) check(location in ('Mumbai','Delhi')));

create table customer(cid int(3) primary key,cname varchar(30) not null,age int(3),addr varchar(50));

create table orders(oid int(3) primary key,cid int(3),pid int(3),amt int(10) not null,foreign key(cid) references customer(cid),foreign key(pid) references products(pid));

create table payment(pay_id int(3) primary key,oid int(3),amount int(10) not null,mode varchar(30) check(mode in('upi','credit','debit')),status varchar(30),foreign key(oid) references orders(oid));

insert into products values(1,'HP Laptop',50000,15,'Mumbai');
insert into products values(2,'Realme Mobile',20000,30,'Delhi');
insert into products values(3,'Boat earpods',3000,50,'Delhi');
insert into products values(4,'Levono Laptop',40000,15,'Mumbai');
insert into products values(5,'Charger',1000,0,'Mumbai');
insert into products values(6, 'Mac Book', 78000, 6, 'Delhi');
insert into products values(7, 'JBL speaker', 6000, 2, 'Delhi');

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

commit;

rollback;

savepoint a;

rollback to a;

DELIMITER //
CREATE TRIGGER products_after_insert AFTER INSERT ON products FOR EACH ROW
BEGIN
  INSERT INTO product_log (pid,pname,price,stock,location,inserted_at) VALUES (NEW.pid,NEW.pname,NEW.price,NEW.stock,NEW.location,NOW());
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER orders_after_insert AFTER INSERT ON orders FOR EACH ROW
BEGIN
  UPDATE products
  SET stock=stock-1
  WHERE pid=NEW.pid;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER products_after_update AFTER UPDATE ON products FOR EACH ROW
BEGIN
  IF OLD.pid <> NEW.pid OR OLD.pname <> NEW.pname OR OLD.price <> NEW.price OR OLD.stock <> NEW.stock OR OLD.location <> NEW.location THEN
    INSERT INTO product_log (pid, pname, price, stock, location, updated_at)
    VALUES (OLD.pid, OLD.pname, OLD.price, OLD.stock, OLD.location, NOW());
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER products_after_delete AFTER DELETE ON products FOR EACH ROW
BEGIN
  DECLARE has_orders INT DEFAULT (0); 
  SELECT COUNT(*) INTO has_orders FROM orders WHERE pid=OLD.pid;
  IF has_orders>0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cannot delete product with existing orders. Update or delete orders first.';
  END IF;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER set_default_payment_status BEFORE INSERT ON payment FOR EACH ROW
BEGIN
  IF NEW.status IS NULL THEN SET NEW.status='Pending';
  END IF;
END //
DELIMITER ;


CREATE OR REPLACE VIEW active_customers_mumbai AS SELECT c.cid,c.cname,c.addr FROM customer c WHERE c.age>25 AND c.addr LIKE '%Mumbai%';

create view CustomerOrders as select c.cid, c.cname, o.oid, o.amt, p.pname from customer c join orders o on c.cid = o.cid join products p on o.pid = p.pid;

create view TotalOrdersByLocation as select p.location, p.pname, count(o.oid) as total_orders from products p join orders o on p.pid = o.pid group by p.location, p.pname;


create view OrderPaymentStatus as select o.oid, o.amt, p.mode, p.status from orders o join payment p on o.oid = p.oid;


DROP VIEW active_customers_mumbai;

drop view TotalOrdersByLocation;



# ------------------------------------------------Questions--------------------------------------------- 
/*
Tcl commands
1)Saving the command permently after running succesfully 
2)Going to previous command 
3)Going to a check point where you want to go after saving the checkpoint 

Triggers 
1) Trigger to update status in payment table after an order is completed:
2)Trigger to check stock availability before inserting an order:
3)Trigger to update stock after an order is placed:

Veiws
1)Create a view that displays the customers with their corresponding orders.
2)Create or Replace View to show payment details with order and customer information
3)Drop View if it exists
*/

-- 1)
DELIMITER //
CREATE TRIGGER update_payment_status AFTER UPDATE ON orders FOR EACH ROW
BEGIN
    IF NEW.status='completed' THEN UPDATE payment SET status='completed' WHERE oid = NEW.oid;
    END IF;
END //
DELIMITER ;


-- 2)
DELIMITER //
CREATE TRIGGER check_stock_before_order BEFORE INSERT ON orders FOR EACH ROW
BEGIN
    DECLARE available_stock INT;
    SELECT stock INTO available_stock FROM products WHERE pid=NEW.pid;
    IF available_stock < NEW.amt THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for this product';
    END IF;
END //
DELIMITER ;


-- 3)
DELIMITER //
CREATE TRIGGER update_stock_after_order AFTER INSERT ON orders FOR EACH ROW
BEGIN
    UPDATE products SET stock=stock-NEW.amt WHERE pid=NEW.pid;
END // 
DELIMITER ;


#Tcl commands

-- 1)
-- Inserting values into products table
start transaction;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
commit;



-- 2)
start transaction;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
rollback;



-- 3)
start transaction;
INSERT INTO products (pid, pname, price, stock, location) VALUES (8, 'iPhone 12', 79900, 10, 'Delhi');
INSERT INTO customer (cid, cname, age, addr) VALUES (106, 'John Doe', 35, '123 Main Street');
INSERT INTO orders (oid, cid, pid, amt) VALUES (1005, 106, 8, 79900);
INSERT INTO payment (pay_id, oid, amount, mode, status) VALUES (1, 1005, 79900, 'credit', 'completed');
SAVEPOINT A;
rollback TO A;


# Views
-- 1)
create view CustomerOrders as select c.cid, c.cname, o.oid, o.amt, p.pname from customer c join orders o on c.cid = o.cid join products p on o.pid = p.pid;


-- 2)
CREATE OR REPLACE VIEW payment_order_customer_details AS SELECT p.pay_id, p.oid, o.cid, c.cname, c.age, c.addr, p.amount, p.mode, p.status FROM payment p JOIN orders o ON p.oid = o.oid JOIN customer c ON o.cid = c.cid;


-- 3)
DROP VIEW IF EXISTS payment_order_customer_details;