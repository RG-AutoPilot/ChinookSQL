SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_EmployeeStats]
    @EmployeeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Title,
        COUNT(c.CustomerId) AS CustomersSupported,
        COUNT(i.InvoiceId) AS TotalInvoices,
        ISNULL(SUM(i.Total), 0) AS TotalSalesGenerated,
        ISNULL(AVG(i.Total), 0) AS AverageInvoiceValue
    FROM Employee e
    LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
    LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
    WHERE (@EmployeeId IS NULL OR e.EmployeeId = @EmployeeId)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title
    ORDER BY TotalSalesGenerated DESC;
END;
GO
