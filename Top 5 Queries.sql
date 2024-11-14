select * from employee; /*get the complete data*/

/*Changed the column name as it was not matching with the dataset*/

ALTER TABLE employee
CHANGE COLUMN ï»¿Employee_Name Employee_Name varchar(50); /*Change the column name */

/*SQL Query to get the maximum salary of an employee*/

select Employee_Name, Salary from employee where Salary = (select max(Salary) from employee); /*Get the maximum salary of an employee*/

/*SQL Query to get the 2nd maximum salary of an employee*/

SELECT Employee_Name, EmpID, Salary
FROM employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;  /*Second Highest Salary from employee table*/

/*Query to fetch the employee salary greater than the manager salary*/

select e.Employee_Name, e.Salary, m.Employee_Name AS ManagerName, m.Salary AS ManagerSalary
FROM employee e
JOIN employee m ON e.EmpID = m.EmpID
WHERE e.Salary > m.Salary; /*USing inner join to find the employee salary greater than manager salary*/

/*Used Sales Dataset for next 2 queries*/

SELECT * from sales;

/*Check single row duplicate records in a table*/

SELECT Order_ID, COUNT(*)
FROM sales
GROUP BY Order_ID
HAVING COUNT(*) > 1;  /*Check Duplicate Records in a table */

/*Check the complete duplicate records in a table*/

SELECT *
FROM sales
WHERE Order_ID IN (
    SELECT Order_ID
    FROM sales
    GROUP BY Order_ID
    HAVING COUNT(*) > 1
);  /* get all the duplicate records */


/*Remove a single duplicate record from the table*/

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











