CREATE TABLE [dbo].[Genre]
(
[GenreId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
ALTER TABLE [dbo].[Genre] ADD CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED ([GenreId])
GO
