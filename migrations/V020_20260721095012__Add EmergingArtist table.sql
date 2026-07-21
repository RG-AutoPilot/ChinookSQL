SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[EmergingArtist]'
GO
CREATE TABLE [dbo].[EmergingArtist]
(
[EmergingArtistId] [int] NOT NULL IDENTITY(1, 1),
[ArtistId] [int] NOT NULL,
[DateAdded] [datetime] NOT NULL CONSTRAINT [DF_EmergingArtist_DateAdded] DEFAULT (getdate()),
[Genre] [nvarchar] (120) NULL,
[Notes] [nvarchar] (500) NULL,
[MonthlyListeners] [int] NULL,
[IsActive] [bit] NOT NULL CONSTRAINT [DF_EmergingArtist_IsActive] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_EmergingArtist] on [dbo].[EmergingArtist]'
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [PK_EmergingArtist] PRIMARY KEY CLUSTERED ([EmergingArtistId])
GO
PRINT N'Adding constraints to [dbo].[EmergingArtist]'
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [UQ_EmergingArtist_ArtistId] UNIQUE NONCLUSTERED ([ArtistId])
GO
PRINT N'Adding constraints to [dbo].[EmergingArtist]'
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [CK_EmergingArtist_MonthlyListeners] CHECK (([MonthlyListeners] IS NULL OR [MonthlyListeners]>=(0)))
GO
PRINT N'Adding foreign keys to [dbo].[EmergingArtist]'
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [FK_EmergingArtist_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

