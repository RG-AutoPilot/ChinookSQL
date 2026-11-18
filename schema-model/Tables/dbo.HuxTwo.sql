CREATE TABLE [dbo].[HuxTwo]
(
[HuxTwoId] [int] NOT NULL IDENTITY(1, 1),
[HuxChange] [int] NULL
)
GO
ALTER TABLE [dbo].[HuxTwo] ADD CONSTRAINT [PK_HuxTwo] PRIMARY KEY CLUSTERED ([HuxTwoId])
GO
