SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_CustomerInvoiceSummary] AS
SELECT 
    c.CustomerId,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email,
    c.Country,
    c.City,
    COUNT(i.InvoiceId) AS TotalInvoices,
    ISNULL(SUM(i.Total), 0) AS TotalSpent,
    ISNULL(AVG(i.Total), 0) AS AverageOrderValue,
    MIN(i.InvoiceDate) AS FirstPurchase,
    MAX(i.InvoiceDate) AS LastPurchase,
    DATEDIFF(DAY, MIN(i.InvoiceDate), MAX(i.InvoiceDate)) AS CustomerLifespanDays
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Email, c.Country, c.City;
GO
