import pandas as pd
import sqlalchemy as sql
from sqlalchemy.engine import URL
import pyodbc as odbc

#Driver = ""
#ServerName = "prod-sql-cfieducation.database.windows.net"
#DatabaseName = "AdventureWorksDW"
#UserId = "BI_User"
#Password = "CFI123456789!"


connection = odbc.connect("Driver = {{ODBC Driver 17 for SQL Server}};"
                          "Server = prod-sql-cfieducation.database.windows.net;"
                          "Database = AdventureWorksDW;"
                          "uid= BI_User; pwd=CFI123456789!")


df = pd.read_sql_query("SELECT fs.SalesOrderNumber AS InvoiceNumber,\
                       fs.SalesOrderLineNumber AS InvoiceLineNumber,\
                       fs.OrderDate AS OrderDate,\
                       fs.SalesAmount AS SalesAmount,\
                       dcy.CurrencyName,\
                       fs.TaxAmt AS TaxAmount,\
                       fs.Freight AS FreightAmount,\
                       fs.OrderQuantity AS Quantity,\
                       dp.EnglishProductName AS ProductName,\
                       dpsc.EnglishProductSubcategoryName AS ProductSubCategory,\
                       dpc.EnglishProductCategoryName AS ProductCategory,\
                       dst.SalesTerritoryCountry,dst.SalesTerritoryRegion,\
                       dpy.EnglishPromotionName,dpy.EnglishPromotionType,\
                       dpy.EnglishPromotionCategory,\
                       'Web' AS Source\
                        FROM FactInternetSales AS fs\
                            INNER JOIN DimProduct AS dp\
                            ON fs.ProductKey = dp.ProductKey\
                                INNER JOIN DimProductSubcategory as dpsc\
            ON dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey\
            INNER JOIN DimProductCategory AS dpc\
            ON dpsc.ProductCategoryKey = dpc.ProductCategoryKey \
            INNER JOIN DimSalesTerritory AS dst \
            ON fs.SalesTerritoryKey = dst.SalesTerritoryKey\
            INNER JOIN DimPromotion as dpy\
            ON fs.PromotionKey = dpy.PromotionKey\
            INNER JOIN DimCurrency as dcy \
            ON fs.CurrencyKey = dcy.CurrencyKey\
        UNION\
        SELECT\
            fs.SalesOrderNumber AS InvoiceNumber,\
            fs.SalesOrderLineNumber AS InvoiceLineNumber,\
            fs.OrderDate AS OrderDate,\
            fs.SalesAmount AS SalesAmount,\
            dcy.CurrencyName,\
            fs.TaxAmt AS TaxAmount,\
            fs.Freight AS FreightAmount,\
            fs.OrderQuantity AS Quantity,\
            dp.EnglishProductName AS ProductName,\
            dpsc.EnglishProductSubcategoryName AS ProductSubCategory,\
            dpc.EnglishProductCategoryName AS ProductCategory,\
            dst.SalesTerritoryCountry,\
            dst.SalesTerritoryRegion,\
            dpy.EnglishPromotionName,\
            dpy.EnglishPromotionType,\
            dpy.EnglishPromotionCategory,\
            rs.ResellerName AS Source\
            FROM FactResellerSales AS fs\
            INNER JOIN DimProduct AS dp \
            ON fs.ProductKey = dp.ProductKey\
            INNER JOIN DimProductSubcategory as dpsc\
            ON dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey\
            INNER JOIN DimProductCategory AS dpc\
                ON dpsc.ProductCategoryKey = dpc.ProductCategoryKey\
            INNER JOIN DimSalesTerritory AS dst\
                ON fs.SalesTerritoryKey = dst.SalesTerritoryKey\
            INNER JOIN DimPromotion as dpy\
            ON fs.PromotionKey = dpy.PromotionKey\
            INNER JOIN DimCurrency as dcy \
            ON fs.CurrencyKey = dcy.CurrencyKey\
            INNER JOIN DimReseller as rs\
                ON fs.ResellerKey = rs.ResellerKey\
                    ORDER BY OrderDate DESC")




