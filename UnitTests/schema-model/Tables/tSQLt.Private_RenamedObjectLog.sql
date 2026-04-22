CREATE TABLE [tSQLt].[Private_RenamedObjectLog]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[ObjectId] [int] NOT NULL,
[OriginalName] [nvarchar] (max) NOT NULL
)
GO
ALTER TABLE [tSQLt].[Private_RenamedObjectLog] ADD CONSTRAINT [PK__Private_RenamedObjectLog__Id] PRIMARY KEY CLUSTERED ([Id])
GO
