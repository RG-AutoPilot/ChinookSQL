CREATE TABLE [dbo].[AuditLog]
(
[AuditLogId] [int] NOT NULL IDENTITY(1, 1),
[TableName] [nvarchar] (128) NOT NULL,
[Operation] [nvarchar] (10) NOT NULL,
[RecordId] [int] NOT NULL,
[ChangedBy] [nvarchar] (256) NOT NULL,
[ChangedDate] [datetime] NOT NULL CONSTRAINT [DF_AuditLog_ChangedDate] DEFAULT (getdate()),
[Details] [nvarchar] (max) NULL,
[Huxley] [nvarchar] (max) NULL,
[Steven] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[AuditLog] ADD CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED ([AuditLogId])
GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_TableName] ON [dbo].[AuditLog] ([TableName])
GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_ChangedDate] ON [dbo].[AuditLog] ([ChangedDate])
GO
