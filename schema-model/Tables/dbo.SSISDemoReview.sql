CREATE TABLE [dbo].[SSISDemoReview]
(
[SSISDemoReviewId] [int] NOT NULL IDENTITY(1, 1),
[Demo] [int] NULL,
[ReviewFeedback] [nvarchar] (24) NULL
)
GO
ALTER TABLE [dbo].[SSISDemoReview] ADD CONSTRAINT [PK_SSISDemoReview] PRIMARY KEY CLUSTERED ([SSISDemoReviewId])
GO
