CREATE TABLE [dbo].[VZAIUsage]
(
[UsageID] [int] NOT NULL IDENTITY(1, 1),
[UserID] [nvarchar] (100) NOT NULL,
[ModelName] [nvarchar] (100) NOT NULL,
[PromptTokens] [int] NOT NULL,
[CompletionTokens] [int] NOT NULL,
[TotalTokens] [int] NOT NULL,
[RequestTimestamp] [datetime] NOT NULL CONSTRAINT [DF_VZAIUsage_RequestTimestamp] DEFAULT (getdate()),
[Notes] [nvarchar] (500) NULL,
CONSTRAINT [PK_VZAIUsage] PRIMARY KEY CLUSTERED ([UsageID])
)
GO
