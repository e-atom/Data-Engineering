SELECT
    CONCAT(ds.FirstName, ' ', ds.LastName) AS CustomerName,
    SUM(fs.SalesAmount) AS TotalSales

FROM FactInternetSales fs 
    INNER JOIN DimCustomer ds 
    On fs.CustomerKey = ds.CustomerKey
    INNER JOIN DimCurrency dc 
    ON fs.CurrencyKey = dc.CurrencyKey
WHERE dc.CurrencyName = 'US Dollar'
GROUP BY  CONCAT(ds.FirstName, ' ', ds.LastName)
ORDER BY TotalSales DESC
