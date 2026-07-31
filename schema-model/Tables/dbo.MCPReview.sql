CREATE TABLE [dbo].[MCPReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[ReviewerName] [nvarchar] (255) NOT NULL,
[ReviewerEmail] [nvarchar] (255) NOT NULL,
[MCPToolName] [nvarchar] (255) NOT NULL,
[Rating] [int] NOT NULL,
[ReviewText] [nvarchar] (2000) NULL,
[SubmittedAt] [datetime] NOT NULL CONSTRAINT [DF_MCPReview_SubmittedAt] DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[MCPReview] ADD CONSTRAINT [PK_MCPReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
ALTER TABLE [dbo].[MCPReview] ADD CONSTRAINT [CK_MCPReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
