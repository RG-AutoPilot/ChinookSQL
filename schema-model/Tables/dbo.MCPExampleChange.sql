CREATE TABLE [dbo].[MCPExampleChange]
(
[MCPExampleChangeId] [int] NOT NULL IDENTITY(1, 1),
[MCPChange] [int] NULL
)
GO
ALTER TABLE [dbo].[MCPExampleChange] ADD CONSTRAINT [PK_MCPExampleChange] PRIMARY KEY CLUSTERED ([MCPExampleChangeId])
GO
