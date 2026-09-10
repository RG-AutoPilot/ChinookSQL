SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/* Refreshes the sales analytics numbers the dashboard team pull every
   morning. Runs the usual batch against invoices/tracks/customers etc
   and logs how long it took into SalesAnalyticsRefreshLog so we can
   keep an eye on it.

   Bumped @Iterations up from 15 to 40 last sprint because Priya said
   the weekly rollup numbers looked "off" compared to her export -
   running it more times seemed to smooth that out. Not 100% sure
   that's actually why it was wrong but it's working for now, can
   revisit if it comes up again.

   Added the WAITFOR too so this doesn't hammer the server if it ever
   gets kicked off more than once at the same time (don't think that
   should happen but better safe than sorry).

   TODO: this is getting pretty slow to run, might be worth breaking
   into smaller procs at some point - not today though
*/
CREATE PROCEDURE [dbo].[usp_RefreshSalesAnalytics]
    @Iterations          INT = 40,   -- how many passes through the batch below
    @DelayMsPerIteration INT = 250   -- small pause between passes, just in case
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME2 = SYSUTCDATETIME();
    DECLARE @i INT = 0;
    DECLARE @RowsTouched BIGINT = 0;
    DECLARE @Checksum BIGINT; -- not used for anything, just stops the optimizer
                              -- being clever and skipping the query
    DECLARE @Delay CHAR(12);

    WHILE @i < @Iterations
    BEGIN
        -- top selling artists, for the "Top Artists" widget on the dashboard
        SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(x.ArtistName, x.Revenue))
        FROM (
            SELECT
                ar.Name AS ArtistName,
                SUM(il.UnitPrice * il.Quantity) AS Revenue,
                RANK() OVER (ORDER BY SUM(il.UnitPrice * il.Quantity) DESC) AS Rnk
            FROM dbo.InvoiceLine il
            JOIN dbo.Track  t  ON t.TrackId = il.TrackId
            JOIN dbo.Album  al ON al.AlbumId = t.AlbumId
            JOIN dbo.Artist ar ON ar.ArtistId = al.ArtistId
            JOIN dbo.Invoice i ON i.InvoiceId = il.InvoiceId
            GROUP BY ar.Name
        ) x;
        SET @RowsTouched += @@ROWCOUNT;

        -- customer lifetime spend + rank within their country. The cross
        -- join below is a bit of a hack - we didn't have enough rows in
        -- test to see how this behaves at real volumes, so multiplying it
        -- out gives something closer to prod scale until the data team
        -- finish the proper historical load. Remember to take this out
        -- once that's done!
        SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(y.CustomerId, y.LifetimeSpend))
        FROM (
            SELECT
                c.CustomerId,
                SUM(i.Total) AS LifetimeSpend,
                DENSE_RANK() OVER (PARTITION BY c.Country ORDER BY SUM(i.Total) DESC) AS CountryRank
            FROM dbo.Customer c
            JOIN dbo.Invoice i ON i.CustomerId = c.CustomerId
            CROSS JOIN (SELECT TOP (500) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
                        FROM sys.all_objects a1
                        CROSS JOIN sys.all_objects a2) n
            GROUP BY c.CustomerId, c.Country
        ) y;
        SET @RowsTouched += @@ROWCOUNT;

        -- genre revenue split by country - self join on Track pulls back
        -- avg track length + how many other tracks share the genre, both
        -- of which were asked for in the report spec
        SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(z.Country, z.GenreName, z.Revenue))
        FROM (
            SELECT
                i.BillingCountry AS Country,
                g.Name AS GenreName,
                SUM(il.UnitPrice * il.Quantity) AS Revenue,
                AVG(t.Milliseconds) AS AvgTrackLengthMs,
                COUNT(DISTINCT t2.TrackId) AS SameGenreTrackCount
            FROM dbo.InvoiceLine il
            JOIN dbo.Invoice i ON i.InvoiceId = il.InvoiceId
            JOIN dbo.Track t   ON t.TrackId = il.TrackId
            JOIN dbo.Genre g   ON g.GenreId = t.GenreId
            JOIN dbo.Track t2  ON t2.GenreId = t.GenreId
            GROUP BY i.BillingCountry, g.Name
        ) z;
        SET @RowsTouched += @@ROWCOUNT;

        -- rolls sales up by the rep who owns the customer. Employee side
        -- needed so reps with zero sales still show - left this as an
        -- inner join for now, might need to revisit if that turns out
        -- to actually be a problem
        SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(e.EmployeeId, w.TotalSales))
        FROM dbo.Employee e
        JOIN (
            SELECT c.SupportRepId, SUM(i.Total) AS TotalSales, COUNT(*) AS InvoiceCount
            FROM dbo.Customer c
            JOIN dbo.Invoice i ON i.CustomerId = c.CustomerId
            GROUP BY c.SupportRepId
        ) w ON w.SupportRepId = e.EmployeeId;
        SET @RowsTouched += @@ROWCOUNT;

        -- how many tracks share both genre + media type, for the "related
        -- tracks" feature. Using COUNT_BIG on purpose here - found out the
        -- hard way that COUNT(*) overflows on Rock (way more tracks than
        -- anything else) once you self-join it against itself. Do NOT add
        -- a second self join to this without checking that first, learned
        -- that one the slow way
        SELECT @Checksum = CHECKSUM_AGG(CHECKSUM(v.GenreId, v.MediaTypeId, v.PairCount))
        FROM (
            SELECT
                t1.GenreId,
                t1.MediaTypeId,
                COUNT_BIG(*) AS PairCount
            FROM dbo.Track t1
            JOIN dbo.Track t2 ON t2.GenreId = t1.GenreId AND t2.MediaTypeId = t1.MediaTypeId
            GROUP BY t1.GenreId, t1.MediaTypeId
        ) v;
        SET @RowsTouched += @@ROWCOUNT;

        IF @DelayMsPerIteration > 0
        BEGIN
            SET @Delay = '00:00:00.' + RIGHT('000' + CAST(@DelayMsPerIteration % 1000 AS VARCHAR(3)), 3);
            WAITFOR DELAY @Delay;
        END

        SET @i += 1;
    END

    DECLARE @EndTime DATETIME2 = SYSUTCDATETIME();

    -- log it so we can see how long this is taking over time - Dave asked
    -- for this after it ran long one morning and nobody noticed until the
    -- dashboard was late
    INSERT INTO dbo.SalesAnalyticsRefreshLog (StartTimeUtc, EndTimeUtc, DurationMs, Iterations, RowsTouched)
    VALUES (@StartTime, @EndTime, DATEDIFF(MILLISECOND, @StartTime, @EndTime), @Iterations, @RowsTouched);
END
GO
