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
[IsEnjoying] [bit] NOT NULL CONSTRAINT [DF_AlbumReview_IsEnjoying] DEFAULT ((0))
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

