CREATE TABLE [dbo].[APIRateChange]
(
[APIRateChangeId] [int] NOT NULL IDENTITY(1, 1),
[APIKey] [int] NULL,
[APIRate] [decimal] (18, 0) NULL
)
GO
ALTER TABLE [dbo].[APIRateChange] ADD CONSTRAINT [PK_APIRateChange] PRIMARY KEY CLUSTERED ([APIRateChangeId])
GO
