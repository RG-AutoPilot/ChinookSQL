CREATE TABLE [dbo].[SystemLog]
(
[LogId] [int] NOT NULL,
[InvoiceId] [int] NOT NULL,
[LogDate] [datetime] NOT NULL,
[LogMessage] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[SystemLog] ADD CONSTRAINT [PK_SystemLog] PRIMARY KEY CLUSTERED ([LogId])
GO
ALTER TABLE [dbo].[SystemLog] ADD CONSTRAINT [FK_SystemLog_Invoice] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId])
GO
