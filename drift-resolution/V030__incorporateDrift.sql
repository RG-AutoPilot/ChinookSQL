SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[BDukeDrift]'
GO
CREATE TABLE [dbo].[BDukeDrift]
(
[Drift] [int] NULL
)
GO
PRINT N'Creating [dbo].[Drift]'
GO
CREATE TABLE [dbo].[Drift]
(
[Drift] [int] NULL
)
GO
PRINT N'Creating [dbo].[MikeChange]'
GO
CREATE TABLE [dbo].[MikeChange]
(
[Drift] [int] NULL
)
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
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (4, N'Drift', N'ON')

