SELECT
     pm.EnglishPromotionName AS Promo,
     dc.CurrencyName,
     SUM(fs.SalesAmount) AS Amt
    FROM FactResellerSales fs 
    INNER JOIN DimPromotion pm 
    ON fs.PromotionKey = pm.PromotionKey
    INNER JOIN DimCurrency dc 
    ON fs.CurrencyKey = dc.CurrencyKey
Where dc.CurrencyName = 'EURO' AND pm.EnglishPromotionName <> 'No Discount' AND pm.EnglishPromotionName NOT LIKE '%Volume%'
GROUP BY pm.EnglishPromotionName, dc.CurrencyName
ORDER BY Amt DESC
