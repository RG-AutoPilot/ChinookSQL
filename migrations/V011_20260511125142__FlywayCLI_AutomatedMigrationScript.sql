SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[ArtistBio]'
GO
ALTER TABLE [dbo].[ArtistBio] DROP CONSTRAINT [FK_ArtistBio_Artist]
GO
PRINT N'Dropping constraints from [dbo].[ArtistBio]'
GO
ALTER TABLE [dbo].[ArtistBio] DROP CONSTRAINT [PK_ArtistBio]
GO
PRINT N'Dropping [dbo].[ArtistBio]'
GO
DROP TABLE [dbo].[ArtistBio]
GO
PRINT N'Creating [dbo].[AlbumReview]'
GO
CREATE TABLE [dbo].[AlbumReview]
(
[ReviewId] [int] NOT NULL,
[AlbumId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_AlbumReview] on [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [PK_AlbumReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Adding constraints to [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [UQ_AlbumReview_Album_Customer] UNIQUE NONCLUSTERED ([AlbumId], [CustomerId])
GO
PRINT N'Creating [dbo].[HuxleyTest]'
GO
CREATE TABLE [dbo].[HuxleyTest]
(
[AlbumId] [int] NOT NULL IDENTITY(1, 1)
)
GO
PRINT N'Adding constraints to [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [CK_AlbumReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [FK_AlbumReview_Album] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [FK_AlbumReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

