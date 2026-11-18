CREATE TABLE [dbo].[Huccer]
(
[HuccerId] [int] NOT NULL IDENTITY(1, 1),
[Hux] [int] NULL
)
GO
ALTER TABLE [dbo].[Huccer] ADD CONSTRAINT [PK_Huccer] PRIMARY KEY CLUSTERED ([HuccerId])
GO
