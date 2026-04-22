SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_TopTracks]
    @TopCount INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP (@TopCount)
        t.TrackId,
        t.Name AS TrackName,
        a.Title AS AlbumTitle,
        ar.Name AS ArtistName,
        g.Name AS GenreName,
        COUNT(il.InvoiceLineId) AS TimesPurchased,
        SUM(il.Quantity) AS TotalQuantitySold,
        SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
    FROM Track t
    JOIN Album a ON t.AlbumId = a.AlbumId
    JOIN Artist ar ON a.ArtistId = ar.ArtistId
    JOIN Genre g ON t.GenreId = g.GenreId
    LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
    GROUP BY t.TrackId, t.Name, a.Title, ar.Name, g.Name
    ORDER BY TimesPurchased DESC, TotalRevenue DESC;
END;
GO
