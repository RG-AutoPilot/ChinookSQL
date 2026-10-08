SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping [dbo].[getSSISReviews]'
GO
DROP PROCEDURE [dbo].[getSSISReviews]
GO
PRINT N'Dropping [dbo].[SSISDemoReview]'
GO
DROP TABLE [dbo].[SSISDemoReview]
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] DROP
COLUMN [GrossRevenueDollar]
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

PRINT(N'Delete 1 row from [dbo].[AppConfig]')
DELETE FROM [dbo].[AppConfig] WHERE [ConfigId] = 6

