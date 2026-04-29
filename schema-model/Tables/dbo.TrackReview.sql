CREATE TABLE [dbo].[TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [PK_TrackReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [FK_TrackReview_Track] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [FK_TrackReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
