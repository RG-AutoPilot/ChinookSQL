CREATE TABLE [dbo].[AlbumReview]
(
[ReviewId] [int] NOT NULL,
[AlbumId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL,
[RevenueGrossed] [decimal] (18, 2) NULL
)
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [PK_AlbumReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [UQ_AlbumReview_Album_Customer] UNIQUE ([AlbumId], [CustomerId])
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [FK_AlbumReview_Album] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [FK_AlbumReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [CK_AlbumReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
