CREATE TABLE [dbo].[CIBFeedback]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[RelationshipManagerId] [int] NULL,
[FeedbackDate] [datetime] NOT NULL,
[Channel] [nvarchar] (50) NOT NULL,
[Category] [nvarchar] (100) NOT NULL,
[Rating] [int] NOT NULL,
[FeedbackText] [nvarchar] (2000) NULL,
[Status] [nvarchar] (50) NOT NULL,
[CreatedAt] [datetime] NOT NULL
)
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [PK_CIBFeedback] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [DF_CIBFeedback_FeedbackDate] DEFAULT (getdate()) FOR [FeedbackDate]
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [DF_CIBFeedback_Status] DEFAULT ('New') FOR [Status]
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [DF_CIBFeedback_CreatedAt] DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [CK_CIBFeedback_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [CK_CIBFeedback_Status] CHECK ([Status] IN ('New', 'In Review', 'Resolved', 'Closed'))
GO
CREATE NONCLUSTERED INDEX [IFK_CIBFeedback_Customer] ON [dbo].[CIBFeedback] ([CustomerId])
GO
CREATE NONCLUSTERED INDEX [IFK_CIBFeedback_RelationshipManager] ON [dbo].[CIBFeedback] ([RelationshipManagerId])
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [FK_CIBFeedback_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [FK_CIBFeedback_RelationshipManager] FOREIGN KEY ([RelationshipManagerId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
