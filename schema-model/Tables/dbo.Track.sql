CREATE TABLE [dbo].[Track]
(
[TrackId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (200) NOT NULL,
[AlbumId] [int] NULL,
[MediaTypeId] [int] NOT NULL,
[GenreId] [int] NULL,
[Composer] [nvarchar] (220) NULL,
[Milliseconds] [int] NOT NULL,
[Bytes] [int] NULL,
[UnitPrice] [numeric] (10, 2) NOT NULL
)
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED ([TrackId])
GO
CREATE NONCLUSTERED INDEX [IFK_TrackAlbumId] ON [dbo].[Track] ([AlbumId])
GO
CREATE NONCLUSTERED INDEX [IFK_TrackGenreId] ON [dbo].[Track] ([GenreId])
GO
CREATE NONCLUSTERED INDEX [IFK_TrackMediaTypeId] ON [dbo].[Track] ([MediaTypeId])
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackAlbumId] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackGenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId])
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackMediaTypeId] FOREIGN KEY ([MediaTypeId]) REFERENCES [dbo].[MediaType] ([MediaTypeId])
GO
