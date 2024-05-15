-- User AdventureWorksDW;


--HighestPerformingProducts To LowestPerforming

SELECT

    pd.EnglishProductName AS ProductName,
    pd.Color AS ProductColor,
    ISNULL(pd.Size,'UNKWN') AS ProductSize,
    ISNULL(SUM(fs.SalesAmount),0) AS TotalSales

FROM FactInternetSales fs

RIGHT JOIN DimProduct pd
ON pd.ProductKey = fs.ProductKey

WHERE pd.[Status] = N'Current'

GROUP BY 
    pd.EnglishProductName, pd.Color, pd.Size
ORDER BY TotalSales DESC;