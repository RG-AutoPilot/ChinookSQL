SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[sp_SalesReport]'
GO
ALTER PROCEDURE [dbo].[sp_SalesReport]
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Default to last 30 days if no dates provided
    IF @StartDate IS NULL SET @StartDate = DATEADD(DAY, -30, GETDATE());
    IF @EndDate IS NULL SET @EndDate = GETDATE();
    
    SELECT 
        CAST(i.InvoiceDate AS DATE) AS SaleDate,
        COUNT(i.InvoiceId) AS InvoiceCount,
        SUM(i.Total) AS DailyRevenue,
        AVG(i.Total) AS AverageInvoiceValue,
        COUNT(DISTINCT i.CustomerId) AS UniqueCustomers,
        SUM(il.Quantity) AS ItemsSold
    FROM Invoice i
    JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
    WHERE i.InvoiceDate BETWEEN @StartDate AND @EndDate
    GROUP BY CAST(i.InvoiceDate AS DATE)
    ORDER BY SaleDate DESC;
END;
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

