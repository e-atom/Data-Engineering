WITH TotalSales AS (
    -- Develop the Total Internet Sales Table

SELECT 
    fs.SalesOrderNumber AS InvoiceNumber,
    fs.SalesOrderLineNumber AS InvoiceLineNumber,
    fs.OrderDate AS OrderDate,
    fs.SalesAmount AS SalesAmount,
    fs.TaxAmt AS TaxAmount,
    fs.Freight AS FreightAmount,
    fs.OrderQuantity AS Quantity,

    dcy.CurrencyName AS Currency,

    dp.EnglishProductName AS ProductName,

    dpc.EnglishProductCategoryName AS ProductCategory,
    
    dpsc.EnglishProductSubcategoryName AS ProductSubCategory,
  
    
    dst.SalesTerritoryCountry AS Country,
    dst.SalesTerritoryRegion AS Region,
    
    dpy.EnglishPromotionName AS PromotionName,
    dpy.EnglishPromotionType AS PromotionType,
    dpy.EnglishPromotionCategory AS PromotionCategory
    
FROM FactInternetSales AS fs
    INNER JOIN DimProduct AS dp 
    ON fs.ProductKey = dp.ProductKey
    INNER JOIN DimProductSubcategory as dpsc
    ON dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey
    INNER JOIN DimProductCategory AS dpc 
    ON dpsc.ProductCategoryKey = dpc.ProductCategoryKey
    INNER JOIN DimSalesTerritory AS dst 
    ON fs.SalesTerritoryKey = dst.SalesTerritoryKey
    INNER JOIN DimPromotion as dpy
    ON fs.PromotionKey = dpy.PromotionKey
    INNER JOIN DimCurrency as dcy 
    ON fs.CurrencyKey = dcy.CurrencyKey

)

SELECT TOP(5)
    ProductSubCategory,
    SUM(SalesAmount) AS TotalSales
FROM TotalSales
WHERE Country = 'United States' AND Currency = 'US Dollar'
GROUP BY ProductSubCategory
ORDER BY TotalSales DESC
