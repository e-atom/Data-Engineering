-- Buying groupごとの顧客件数
SELECT 
    [Buying Group],
    --[Postal Code],
     COUNT(Customer)
FROM dimCustomer
GROUP BY [Buying Group]


--同じ郵便番号に３店舗以上
SELECT 
    [Postal Code],
     COUNT(Customer) AS NrOfStores
FROM dimCustomer
GROUP BY [Postal Code]
HAVING COUNT(Customer) >3
ORDER BY NrOfStores DESC

SELECT 
    [Postal Code]
    ,Customer 
FROM dimCustomer
WHERE [Postal Code] = '90683'
