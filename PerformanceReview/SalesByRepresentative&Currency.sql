SELECT 
    
    CONCAT(ep.FirstName,' ', ep.LastName) AS EmployeeName,
    ep.Title AS EmployeeTitle,
    dc.CurrencyName,
    SUM(SalesAmount) AS TotalSalesAmount

 FROM FactResellerSales fs 
    INNER JOIN DimEmployee ep 
    ON fs.EmployeeKey = ep.EmployeeKey
    INNER JOIN DimCurrency dc 
    ON fs.CurrencyKey = dc.CurrencyKey
    INNER JOIN DimSalesTerritory dst 
    ON fs.SalesTerritoryKey = dst.SalesTerritoryKey

WHERE dst.SalesTerritoryGroup = 'Europe' AND ep.Status = 'Current'
GROUP BY CONCAT(ep.FirstName,' ', ep.LastName) , ep.Title ,dc.CurrencyName
ORDER BY EmployeeName, TotalSalesAmount DESC