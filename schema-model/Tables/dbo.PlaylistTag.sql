CREATE TABLE [dbo].[PlaylistTag]
(
[PlaylistId] [int] NOT NULL,
[Tag] [nvarchar] (120) NOT NULL
)
GO
ALTER TABLE [dbo].[PlaylistTag] ADD CONSTRAINT [PK_PlaylistTag] PRIMARY KEY NONCLUSTERED ([PlaylistId], [Tag])
GO
ALTER TABLE [dbo].[PlaylistTag] ADD CONSTRAINT [FK_PlaylistTagPlaylistId] FOREIGN KEY ([PlaylistId]) REFERENCES [dbo].[Playlist] ([PlaylistId])
GO
