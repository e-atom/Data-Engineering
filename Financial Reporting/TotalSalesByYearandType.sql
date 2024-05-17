--Product The total Sales by Year, Month, Country and Product Categories
WITH Totalsales AS (
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
    
    dst.SalesTerritoryCountry,
    dst.SalesTerritoryRegion,
    
    dpy.EnglishPromotionName,
    dpy.EnglishPromotionType,
    dpy.EnglishPromotionCategory
    
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
    
    dst.SalesTerritoryCountry,
    dst.SalesTerritoryRegion,
    
    dpy.EnglishPromotionName,
    dpy.EnglishPromotionType,
    dpy.EnglishPromotionCategory
    
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
)

SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SalesTerritoryCountry AS Country,
    ProductCategory,
    ProductSubCategory,
    SUM(SalesAmount) AS TotalSalesAmount,
    CurrencyName

FROM Totalsales
GROUP BY YEAR(OrderDate), MONTH(OrderDate),ProductCategory, SalesTerritoryCountry, ProductSubCategory, CurrencyName
ORDER BY TotalSalesAmount DESC, ProductCategory
    