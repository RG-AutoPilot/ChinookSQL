CREATE TABLE [dbo].[Artist]
(
[ArtistId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
ALTER TABLE [dbo].[Artist] ADD CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED ([ArtistId])
GO
