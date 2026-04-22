CREATE TABLE [dbo].[Playlist]
(
[PlaylistId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
ALTER TABLE [dbo].[Playlist] ADD CONSTRAINT [PK_Playlist] PRIMARY KEY CLUSTERED ([PlaylistId])
GO
