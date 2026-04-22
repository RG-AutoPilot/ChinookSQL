CREATE TABLE [dbo].[Album]
(
[AlbumId] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (160) NOT NULL,
[ArtistId] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[Album] ADD CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED ([AlbumId])
GO
CREATE NONCLUSTERED INDEX [IFK_AlbumArtistId] ON [dbo].[Album] ([ArtistId])
GO
ALTER TABLE [dbo].[Album] ADD CONSTRAINT [FK_AlbumArtistId] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId])
GO
