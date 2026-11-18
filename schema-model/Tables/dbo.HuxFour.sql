CREATE TABLE [dbo].[HuxFour]
(
[HuxFourId] [int] NOT NULL IDENTITY(1, 1),
[HuxChange] [int] NULL
)
GO
ALTER TABLE [dbo].[HuxFour] ADD CONSTRAINT [PK_HuxFour] PRIMARY KEY CLUSTERED ([HuxFourId])
GO
