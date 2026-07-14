SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_CustomerAlbumEnjoyment]
    @CustomerId INT = NULL,
    @AlbumId    INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Returns a summary of customer album enjoyment from AlbumReview.
    -- Filter by @CustomerId and/or @AlbumId; omit both to get all reviews.
    SELECT
        c.CustomerId,
        c.FirstName + ' ' + c.LastName AS CustomerName,
        c.Email,
        al.AlbumId,
        al.Title                        AS AlbumTitle,
        ar.Name                         AS ArtistName,
        r.ReviewId,
        r.Rating,
        r.IsEnjoying,
        r.ReviewText,
        r.ReviewDate,
        r.HelpfulVotes
    FROM [dbo].[AlbumReview] r
    INNER JOIN [dbo].[Customer]  c  ON r.CustomerId = c.CustomerId
    INNER JOIN [dbo].[Album]     al ON r.AlbumId    = al.AlbumId
    INNER JOIN [dbo].[Artist]    ar ON al.ArtistId  = ar.ArtistId
    WHERE
        (@CustomerId IS NULL OR r.CustomerId = @CustomerId)
        AND (@AlbumId IS NULL OR r.AlbumId   = @AlbumId)
    ORDER BY r.ReviewDate DESC;
END;
GO
