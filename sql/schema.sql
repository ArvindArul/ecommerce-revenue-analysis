CREATE DATABASE retail_analysis;
GO

USE retail_analysis;
GO

-- Create Table
CREATE TABLE online_retail (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(MAX),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    Revenue DECIMAL(12,2),
    Year INT,
    Month INT
);
GO