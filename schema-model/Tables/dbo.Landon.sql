CREATE TABLE [dbo].[Landon]
(
[LandonId] [int] NOT NULL IDENTITY(1, 1),
[MCPChange] [int] NULL
)
GO
ALTER TABLE [dbo].[Landon] ADD CONSTRAINT [PK_Landon] PRIMARY KEY CLUSTERED ([LandonId])
GO
