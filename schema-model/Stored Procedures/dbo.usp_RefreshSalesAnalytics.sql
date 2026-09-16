SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[usp_RefreshSalesAnalytics]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime   DATETIME2 = SYSUTCDATETIME();
    DECLARE @RowsTouched BIGINT    = 0;
    DECLARE @Checksum    BIGINT;

    -- Top selling artists ("Top Artists" widget)
    SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(x.ArtistName, x.Revenue))
    FROM (
        SELECT
            ar.Name AS ArtistName,
            SUM(il.UnitPrice * il.Quantity) AS Revenue,
            RANK() OVER (ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS Rnk
        FROM dbo.InvoiceLine il
        JOIN dbo.Track  t  ON t.TrackId  = il.TrackId
        JOIN dbo.Album  al ON al.AlbumId = t.AlbumId
        JOIN dbo.Artist ar ON ar.ArtistId = al.ArtistId
        GROUP BY ar.Name
    ) x;
    SET @RowsTouched += @@ROWCOUNT;

    -- Customer lifetime spend + rank within country
    SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(y.CustomerId, y.LifetimeSpend))
    FROM (
        SELECT
            c.CustomerId,
            SUM(i.Total) AS LifetimeSpend,
            DENSE_RANK() OVER (PARTITION BY c.Country ORDER BY SUM(i.Total) DESC) AS CountryRank
        FROM dbo.Customer c
        JOIN dbo.Invoice  i ON i.CustomerId = c.CustomerId
        GROUP BY c.CustomerId, c.Country
    ) y;
    SET @RowsTouched += @@ROWCOUNT;

    -- Genre revenue split by country.
    -- Per-genre track stats are pre-aggregated so the InvoiceLine rows
    -- are not multiplied by the number of tracks in the genre.
    WITH GenreStats AS (
        SELECT
            t.GenreId,
            AVG(t.Milliseconds) AS AvgTrackLengthMs,
            COUNT_BIG(*)        AS SameGenreTrackCount
        FROM dbo.Track t
        GROUP BY t.GenreId
    )
    SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(z.Country, z.GenreName, z.Revenue))
    FROM (
        SELECT
            i.BillingCountry AS Country,
            g.Name           AS GenreName,
            SUM(il.UnitPrice * il.Quantity) AS Revenue,
            MAX(gs.AvgTrackLengthMs)        AS AvgTrackLengthMs,
            MAX(gs.SameGenreTrackCount)     AS SameGenreTrackCount
        FROM dbo.InvoiceLine il
        JOIN dbo.Invoice   i  ON i.InvoiceId = il.InvoiceId
        JOIN dbo.Track     t  ON t.TrackId   = il.TrackId
        JOIN dbo.Genre     g  ON g.GenreId   = t.GenreId
        JOIN GenreStats    gs ON gs.GenreId  = t.GenreId
        GROUP BY i.BillingCountry, g.Name
    ) z;
    SET @RowsTouched += @@ROWCOUNT;

    -- Sales rolled up by support rep
    SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(e.EmployeeId, w.TotalSales))
    FROM dbo.Employee e
    JOIN (
        SELECT c.SupportRepId, SUM(i.Total) AS TotalSales, COUNT(*) AS InvoiceCount
        FROM dbo.Customer c
        JOIN dbo.Invoice  i ON i.CustomerId = c.CustomerId
        GROUP BY c.SupportRepId
    ) w ON w.SupportRepId = e.EmployeeId;
    SET @RowsTouched += @@ROWCOUNT;

    -- Tracks sharing genre + media type ("related tracks" feature).
    -- Self-join collapsed: pairs per (Genre, MediaType) = n * n.
    SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(v.GenreId, v.MediaTypeId, v.PairCount))
    FROM (
        SELECT
            t.GenreId,
            t.MediaTypeId,
            COUNT_BIG(*) * COUNT_BIG(*) AS PairCount
        FROM dbo.Track t
        GROUP BY t.GenreId, t.MediaTypeId
    ) v;
    SET @RowsTouched += @@ROWCOUNT;

    DECLARE @EndTime DATETIME2 = SYSUTCDATETIME();

    INSERT INTO dbo.SalesAnalyticsRefreshLog (StartTimeUtc, EndTimeUtc, DurationMs, Iterations, RowsTouched)
    VALUES (@StartTime, @EndTime, DATEDIFF(MILLISECOND, @StartTime, @EndTime), 1, @RowsTouched);
END
GO
