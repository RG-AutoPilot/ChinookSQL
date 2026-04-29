SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[AuditLog]'
GO
ALTER TABLE [dbo].[AuditLog] DROP CONSTRAINT [PK_AuditLog]
GO
PRINT N'Dropping constraints from [dbo].[AuditLog]'
GO
ALTER TABLE [dbo].[AuditLog] DROP CONSTRAINT [DF_AuditLog_ChangedDate]
GO
PRINT N'Dropping index [IX_AuditLog_TableName] from [dbo].[AuditLog]'
GO
DROP INDEX [IX_AuditLog_TableName] ON [dbo].[AuditLog]
GO
PRINT N'Dropping index [IX_AuditLog_ChangedDate] from [dbo].[AuditLog]'
GO
DROP INDEX [IX_AuditLog_ChangedDate] ON [dbo].[AuditLog]
GO
PRINT N'Dropping [dbo].[AuditLog]'
GO
DROP TABLE [dbo].[AuditLog]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

