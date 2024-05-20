--商品テーブル件数
SELECT [Stock Item], MIN([Unit Price]), [Quantity Per Outer]
FROM dimStockItem
WHERE [Stock Item] NOT LIKE '%box%' AND [Stock Item] NOT LIKE  '%bag%' AND [Stock Item] NOT LIKE  '%carton%'
GROUP BY [Quantity Per Outer], [Stock Item]
ORDER BY MIN([Unit Price]) , [Quantity Per Outer] DESC


-- Mug or Shirtという商品名は何件ありますか
SELECT COUNT([Stock Item])
FROM dimStockItem
WHERE [Stock Item] LIKE '%mug%' OR [Stock Item] LIKE  '%shirt%' 

SELECT * FROM dimStockItem

-- 色は黒いとMugかShirtという商品名は何件ありますか
SELECT COUNT([Stock Item])
FROM dimStockItem
WHERE ([Stock Item] LIKE '%mug%' OR [Stock Item] LIKE  '%shirt%') AND Color = 'Black'


-- 指定された条件を利用し、一番安い商品IDはなんですか。
SELECT [WWI Stock Item ID], [Stock Item], [Unit Price]
FROM dimStockItem
WHERE ([Stock Item] LIKE '%mug%' OR [Stock Item] LIKE  '%shirt%') AND Color = N'Black'
ORDER BY [Unit Price] ASC



-- 商品ID２９の値上げはなんですか、
SELECT [WWI Stock Item ID], [Stock Item], (([Recommended Retail Price] - [Unit Price])/ [Unit Price] * 100) AS Markup
FROM dimStockItem
WHERE [WWI Stock Item ID] = 29





