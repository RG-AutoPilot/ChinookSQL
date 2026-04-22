SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_InvoiceReport]
    @InvoiceId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Simulate a junior developer's approach with inefficient queries
    -- Multiple unnecessary subqueries and cross joins
    SELECT DISTINCT
        t.TrackId,
        t.Name AS TrackName,
        t.Composer,
        t.GenreId,
        t.Milliseconds,
        (SELECT TOP 1 UnitPrice FROM InvoiceLine 
         WHERE InvoiceId = @InvoiceId AND TrackId = t.TrackId) AS UnitPrice,
        (SELECT TOP 1 Quantity FROM InvoiceLine 
         WHERE InvoiceId = @InvoiceId AND TrackId = t.TrackId) AS Quantity,
        -- Unnecessary subqueries for demo purposes
        (SELECT COUNT(*) FROM Album WHERE AlbumId = t.AlbumId) AS AlbumTrackCount,
        (SELECT Name FROM Genre WHERE GenreId = t.GenreId) AS GenreName
    FROM Track t
    CROSS JOIN Invoice i2
    WHERE t.TrackId IN (
        SELECT DISTINCT il2.TrackId
        FROM InvoiceLine il2
        WHERE il2.InvoiceId = @InvoiceId
        AND EXISTS (
            SELECT 1 FROM Invoice i3 
            WHERE i3.InvoiceId = il2.InvoiceId
            AND i3.InvoiceId = @InvoiceId
        )
    )
    AND EXISTS (
        SELECT 1 FROM InvoiceLine il3
        WHERE il3.TrackId = t.TrackId
        AND il3.InvoiceId = @InvoiceId
    )
    AND i2.InvoiceId = @InvoiceId
    AND EXISTS (
        SELECT 1 FROM InvoiceLine il4
        WHERE il4.InvoiceId = @InvoiceId
        AND il4.TrackId = t.TrackId
    );
    
    -- Add artificial delay for demonstration
    WAITFOR DELAY '00:00:02';
END;
GO
