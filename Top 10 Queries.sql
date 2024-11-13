select * from employee; /*get the complete data*/

ALTER TABLE employee
CHANGE COLUMN ï»¿Employee_Name Employee_Name varchar(50); /*Change the column name */

select Employee_Name, Salary from employee where Salary = (select max(Salary) from employee); /*Get the maximum salary of an employee*/

SELECT Employee_Name, EmpID, Salary
FROM employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;  /*Second Highest Salary from employee table*/

select e.Employee_Name, e.Salary, m.Employee_Name AS ManagerName, m.Salary AS ManagerSalary
FROM employee e
JOIN employee m ON e.EmpID = m.EmpID
WHERE e.Salary > m.Salary; /*USing inner join to find the employee salary greater than manager salary*/

SELECT * from sales;

SELECT Order_ID, COUNT(*)
FROM sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;  /*Check Duplicate Records in a table */

SELECT *
FROM sales
WHERE Order_ID IN (
    SELECT Order_ID
    FROM sales
    GROUP BY Order_ID
    HAVING COUNT(*) > 1
);  /* get all the duplicate records */


WITH DuplicateRecords AS (
    SELECT Order_ID, Product_ID, Customer_Name, Segment,
           ROW_NUMBER() OVER (PARTITION BY Order_ID ORDER BY Order_ID) AS row_num
    FROM sales
)
DELETE FROM sales
WHERE Row_ID IN (
    SELECT Row_ID
    FROM DuplicateRecords
    WHERE row_num > 1
); 











