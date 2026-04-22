CREATE TABLE [dbo].[PlaylistTrack]
(
[PlaylistId] [int] NOT NULL,
[TrackId] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [PK_PlaylistTrack] PRIMARY KEY NONCLUSTERED ([PlaylistId], [TrackId])
GO
CREATE NONCLUSTERED INDEX [IFK_PlaylistTrackPlaylistId] ON [dbo].[PlaylistTrack] ([PlaylistId])
GO
CREATE NONCLUSTERED INDEX [IFK_PlaylistTrackTrackId] ON [dbo].[PlaylistTrack] ([TrackId])
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrackPlaylistId] FOREIGN KEY ([PlaylistId]) REFERENCES [dbo].[Playlist] ([PlaylistId])
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrackTrackId] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO
