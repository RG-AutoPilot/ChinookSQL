SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK_CustomerTestID]
GO
PRINT N'Dropping index [IFK_CustomerTestID] from [dbo].[Customer]'
GO
DROP INDEX [IFK_CustomerTestID] ON [dbo].[Customer]
GO
PRINT N'Altering [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD
[IsEnjoying] [bit] NOT NULL CONSTRAINT [DF_AlbumReview_IsEnjoying] DEFAULT ((1)),
[HelpfulVotes] [int] NOT NULL CONSTRAINT [DF_AlbumReview_HelpfulVotes] DEFAULT ((0))
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[TestRoger] [int] NULL,
[SDRDemo] [int] NULL,
[TestDemo] [int] NULL
GO
PRINT N'Creating [dbo].[sp_CustomerAlbumEnjoyment]'
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
PRINT N'Refreshing [dbo].[vw_CustomerInvoiceSummary]'
GO
EXEC sp_refreshview N'[dbo].[vw_CustomerInvoiceSummary]'
GO
PRINT N'Refreshing [dbo].[vw_EmployeePerformance]'
GO
EXEC sp_refreshview N'[dbo].[vw_EmployeePerformance]'
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

