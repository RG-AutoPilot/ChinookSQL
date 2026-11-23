CREATE TABLE [dbo].[AppConfig]
(
[ConfigId] [int] NOT NULL,
[ConfigKey] [nvarchar] (50) NOT NULL,
[ConfigValue] [nvarchar] (200) NOT NULL,
[TestID] [int] NULL,
[Huxley] [int] NULL
)
GO
ALTER TABLE [dbo].[AppConfig] ADD CONSTRAINT [PK_AppConfig] PRIMARY KEY CLUSTERED ([ConfigId])
GO
