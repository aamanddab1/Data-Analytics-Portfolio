-- Adventure Works Sales Analysis
-- Author: Amanda Bullock
-- Purpose: Analyze reseller sales performance across products and regions,
--          identify top-performing products and regions, and compare actual sales.

-- 1. Preview tables to understand structure
SELECT TOP 10 * FROM Products;
SELECT TOP 10 * FROM Sales;
SELECT TOP 10 * FROM Region;

-- 2. Combine Sales with Region table
SELECT 
    s.SalesOrderNumber,
    s.OrderDate,
    r.Region,
    r.Country,
    s.Sales
FROM Sales s
INNER JOIN Region r
    ON s.SalesTerritoryKey = r.SalesTerritoryKey;

-- 3. Combine Sales with Products table
SELECT 
    s.SalesOrderNumber,
    s.OrderDate,
    p.Subcategory,
    p.Category,
    s.Sales
FROM Sales s
INNER JOIN Products p
    ON s.ProductKey = p.ProductKey;

-- 4. Combine Sales with both Products and Region tables
SELECT 
    s.SalesOrderNumber,
    s.OrderDate,
    r.Region,
    r.Country,
    p.Subcategory,
    p.Category,
    s.Sales
FROM Sales s
INNER JOIN Region r
    ON s.SalesTerritoryKey = r.SalesTerritoryKey
INNER JOIN Products p
    ON s.ProductKey = p.ProductKey;

-- 5. Produce a total sales per region table
SELECT 
    r.Region,
    r.Country,
    SUM(s.Sales) AS TotalSales
FROM Sales s
INNER JOIN Region r
    ON s.SalesTerritoryKey = r.SalesTerritoryKey
GROUP BY r.Region, r.Country
ORDER BY TotalSales DESC;

-- 6. Produce a total sales per product category table
SELECT 
    p.Category,
    SUM(s.Sales) AS TotalSales
FROM Sales s
INNER JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY TotalSales DESC;

-- 7. Produce a total sales per product table
SELECT 
    p.ProductName,
    SUM(s.Sales) AS TotalSales
FROM Sales s
INNER JOIN Products p
    ON s.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY TotalSales DESC;