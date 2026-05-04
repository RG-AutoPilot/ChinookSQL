CREATE TABLE [dbo].[ArtistBio]
(
[ArtistId] [int] NOT NULL,
[Biography] [nvarchar] (max) NULL,
[Country] [nvarchar] (100) NULL,
[FormedYear] [int] NULL
)
GO
ALTER TABLE [dbo].[ArtistBio] ADD CONSTRAINT [PK_ArtistBio] PRIMARY KEY CLUSTERED ([ArtistId])
GO
ALTER TABLE [dbo].[ArtistBio] ADD CONSTRAINT [FK_ArtistBio_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId])
GO
