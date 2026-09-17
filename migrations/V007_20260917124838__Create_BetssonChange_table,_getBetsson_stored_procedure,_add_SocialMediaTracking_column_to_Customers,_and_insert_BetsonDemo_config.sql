SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF OBJECT_ID(N'[dbo].[getBetsson]', 'P') IS NOT NULL
DROP PROCEDURE [dbo].[getBetsson]
GO
PRINT N'Creating [dbo].[BetssonChange]'
GO
IF OBJECT_ID(N'[dbo].[BetssonChange]', 'U') IS NULL
CREATE TABLE [dbo].[BetssonChange]
(
[Demo] [int] NULL
)
GO
PRINT N'Creating [dbo].[getBetsson]'
GO
IF OBJECT_ID(N'[dbo].[getBetsson]', 'P') IS NULL
EXEC sp_executesql N'--GO
CREATE OR ALTER PROCEDURE [dbo].[getBetsson]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| ''user_name'' 
AS
BEGIN
    SELECT * FROM dbo.BetssonChange
END
'
GO
PRINT N'Altering [dbo].[Customers]'
GO
IF COL_LENGTH(N'[dbo].[Customers]', N'SocialMediaTracking') IS NULL
ALTER TABLE [dbo].[Customers] ADD[SocialMediaTracking] [int] NULL
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

PRINT(N'Add 1 row to [dbo].[AppConfig]')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (6, N'BetsonDemo', N'ON')

