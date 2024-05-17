SELECT 
    org.OrganizationName AS Organization,
    ac.AccountType AS AccountType,
    ac.AccountDescription AS Account,
    SUM(ff.Amount) AS Amt,
    SUM(ff.Amount) / (SELECT SUM(Amount) FROM FactFinance) AS PctofTotal

FROM FactFinance ff 
    INNER JOIN DimScenario ds 
    ON ff.ScenarioKey = ds.ScenarioKey
    INNER JOIN DimAccount ac 
    On ff.AccountKey = ac.AccountKey
    INNER JOIN DimOrganization org 
    On ff.OrganizationKey = org.OrganizationKey

WHERE   org.OrganizationName = 'Southwest Division'
        AND ScenarioName = 'Actual'
        AND AccountType = 'Expenditures'
        AND DATEPART(yyyy,ff.Date) = 2011
        AND DATEPART(mm,ff.Date)  = 01

GROUP BY  OrganizationName, AccountType, AccountDescription

ORDER BY Amt DESC
        