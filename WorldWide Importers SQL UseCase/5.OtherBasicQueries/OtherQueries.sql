--SalesPeople vs 従業員を把握する
SELECT 
    [Is Salesperson],
    COUNT(*)
FROM
dimEmployee
WHERE [Employee] <>'Unknown'
GROUP BY [Is Salesperson]

--人口多いテリトリー
SELECT 
    [Sales Territory],
    COUNT([Sales Territory]) AS Total
FROM
dimCity
GROUP BY [Sales Territory]
ORDER BY Total DESC

SELECT     
    City,
    SUM([Latest Recorded Population]) AS Total_Population
FROM dimCity
WHERE [Sales Territory]='Southeast'
GROUP BY City
ORDER BY Total_Population DESC

--すべての人口
SELECT     
    SUM([Latest Recorded Population]) AS Total_Population
FROM dimCity


