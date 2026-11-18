CREATE TABLE [dbo].[JoshDuncan]
(
[JoshDuncanId] [int] NOT NULL IDENTITY(1, 1),
[Josh] [int] NULL
)
GO
ALTER TABLE [dbo].[JoshDuncan] ADD CONSTRAINT [PK_JoshDuncan] PRIMARY KEY CLUSTERED ([JoshDuncanId])
GO
