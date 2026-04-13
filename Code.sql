USE classicmodels;
SELECT 
    country, COUNT(country) AS cnt
FROM
    customers
GROUP BY country
ORDER BY cnt DESC;


SELECT 
    productName, buyprice
FROM
    products p
WHERE
    buyPrice > (SELECT 
            AVG(buyPrice)
        FROM
            products);


SELECT 
    p.productLine,
    SUM(o.quantityOrdered * o.priceEach) AS Totalrevenue
FROM
    products p
        JOIN
    orderdetails o ON o.productCode = p.productCode
GROUP BY p.productLine;


SELECT 
    CONCAT(e.firstName, ' ', e.lastName) Employee_Name,
    COUNT(c.customerName) No_of_customers
FROM
    employees e
        JOIN
    customers c ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY employeeNumber , e.firstName , e.lastName
ORDER BY No_of_customers DESC;

SELECT 
    customerName,
    SUM(od.quantityOrdered * od.priceEach) AS Amount_spent
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber , c.customerName
ORDER BY Amount_spent DESC
LIMIT 3;


SELECT 
    productName, productDescription
FROM
    products
WHERE
    productCode NOT IN (SELECT 
            productCode
        FROM
            orderdetails);
            
SELECT 
    c.customerName Frequent_customers,
    COUNT(o.orderNumber) Orders_placed
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerName
HAVING Orders_placed > 3
ORDER BY Orders_placed DESC;  

SELECT 
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS Amount_spent,
    CASE
        WHEN SUM(od.quantityOrdered * od.priceEach) > 100000 THEN 'Platinum'
        WHEN SUM(od.quantityOrdered * od.priceEach) > 50000 THEN 'Gold'
        WHEN SUM(od.quantityOrdered * od.priceEach) > 20000 THEN 'Silver'
        ELSE 'Bronze'
    END AS premium_VIP_customers
FROM
    customers c
        JOIN
    orders o ON c.customerNumber = o.customerNumber
        JOIN
    orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY customerName
ORDER BY Amount_spent DESC;

SELECT 
    CONCAT(e.firstName, ' ', e.lastName) Employee_name,
    CONCAT(m.firstName, m.lastName) Manager_name
FROM
    employees e
	JOIN
    employees m ON m.employeeNumber = e.reportsTo;
    
CREATE  VIEW high_value_customers AS
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) Total_Order_Price FROM customers c 
JOIN orders o ON o.customerNumber=c.customerNumber
JOIN orderdetails od ON od.orderNumber=o.orderNumber
GROUP BY c.customerName
HAVING Total_Order_Price > 100000;

















            