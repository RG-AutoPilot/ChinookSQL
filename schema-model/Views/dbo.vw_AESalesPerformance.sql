SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_AESalesPerformance] AS
SELECT
    ae.AEId,
    ae.FirstName + ' ' + ae.LastName AS AEName,
    ae.Email,
    ae.Region,
    COUNT(ae.AEId) AS TotalDeals,
    SUM(CASE WHEN ae.DealStage = 'Closed Won' THEN 1 ELSE 0 END) AS WonDeals,
    SUM(CASE WHEN ae.DealStage = 'Closed Lost' THEN 1 ELSE 0 END) AS LostDeals,
    ISNULL(SUM(ae.DealValue), 0) AS TotalDealValue,
    ISNULL(SUM(CASE WHEN ae.DealStage = 'Closed Won' THEN ae.DealValue ELSE 0 END), 0) AS WonDealValue,
    ISNULL(AVG(ae.DealValue), 0) AS AverageDealValue,
    CASE
        WHEN COUNT(ae.AEId) = 0 THEN 0
        ELSE CAST(SUM(CASE WHEN ae.DealStage = 'Closed Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(ae.AEId) AS numeric(5, 2))
    END AS WinRatePct
FROM [dbo].[AESalesTracking] ae
GROUP BY ae.AEId, ae.FirstName, ae.LastName, ae.Email, ae.Region;
GO
