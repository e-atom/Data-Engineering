-- データベース内のテーブル件数
SELECT
      COUNT(table_name) NrOfTables

FROM
    INFORMATION_SCHEMA.TABLES


-- テーブルごとの列件数
SELECT 
    table_name name,
    COUNT(COLUMN_NAME) AS TotalColumns
FROM
    INFORMATION_SCHEMA.COLUMNS
GROUP BY TABLE_NAME
ORDER BY TotalColumns DESC

-- データベース内のテーブル情報
SELECT 
    table_catalog [database], 
    table_schema [schema], 
    table_name name, 
    table_type type
FROM 
    INFORMATION_SCHEMA.TABLES


