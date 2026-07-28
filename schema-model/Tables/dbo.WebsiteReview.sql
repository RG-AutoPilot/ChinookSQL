CREATE TABLE [dbo].[WebsiteReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NULL,
[ReviewerName] [nvarchar] (100) NOT NULL,
[ReviewerEmail] [nvarchar] (200) NULL,
[Rating] [int] NOT NULL,
[ReviewText] [nvarchar] (2000) NULL,
[ReviewDate] [datetime] NOT NULL CONSTRAINT [DF_WebsiteReview_ReviewDate] DEFAULT (getdate()),
[IsApproved] [bit] NOT NULL CONSTRAINT [DF_WebsiteReview_IsApproved] DEFAULT ((0))
)
GO
ALTER TABLE [dbo].[WebsiteReview] ADD CONSTRAINT [PK_WebsiteReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
CREATE NONCLUSTERED INDEX [IFK_WebsiteReview_Customer] ON [dbo].[WebsiteReview] ([CustomerId])
GO
ALTER TABLE [dbo].[WebsiteReview] ADD CONSTRAINT [FK_WebsiteReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[WebsiteReview] ADD CONSTRAINT [CK_WebsiteReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
