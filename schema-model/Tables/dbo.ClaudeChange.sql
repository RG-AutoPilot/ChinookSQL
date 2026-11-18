CREATE TABLE [dbo].[ClaudeChange]
(
[ClaudeChangeId] [int] NOT NULL IDENTITY(1, 1),
[Test] [int] NULL
)
GO
ALTER TABLE [dbo].[ClaudeChange] ADD CONSTRAINT [PK_ClaudeChange] PRIMARY KEY CLUSTERED ([ClaudeChangeId])
GO
