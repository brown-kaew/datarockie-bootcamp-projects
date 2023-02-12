-- Restaurant Owners
-- 5 Tables
-- 1x Fact, 4x Dimension
-- search google, how to add foreign key
-- write SQL 3-5 queries analyze data
-- 1x subquery/ with

-- sqlite command
.mode markdown
.header on 

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  order_id INT PRIMARY KEY NOT NULL,
  order_date DATE,
  quantity INT,
  menu_id INT,
  customer_id INT,
  payment_id INT,
  FOREIGN KEY (menu_id) REFERENCES Menus(menu_id),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (payment_id) REFERENCES Payments(payment_id)
);
INSERT INTO Orders VALUES 
(1, '2021-04-11', 2, 1, 2, 1),
(2, '2021-04-11', 1, 1, 2, 1),
(3, '2021-04-19', 1, 2, 1, 1),
(4, '2021-04-19', 1, 3, 2, 2),
(5, '2021-04-19', 1, 4, 1, 1),
(6, '2021-04-22', 1, 3, 2, 2);


DROP TABLE IF EXISTS Menus;
CREATE TABLE Menus (
  menu_id INT PRIMARY KEY NOT NULL,
  name VARCHAR(50),
  price REAL,
  res_id INT,
  FOREIGN KEY (res_id) REFERENCES Restaurants(res_id)
);
INSERT INTO Menus VALUES 
(1, 'Cacoa', 108.00, 1),
(2, 'Boba milk tea', 139.00, 1),
(3, 'Pad Thai', 199.00, 2),
(4, 'Tom Yum Kung', 300.00, 2);

DROP TABLE IF EXISTS Restaurants;
CREATE TABLE Restaurants (
  res_id INT PRIMARY KEY NOT NULL,
  name VARCHAR(50)
);
INSERT INTO Restaurants VALUES 
(1, 'Boba Cha'),
(2, 'Thai street');

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50)
);
INSERT INTO Customers VALUES 
(1, 'John', 'Melon'),
(2, 'Leena', 'Mavel');

DROP TABLE IF EXISTS Payments;
CREATE TABLE Payments (
  payment_id INT PRIMARY KEY NOT NULL,
  source_of_fund VARCHAR(50)
);
INSERT INTO Payments VALUES 
(1, 'BANK'),
(2, 'CASH');



-- most pricy food
SELECT name, price
FROM Menus
WHERE price = (SELECT MAX(price)
                FROM Menus);

-- total spending by customer on 2021-04-19
SELECT 
  cus.first_name || ' ' || cus.last_name as full_name,
  ROUND(SUM(ord.quantity * men.price), 2) AS total_spend
FROM Orders ord
JOIN Customers cus ON ord.customer_id = cus.customer_id
JOIN Menus men ON ord.menu_id = men.menu_id
WHERE ord.order_date = '2021-04-19'
GROUP BY full_name
ORDER BY total_spend DESC;

-- total_amount by sof
SELECT 
  pay.source_of_fund, 
  ROUND(SUM(ord.quantity * men.price), 2) AS total_amount
FROM Orders ord
JOIN Payments pay ON ord.payment_id = pay.payment_id
JOIN Menus men ON ord.menu_id = men.menu_id
GROUP BY pay.source_of_fund
ORDER BY total_amount DESC;

-- popular menu
SELECT 
  menu_name, 
  COUNT(menu_name) AS total_orders
FROM (
  SELECT
    ord.order_date,
    res.name AS restaurants_name,
    men.name AS menu_name
  FROM Orders ord
  JOIN Menus men ON ord.menu_id = men.menu_id
  JOIN Restaurants res ON res.res_id = men.res_id
) AS sub
GROUP BY menu_name
ORDER BY COUNT(menu_name) DESC, menu_name;

WITH order_sub AS (
SELECT
  ord.order_date,
  res.name AS restaurants_name,
  men.name AS menu_name
FROM Orders ord
JOIN Menus men ON ord.menu_id = men.menu_id
JOIN Restaurants res ON res.res_id = men.res_id
)
--popular restaurant
SELECT 
  restaurants_name, 
  COUNT(restaurants_name) AS total_orders
FROM order_sub
GROUP BY restaurants_name
ORDER BY COUNT(restaurants_name) DESC, restaurants_name;
