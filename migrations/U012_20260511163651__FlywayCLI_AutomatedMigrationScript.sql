SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [FK_AlbumReview_Album]
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [FK_AlbumReview_Customer]
GO
PRINT N'Dropping constraints from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [CK_AlbumReview_Rating]
GO
PRINT N'Dropping constraints from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [PK_AlbumReview]
GO
PRINT N'Dropping constraints from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [UQ_AlbumReview_Album_Customer]
GO
PRINT N'Dropping [dbo].[AlbumReview]'
GO
DROP TABLE [dbo].[AlbumReview]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

