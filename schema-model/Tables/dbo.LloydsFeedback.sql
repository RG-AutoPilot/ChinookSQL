CREATE TABLE [dbo].[LloydsFeedback]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[SessionDate] [date] NOT NULL,
[AttendeeFirstName] [nvarchar] (100) NOT NULL,
[AttendeeLastName] [nvarchar] (100) NOT NULL,
[AttendeeRole] [nvarchar] (200) NULL,
[FeatureRated] [nvarchar] (200) NOT NULL,
[Rating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[WouldRecommend] [bit] NOT NULL,
[CreatedAt] [datetime] NOT NULL
)
GO
ALTER TABLE [dbo].[LloydsFeedback] ADD CONSTRAINT [PK_LloydsFeedback] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
ALTER TABLE [dbo].[LloydsFeedback] ADD CONSTRAINT [DF_LloydsFeedback_CreatedAt] DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[LloydsFeedback] ADD CONSTRAINT [CK_LloydsFeedback_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
