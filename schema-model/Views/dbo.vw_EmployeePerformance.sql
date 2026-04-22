SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_EmployeePerformance] AS
SELECT 
    e.EmployeeId,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    e.Title,
    COUNT(DISTINCT c.CustomerId) AS CustomersSupported,
    COUNT(i.InvoiceId) AS TotalInvoices,
    ISNULL(SUM(i.Total), 0) AS TotalSalesGenerated,
    ISNULL(AVG(i.Total), 0) AS AverageInvoiceValue,
    CASE 
        WHEN COUNT(i.InvoiceId) > 50 THEN 'High Performer'
        WHEN COUNT(i.InvoiceId) > 20 THEN 'Good Performer'
        ELSE 'Developing'
    END AS PerformanceCategory
FROM Employee e
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title;
GO
