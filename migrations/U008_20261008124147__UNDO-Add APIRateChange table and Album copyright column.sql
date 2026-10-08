SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP CONSTRAINT [PK_APIRateChange]
GO
PRINT N'Dropping constraints from [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP CONSTRAINT [DF_APIRateChange_ChangedDate]
GO
PRINT N'Dropping index [IX_APIRateChange_APIKey_ChangedDate] from [dbo].[APIRateChange]'
GO
DROP INDEX [IX_APIRateChange_APIKey_ChangedDate] ON [dbo].[APIRateChange]
GO
PRINT N'Dropping [dbo].[APIRateChange]'
GO
DROP TABLE [dbo].[APIRateChange]
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] DROP
COLUMN [AlbumCopyright]
GO
PRINT N'Refreshing [dbo].[vw_GenreStatistics]'
GO
EXEC sp_refreshview N'[dbo].[vw_GenreStatistics]'
GO
PRINT N'Refreshing [dbo].[vw_TrackPopularity]'
GO
EXEC sp_refreshview N'[dbo].[vw_TrackPopularity]'
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

