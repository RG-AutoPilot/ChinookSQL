SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_MonthlyRevenue] AS
SELECT 
    YEAR(i.InvoiceDate) AS RevenueYear,
    MONTH(i.InvoiceDate) AS RevenueMonth,
    DATENAME(MONTH, i.InvoiceDate) AS MonthName,
    COUNT(i.InvoiceId) AS InvoiceCount,
    SUM(i.Total) AS MonthlyRevenue,
    AVG(i.Total) AS AverageInvoiceValue,
    COUNT(DISTINCT i.CustomerId) AS UniqueCustomers,
    SUM(il.Quantity) AS ItemsSold
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY YEAR(i.InvoiceDate), MONTH(i.InvoiceDate), DATENAME(MONTH, i.InvoiceDate);
GO
