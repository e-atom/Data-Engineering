-- USE AdventureWorksDW

/*A Table that represents the Total amount by top 100 customers in the US */
--

SELECT TOP 100
    CONCAT(c.FirstName, ' ',c.LastName) AS Fullname,
    c.EmailAddress,
    cu.CurrencyName as Currency,
    SUM(fs.SalesAmount) AS SalesAmount
 FROM DimCustomer c 
 INNER JOIN FactInternetSales fs 
 ON c.CustomerKey = fs.CustomerKey
 INNER JOIN DimCurrency cu
 ON fs.CurrencyKey = cu.CurrencyKey
WHERE cu.CurrencyName = 'US Dollar'
 GROUP BY 
    c.FirstName, 
    c.LastName, 
    c.EmailAddress,
    cu.CurrencyName

 ORDER BY SalesAmount DESC;






