SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[WebsiteReview]'
GO
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
PRINT N'Creating primary key [PK_WebsiteReview] on [dbo].[WebsiteReview]'
GO
ALTER TABLE [dbo].[WebsiteReview] ADD CONSTRAINT [PK_WebsiteReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Creating index [IFK_WebsiteReview_Customer] on [dbo].[WebsiteReview]'
GO
CREATE NONCLUSTERED INDEX [IFK_WebsiteReview_Customer] ON [dbo].[WebsiteReview] ([CustomerId])
GO
PRINT N'Creating [dbo].[vw_WebsiteReviews]'
GO
CREATE VIEW [dbo].[vw_WebsiteReviews] AS
SELECT
    wr.ReviewId,
    wr.ReviewerName,
    wr.ReviewerEmail,
    wr.Rating,
    wr.ReviewText,
    wr.ReviewDate,
    wr.IsApproved,
    c.CustomerId,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email AS CustomerEmail,
    c.Country AS CustomerCountry
FROM [dbo].[WebsiteReview] wr
LEFT JOIN [dbo].[Customer] c ON wr.CustomerId = c.CustomerId;
GO
PRINT N'Adding constraints to [dbo].[WebsiteReview]'
GO
ALTER TABLE [dbo].[WebsiteReview] ADD CONSTRAINT [CK_WebsiteReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[WebsiteReview]'
GO
ALTER TABLE [dbo].[WebsiteReview] ADD CONSTRAINT [FK_WebsiteReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

