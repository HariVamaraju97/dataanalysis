SET SQL_SAFE_UPDATES = 0; /* To disable safety feature of delete and update */

select * from salesdata.sales; /* To get the complete data from the datset */

SELECT 
    SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) AS Missing_InvoiceNo,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS Missing_CustomerID
FROM salesdata.sales; /* Checking for missing values */

DELETE FROM salesdata.sales WHERE CustomerID IS NULL; /* Deleting the missing values data */

DELETE FROM salesdata.sales
WHERE InvoiceNo IN (
    SELECT InvoiceNo
    FROM (
        SELECT InvoiceNo, COUNT(*)
        FROM salesdata.sales
        GROUP BY InvoiceNo
        HAVING COUNT(*) > 1
    ) AS duplicates
);  /* Deleting the duplicates */

select * from salesdata.sales; /*Data verification after duplicates removal*/

/*UPDATE salesdata.sales
SET InvoiceDate = DATE(InvoiceDate);*/

UPDATE salesdata.sales
SET InvoiceDate = DATE(STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i')); /* Change the Date Format */

/*SELECT InvoiceDate, DATE(STR_TO_DATE(InvoiceDate, '%d-%m-%Y %H:%i')) AS DateOnly
FROM salesdata.sales;*/ 


SELECT *,
       (Quantity * UnitPrice) AS Total_Sales
FROM salesdata.sales; /* Get the total sales */

SELECT *,
       EXTRACT(YEAR FROM InvoiceDate) AS Year,
       EXTRACT(MONTH FROM InvoiceDate) AS Month,
       EXTRACT(DAY FROM InvoiceDate) AS Day
FROM salesdata.sales; /* Get the sales per year, per month and per day*/


SELECT CustomerID,
       SUM(Quantity * UnitPrice) AS Total_Spend,
       CASE 
           WHEN SUM(Quantity * UnitPrice) > 1000 THEN 'High-Value'
           ELSE 'Regular'
       END AS Customer_Segment
FROM salesdata.sales
GROUP BY CustomerID; /*Segment the customers based on the purchase made*/


SELECT StockCode, 
       Description,
       SUM(Quantity * UnitPrice) AS Total_Sales
FROM salesdata.sales
GROUP BY StockCode, Description
ORDER BY Total_Sales DESC
LIMIT 10; /*Top 10 Products by Sales*/

SELECT EXTRACT(YEAR FROM InvoiceDate) AS Year,
       EXTRACT(MONTH FROM InvoiceDate) AS Month,
       SUM(Quantity * UnitPrice) AS Total_Sales
FROM salesdata.sales
GROUP BY Year, Month
ORDER BY Year, Month; /*Monthly Sales Trends*/

SELECT Country,
       SUM(Quantity * UnitPrice) AS Total_Sales
FROM salesdata.sales
GROUP BY Country
ORDER BY Total_Sales DESC
LIMIT 5; /*Top 5 Countries by Sales*/


SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS Number_of_Purchases,
       SUM(Quantity * UnitPrice) AS Total_Spend
FROM salesdata.sales
GROUP BY CustomerID
ORDER BY Total_Spend DESC
LIMIT 5; /*Most Frequent Customers*/
