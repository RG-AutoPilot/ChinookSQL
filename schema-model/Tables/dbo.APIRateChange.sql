CREATE TABLE [dbo].[APIRateChange]
(
[APIRateChangeId] [int] NOT NULL IDENTITY(1, 1),
[APIKey] [int] NOT NULL,
[APIRate] [decimal] (18, 4) NOT NULL,
[ChangedDate] [datetime] NOT NULL CONSTRAINT [DF_APIRateChange_ChangedDate] DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[APIRateChange] ADD CONSTRAINT [PK_APIRateChange] PRIMARY KEY CLUSTERED ([APIRateChangeId])
GO
CREATE NONCLUSTERED INDEX [IX_APIRateChange_APIKey_ChangedDate] ON [dbo].[APIRateChange] ([APIKey], [ChangedDate])
GO
