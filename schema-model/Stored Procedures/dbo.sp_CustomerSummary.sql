SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_CustomerSummary]
    @CustomerId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        c.CustomerId,
        c.FirstName + ' ' + c.LastName AS FullName,
        c.Email,
        c.Country,
        COUNT(i.InvoiceId) AS TotalInvoices,
        ISNULL(SUM(i.Total), 0) AS TotalSpent,
        ISNULL(AVG(i.Total), 0) AS AverageOrderValue,
        MAX(i.InvoiceDate) AS LastPurchaseDate,
        (SELECT COUNT(*) FROM InvoiceLine il 
         JOIN Invoice i2 ON il.InvoiceId = i2.InvoiceId 
         WHERE i2.CustomerId = c.CustomerId) AS TotalItemsPurchased
    FROM Customer c
    LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
    WHERE c.CustomerId = @CustomerId
    GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Email, c.Country;
END;
GO
