CREATE TABLE [dbo].[TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[ReviewerName] [nvarchar] (100) NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
