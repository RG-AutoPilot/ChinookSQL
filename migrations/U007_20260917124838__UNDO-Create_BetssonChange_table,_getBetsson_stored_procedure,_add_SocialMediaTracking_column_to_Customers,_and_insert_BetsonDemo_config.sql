SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping [dbo].[getBetsson]'
GO
IF OBJECT_ID(N'[dbo].[getBetsson]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[getBetsson]
GO
PRINT N'Dropping [dbo].[BetssonChange]'
GO
IF OBJECT_ID(N'[dbo].[BetssonChange]', 'U') IS NOT NULL
DROP TABLE [dbo].[BetssonChange]
GO
PRINT N'Altering [dbo].[Customers]'
GO
IF COL_LENGTH(N'[dbo].[Customers]', N'SocialMediaTracking') IS NOT NULL
ALTER TABLE [dbo].[Customers] DROP COLUMN [SocialMediaTracking]
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

