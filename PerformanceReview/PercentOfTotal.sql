WITH TotalSales AS (
    -- Develop the Total Internet Sales Table
SELECT 
    fs.SalesOrderNumber AS InvoiceNumber,
    fs.SalesOrderLineNumber AS InvoiceLineNumber,
    fs.OrderDate AS OrderDate,
    fs.SalesAmount AS SalesAmount,
    
    dcy.CurrencyName,
    
    fs.TaxAmt AS TaxAmount,
    fs.Freight AS FreightAmount,
    fs.OrderQuantity AS Quantity,

    dp.EnglishProductName AS ProductName,
    
    dpsc.EnglishProductSubcategoryName AS ProductSubCategory,
    dpc.EnglishProductCategoryName AS ProductCategory,
    
    dst.SalesTerritoryCountry AS Country,
    dst.SalesTerritoryRegion AS Region,
    
    dpy.EnglishPromotionName,
    dpy.EnglishPromotionType,
    dpy.EnglishPromotionCategory,
    'Web' AS Source
    
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

UNION

-- Add the Total Resellers Sales Table
SELECT 
    fs.SalesOrderNumber AS InvoiceNumber,
    fs.SalesOrderLineNumber AS InvoiceLineNumber,
    fs.OrderDate AS OrderDate,
    fs.SalesAmount AS SalesAmount,
    
    dcy.CurrencyName,
    
    fs.TaxAmt AS TaxAmount,
    fs.Freight AS FreightAmount,
    fs.OrderQuantity AS Quantity,

    dp.EnglishProductName AS ProductName,
    
    dpsc.EnglishProductSubcategoryName AS ProductSubCategory,
    dpc.EnglishProductCategoryName AS ProductCategory,
    
    dst.SalesTerritoryCountry AS Country,
    dst.SalesTerritoryRegion AS Region,
    
    dpy.EnglishPromotionName,
    dpy.EnglishPromotionType,
    dpy.EnglishPromotionCategory,
    rs.ResellerName AS Source
    
FROM FactResellerSales AS fs
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
    INNER JOIN DimReseller as rs 
    ON fs.ResellerKey = rs.ResellerKey

)


SELECT
    Source AS Reseller,
    SUM(SalesAmount) AS Sales,
    SUM(SalesAmount) /(SELECT SUM(SalesAmount) FROM TotalSales WHERE Country = N'United States' AND Source <> 'Web') AS PctofTotal
FROM TotalSales
WHERE Country = N'United States' AND Source <> 'Web'
GROUP BY Source
ORDER BY Sales DESC

