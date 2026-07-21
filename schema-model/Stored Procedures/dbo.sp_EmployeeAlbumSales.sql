SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_EmployeeAlbumSales]
    @EmployeeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        e.Title,
        a.AlbumId,
        a.Title AS AlbumTitle,
        ar.Name AS ArtistName,
        COUNT(DISTINCT i.InvoiceId) AS InvoiceCount,
        SUM(il.Quantity) AS TotalUnitsSold,
        SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
    FROM [dbo].[Employee] e
    INNER JOIN [dbo].[Customer] c ON e.EmployeeId = c.SupportRepId
    INNER JOIN [dbo].[Invoice] i ON c.CustomerId = i.CustomerId
    INNER JOIN [dbo].[InvoiceLine] il ON i.InvoiceId = il.InvoiceId
    INNER JOIN [dbo].[Track] t ON il.TrackId = t.TrackId
    INNER JOIN [dbo].[Album] a ON t.AlbumId = a.AlbumId
    INNER JOIN [dbo].[Artist] ar ON a.ArtistId = ar.ArtistId
    WHERE (@EmployeeId IS NULL OR e.EmployeeId = @EmployeeId)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title, a.AlbumId, a.Title, ar.Name
    ORDER BY e.EmployeeId, TotalRevenue DESC;
END;
GO
