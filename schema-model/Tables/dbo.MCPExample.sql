CREATE TABLE [dbo].[MCPExample]
(
[MCPExampleId] [int] NOT NULL IDENTITY(1, 1),
[MCPChange] [int] NULL
)
GO
ALTER TABLE [dbo].[MCPExample] ADD CONSTRAINT [PK_MCPExample] PRIMARY KEY CLUSTERED ([MCPExampleId])
GO
