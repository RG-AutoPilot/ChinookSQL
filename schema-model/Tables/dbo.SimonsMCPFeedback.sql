CREATE TABLE [dbo].[SimonsMCPFeedback]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[SubmitterName] [nvarchar] (255) NOT NULL,
[SubmitterEmail] [nvarchar] (255) NULL,
[MCPFeature] [nvarchar] (255) NOT NULL,
[Rating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[SubmittedAt] [datetime] NOT NULL CONSTRAINT [DF_SimonsMCPFeedback_SubmittedAt] DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[SimonsMCPFeedback] ADD CONSTRAINT [PK_SimonsMCPFeedback] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
ALTER TABLE [dbo].[SimonsMCPFeedback] ADD CONSTRAINT [CK_SimonsMCPFeedback_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
