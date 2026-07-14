SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_CustomerAlbumEnjoyment]
    @CustomerId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.CustomerId,
        c.FirstName + ' ' + c.LastName AS FullName,
        c.Email,
        a.AlbumId,
        a.Title AS AlbumTitle,
        ar_artist.Name AS ArtistName,
        ar.Rating,
        ar.ReviewText,
        ar.ReviewDate,
        ar.IsEnjoying
    FROM [dbo].[AlbumReview] ar
    JOIN [dbo].[Customer] c ON ar.CustomerId = c.CustomerId
    JOIN [dbo].[Album] a ON ar.AlbumId = a.AlbumId
    JOIN [dbo].[Artist] ar_artist ON a.ArtistId = ar_artist.ArtistId
    WHERE (@CustomerId IS NULL OR c.CustomerId = @CustomerId)
    ORDER BY c.CustomerId, ar.ReviewDate DESC;
END;
GO
