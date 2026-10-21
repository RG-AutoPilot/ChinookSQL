CREATE TABLE [dbo].[IQVIA]
(
[IQVIAId] [int] NOT NULL IDENTITY(1, 1),
[WorkflowName] [nvarchar] (100) NOT NULL,
[Status] [nvarchar] (20) NOT NULL,
[CreatedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF_IQVIA_CreatedAt] DEFAULT (SYSUTCDATETIME())
)
GO
ALTER TABLE [dbo].[IQVIA] ADD CONSTRAINT [PK_IQVIA] PRIMARY KEY CLUSTERED ([IQVIAId])
GO
ALTER TABLE [dbo].[IQVIA] ADD CONSTRAINT [CK_IQVIA_Status] CHECK ([Status] IN (N'Pending', N'Running', N'Completed', N'Failed'))
GO
