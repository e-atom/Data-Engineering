-- 顧客タイプ件数
SELECT 
    Category,
    COUNT(Category)
FROM dimCustomer
GROUP BY Category

-- DimCustomer件数
SELECT
    COUNT(*)
FROM
dimCustomer
