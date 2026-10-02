CREATE TABLE [dbo].[AmsterdamDemo]
(
[AmsterdamDemoId] [int] NOT NULL IDENTITY(1, 1),
[Demo] [int] NULL
)
GO
ALTER TABLE [dbo].[AmsterdamDemo] ADD CONSTRAINT [PK_AmsterdamDemo] PRIMARY KEY CLUSTERED ([AmsterdamDemoId])
GO
