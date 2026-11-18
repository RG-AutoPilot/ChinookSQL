CREATE TABLE [dbo].[HuxThree]
(
[HuxThreeId] [int] NOT NULL IDENTITY(1, 1),
[HuxChange] [int] NULL
)
GO
ALTER TABLE [dbo].[HuxThree] ADD CONSTRAINT [PK_HuxThree] PRIMARY KEY CLUSTERED ([HuxThreeId])
GO
