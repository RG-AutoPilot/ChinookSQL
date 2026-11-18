CREATE TABLE [dbo].[Flyway]
(
[FlywayId] [int] NOT NULL IDENTITY(1, 1),
[HuxChange] [int] NULL,
[EncryptKey] [int] NULL
)
GO
ALTER TABLE [dbo].[Flyway] ADD CONSTRAINT [PK_Flyway] PRIMARY KEY CLUSTERED ([FlywayId])
GO
