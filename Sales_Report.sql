CREATE DATABASE SalesDB;

USE SalesDB;
CREATE TABLE Products(
	ProductID INT PRIMARY KEY,
	Product_Name VARCHAR(255),
	Category VARCHAR(255)
	);

CREATE TABLE Sales (
	SaleID INT PRIMARY KEY,
	ProductID INT,
	Quantity INT,
	Price FLOAT,
	Sale_Date DATE
	FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
	);
DROP TABLE Sales;
INSERT INTO Products (ProductID, Product_Name, Category) VALUES
(101, 'Wireless Mouse', 'Electronics'),
(102, 'Bluetooth Speaker', 'Electronics'),
(103, 'Yoga Mat', 'Fitness'),
(104, 'Running Shoes', 'Footwear'),
(105, 'Coffee Mug', 'Kitchen'),
(106, 'LED Monitor', 'Electronics'),
(107, 'Water Bottle', 'Fitness'),
(108, 'Laptop Stand', 'Office'),
(109, 'Desk Lamp', 'Office'),
(110, 'Smartphone Case', 'Accessories');

INSERT INTO Sales (SaleID, ProductID, Quantity, Price, Sale_Date) VALUES
(1, 101, 2, 750.00, '2025-09-10'),
(2, 102, 1, 1200.00, '2025-09-10'),
(3, 103, 3, 400.00, '2025-09-11'),
(4, 104, 1, 2500.00, '2025-09-11'),
(5, 105, 4, 150.00, '2025-09-12'),
(6, 106, 1, 8500.00, '2025-09-12'),
(7, 107, 2, 300.00, '2025-09-13'),
(8, 108, 1, 1800.00, '2025-09-13'),
(9, 109, 2, 950.00, '2025-09-14'),
(10, 110, 5, 200.00, '2025-09-14');

SELECT * FROM Sales;
SELECT * FROM Products;

/*1. Daily sales for a particular product*/

SELECT s.Sale_Date,
		SUM(s.Quantity* s.Price) as Sale_Total
		FROM Sales s
		JOIN Products p ON s.ProductID = p.ProductID
		WHERE p.Category = 'Electronics'
		GROUP BY Sale_Date
		ORDER BY Sale_Date

/*2. Average Transaction value for a recent sales*/

SELECT Sale_Date,
		COUNT(SaleID),
		ROUND(SUM(Quantity * Price) / COUNT(SaleID), 2) AS avg_transaction_value
	FROM Sales
	WHERE Sale_Date >= '2025-09-07' AND Sale_Date <= '2025-09-14'
	GROUP BY Sale_Date
	ORDER BY Sale_Date DESC;

/*3. Top Products by revenue*/

SELECT TOP 10
    p.Product_Name,
    p.Category,
    SUM(s.Quantity) AS total_units_sold,
    SUM(s.Quantity * s.Price) AS total_revenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Product_Name, p.Category
ORDER BY total_revenue DESC;
 

