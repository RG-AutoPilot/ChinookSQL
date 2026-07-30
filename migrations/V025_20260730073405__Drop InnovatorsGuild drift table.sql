SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [FK_InnovatorsGuild_CustomerId]
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [FK_InnovatorsGuild_HostEmployeeId]
GO
PRINT N'Dropping constraints from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [CK_InnovatorsGuild_EnjoymentRating]
GO
PRINT N'Dropping constraints from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [PK_InnovatorsGuild]
GO
PRINT N'Dropping constraints from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [DF_InnovatorsGuild_RegisteredAt]
GO
PRINT N'Dropping index [IFK_InnovatorsGuild_CustomerId] from [dbo].[InnovatorsGuild]'
GO
DROP INDEX [IFK_InnovatorsGuild_CustomerId] ON [dbo].[InnovatorsGuild]
GO
PRINT N'Dropping index [IFK_InnovatorsGuild_HostEmployeeId] from [dbo].[InnovatorsGuild]'
GO
DROP INDEX [IFK_InnovatorsGuild_HostEmployeeId] ON [dbo].[InnovatorsGuild]
GO
PRINT N'Dropping [dbo].[InnovatorsGuild]'
GO
DROP TABLE IF EXISTS [dbo].[InnovatorsGuild]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

