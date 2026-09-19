-- CREATE DATABASE --

CREATE DATABASE data_digger_db;

SELECT DATABASE();

USE data_digger_db;


-- 1. CUSTOMERS TABLE --

-- Create Table --

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(200)
);


-- Insert 5 Sample Customers --

INSERT INTO Customers
(CustomerID, Name, Email, Address)
VALUES
(1, 'Alice', 'alice@gmail.com', 'Surat, Gujarat'),
(2, 'Rahul', 'rahul@gmail.com', 'Navsari, Gujarat'),
(3, 'Priya', 'priya@gmail.com', 'Valsad, Gujarat'),
(4, 'John', 'john@gmail.com', 'Mumbai, Maharashtra'),
(5, 'Neha', 'neha@gmail.com', 'Ahmedabad, Gujarat');


-- Retrieve all customers --

SELECT * FROM Customers;


-- Update customer address using Customer_ID --

UPDATE Customers
SET Address = 'Chikhli, Gujarat'
WHERE CustomerID = 2;


SELECT * FROM Customers;


-- Delete customer using CustomerID --

DELETE FROM Customers
WHERE CustomerID = 5;


SELECT * FROM Customers;


-- Display customers whose name is Alice --

SELECT *
FROM Customers
WHERE Name = 'Alice';


-- 2. ORDERS TABLE --

-- Create Table --

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);


-- Insert 5 Sample Orders --

INSERT INTO Orders
(OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, '2026-09-15', 4500.00),
(102, 2, '2026-09-10', 1200.00),
(103, 1, '2026-09-01', 2500.00),
(104, 3, '2026-08-25', 800.00),
(105, 4, '2026-08-20', 3200.00);


SELECT * FROM Orders;


-- Retrieve orders made by a specific customer --

SELECT *
FROM Orders
WHERE CustomerID = 1;


-- Update order total amount --

UPDATE Orders
SET TotalAmount = 4700.00
WHERE OrderID = 101;


SELECT * FROM Orders;


-- Delete order using OrderID --

DELETE FROM Orders
WHERE OrderID = 105;


SELECT * FROM Orders;


-- Retrieve orders placed in last 30 days --

SELECT *
FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;


-- Highest, Lowest and Average Order Amount --

SELECT
    MAX(TotalAmount) AS Highest_Amount,
    MIN(TotalAmount) AS Lowest_Amount,
    AVG(TotalAmount) AS Average_Amount
FROM Orders;


-- 3. PRODUCTS TABLE --

-- Create Table --

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);


-- Insert Sample Products --

INSERT INTO Products
(ProductID, ProductName, Price, Stock)
VALUES
(201, 'Laptop', 55000.00, 10),
(202, 'Smartphone', 25000.00, 20),
(203, 'Headphones', 1500.00, 50),
(204, 'Smart Watch', 3500.00, 15),
(205, 'Keyboard', 1200.00, 30),
(206, 'Mouse', 800.00, 25);


SELECT * FROM Products;


-- Sort products by price descending --

SELECT *
FROM Products
ORDER BY Price DESC;


-- Update price of a product --

UPDATE Products
SET Price = 1400.00
WHERE ProductID = 203;


SELECT * FROM Products;


-- Delete product if it is out of stock --

DELETE FROM Products
WHERE Stock = 0;


SELECT * FROM Products;


-- Products between ₹500 and ₹2000 --

SELECT *
FROM Products
WHERE Price BETWEEN 500 AND 2000;


-- Most expensive and cheapest product --

SELECT
    MAX(Price) AS Most_Expensive,
    MIN(Price) AS Cheapest
FROM Products;


-- 4. ORDER_DETAILS TABLE --

-- Create Table --

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);


-- Insert Sample Records --

INSERT INTO OrderDetails
(OrderDetailID, OrderID, ProductID, Quantity, SubTotal)
VALUES
(1, 101, 203, 2, 2800.00),
(2, 101, 205, 1, 1200.00),
(3, 102, 202, 1, 25000.00),
(4, 102, 206, 2, 1600.00),
(5, 103, 204, 1, 3500.00),
(6, 103, 203, 3, 4200.00),
(7, 104, 206, 2, 1600.00);


SELECT * FROM OrderDetails;


-- Retrieve order details for a specific order --

SELECT *
FROM OrderDetails
WHERE OrderID = 101;


-- Calculate total revenue using SUM() --

SELECT SUM(TotalAmount) AS Total_Revenue
FROM Orders;


-- Top 3 most ordered products --

SELECT
    ProductID,
    SUM(Quantity) AS Total_Quantity
FROM OrderDetails
GROUP BY ProductID
ORDER BY Total_Quantity DESC
LIMIT 3;


-- Count how many times a specific product was sold --

SELECT
    ProductID,
    COUNT(*) AS Times_Sold
FROM OrderDetails
WHERE ProductID = 203
GROUP BY ProductID;


-- Customer + Order details --

-- EXTRA QUERY --

SELECT
    c.CustomerID,
    c.Name,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID;