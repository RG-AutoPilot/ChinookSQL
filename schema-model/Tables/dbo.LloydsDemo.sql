CREATE TABLE [dbo].[LloydsDemo]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[AttendeeEmail] [nvarchar] (255) NOT NULL,
[AttendeeName] [nvarchar] (255) NULL,
[FeatureRating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[SubmittedAt] [datetime] NOT NULL CONSTRAINT [DF_LloydsDemo_SubmittedAt] DEFAULT (getdate()),
[SessionName] [nvarchar] (255) NULL
)
GO
ALTER TABLE [dbo].[LloydsDemo] ADD CONSTRAINT [PK_LloydsDemo] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
ALTER TABLE [dbo].[LloydsDemo] ADD CONSTRAINT [CK_LloydsDemo_FeatureRating] CHECK (([FeatureRating]>=(1) AND [FeatureRating]<=(5)))
GO
