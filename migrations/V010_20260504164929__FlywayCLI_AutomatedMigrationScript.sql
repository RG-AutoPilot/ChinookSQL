SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[ArtistBio]'
GO
CREATE TABLE [dbo].[ArtistBio]
(
[ArtistId] [int] NOT NULL,
[Biography] [nvarchar] (max) NULL,
[Country] [nvarchar] (100) NULL,
[FormedYear] [int] NULL
)
GO
PRINT N'Creating primary key [PK_ArtistBio] on [dbo].[ArtistBio]'
GO
ALTER TABLE [dbo].[ArtistBio] ADD CONSTRAINT [PK_ArtistBio] PRIMARY KEY CLUSTERED ([ArtistId])
GO
PRINT N'Adding foreign keys to [dbo].[ArtistBio]'
GO
ALTER TABLE [dbo].[ArtistBio] ADD CONSTRAINT [FK_ArtistBio_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

