SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_GenreStatistics] AS
SELECT 
    g.GenreId,
    g.Name AS GenreName,
    COUNT(DISTINCT t.TrackId) AS TotalTracks,
    COUNT(DISTINCT a.AlbumId) AS TotalAlbums,
    COUNT(DISTINCT ar.ArtistId) AS TotalArtists,
    COUNT(il.InvoiceLineId) AS TimesPurchased,
    SUM(il.Quantity) AS TotalQuantitySold,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue,
    AVG(il.UnitPrice) AS AverageTrackPrice
FROM Genre g
LEFT JOIN Track t ON g.GenreId = t.GenreId
LEFT JOIN Album a ON t.AlbumId = a.AlbumId
LEFT JOIN Artist ar ON a.ArtistId = ar.ArtistId
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.GenreId, g.Name;
GO
