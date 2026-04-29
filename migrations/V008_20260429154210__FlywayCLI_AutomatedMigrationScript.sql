SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[AuditLog]'
GO
CREATE TABLE [dbo].[AuditLog]
(
[AuditLogId] [int] NOT NULL IDENTITY(1, 1),
[TableName] [nvarchar] (128) NOT NULL,
[Operation] [nvarchar] (10) NOT NULL,
[RecordId] [int] NOT NULL,
[ChangedBy] [nvarchar] (256) NOT NULL,
[ChangedDate] [datetime] NOT NULL CONSTRAINT [DF_AuditLog_ChangedDate] DEFAULT (getdate()),
[Details] [nvarchar] (max) NULL
)
GO
PRINT N'Creating primary key [PK_AuditLog] on [dbo].[AuditLog]'
GO
ALTER TABLE [dbo].[AuditLog] ADD CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED ([AuditLogId])
GO
PRINT N'Creating index [IX_AuditLog_ChangedDate] on [dbo].[AuditLog]'
GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_ChangedDate] ON [dbo].[AuditLog] ([ChangedDate])
GO
PRINT N'Creating index [IX_AuditLog_TableName] on [dbo].[AuditLog]'
GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_TableName] ON [dbo].[AuditLog] ([TableName])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

