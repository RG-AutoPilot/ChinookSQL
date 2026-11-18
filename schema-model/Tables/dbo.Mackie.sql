CREATE TABLE [dbo].[Mackie]
(
[MackieId] [int] NOT NULL IDENTITY(1, 1),
[HuxChange] [int] NULL
)
GO
ALTER TABLE [dbo].[Mackie] ADD CONSTRAINT [PK_Mackie] PRIMARY KEY CLUSTERED ([MackieId])
GO
