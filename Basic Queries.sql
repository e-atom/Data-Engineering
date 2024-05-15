-- USE AdventureWorksDW

/*A Table that represents the top 100 customers which purchases from us */
--

SELECT TOP 100
    CONCAT(c.FirstName, ' ',c.LastName) AS Fullname,
    c.EmailAddress,
    SUM(fs.SalesAmount) AS SalesAmount
 FROM DimCustomer c 
 INNER JOIN FactInternetSales fs 
 ON c.CustomerKey = fs.CustomerKey
 GROUP BY 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress
 ORDER BY SalesAmount DESC;






