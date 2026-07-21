CREATE TABLE [dbo].[EmergingArtist]
(
[EmergingArtistId] [int] NOT NULL IDENTITY(1, 1),
[ArtistId] [int] NOT NULL,
[DateAdded] [datetime] NOT NULL,
[Genre] [nvarchar] (120) NULL,
[Notes] [nvarchar] (500) NULL,
[MonthlyListeners] [int] NULL,
[IsActive] [bit] NOT NULL
)
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [PK_EmergingArtist] PRIMARY KEY CLUSTERED ([EmergingArtistId])
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [UQ_EmergingArtist_ArtistId] UNIQUE ([ArtistId])
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [FK_EmergingArtist_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId])
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [DF_EmergingArtist_DateAdded] DEFAULT (getdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [DF_EmergingArtist_IsActive] DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[EmergingArtist] ADD CONSTRAINT [CK_EmergingArtist_MonthlyListeners] CHECK (([MonthlyListeners] IS NULL OR [MonthlyListeners] >= 0))
GO
