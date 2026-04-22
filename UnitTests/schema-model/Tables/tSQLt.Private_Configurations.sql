CREATE TABLE [tSQLt].[Private_Configurations]
(
[Name] [nvarchar] (100) NOT NULL,
[Value] [sql_variant] NULL
)
GO
ALTER TABLE [tSQLt].[Private_Configurations] ADD CONSTRAINT [PK__Private___737584F7CF3BB191] PRIMARY KEY CLUSTERED ([Name])
GO
