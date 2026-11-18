CREATE TABLE [dbo].[huxChange]
(
[huxChangeId] [int] NOT NULL IDENTITY(1, 1),
[HuxChange] [int] NULL
)
GO
ALTER TABLE [dbo].[huxChange] ADD CONSTRAINT [PK_huxChange] PRIMARY KEY CLUSTERED ([huxChangeId])
GO
