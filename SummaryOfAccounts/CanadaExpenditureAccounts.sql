SELECT 
    ac.AccountDescription AS Account,
    SUM(ff.Amount) AS Amt,
    SUM(ff.Amount) / (SELECT SUM(Amount) 
                            FROM FactFinance ff 
                            INNER JOIN DimScenario ds 
                            ON ff.ScenarioKey = ds.ScenarioKey
                            INNER JOIN DimAccount ac 
                            On ff.AccountKey = ac.AccountKey
                            INNER JOIN DimOrganization org 
                            On ff.OrganizationKey = org.OrganizationKey

                        WHERE   org.OrganizationName = 'Canadian Division'
                                AND ScenarioName = 'Actual'
                                AND AccountType = 'Expenditures'
                                AND DATEPART(yyyy,ff.Date) = 2013) AS PctofTotal
FROM FactFinance ff 
    INNER JOIN DimScenario ds 
    ON ff.ScenarioKey = ds.ScenarioKey
    INNER JOIN DimAccount ac 
    On ff.AccountKey = ac.AccountKey
    INNER JOIN DimOrganization org 
    On ff.OrganizationKey = org.OrganizationKey

WHERE   org.OrganizationName = 'Canadian Division'
        AND ScenarioName = 'Actual'
        AND AccountType = 'Expenditures'
        AND DATEPART(yyyy,ff.Date) = 2013

GROUP BY AccountDescription

ORDER BY Amt DESC
        