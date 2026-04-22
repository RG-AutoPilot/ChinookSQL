CREATE TABLE [tSQLt].[TestResult]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Class] [nvarchar] (max) NOT NULL,
[TestCase] [nvarchar] (max) NOT NULL,
[Name] AS ((quotename([Class])+'.')+quotename([TestCase])),
[TranName] [nvarchar] (max) NOT NULL,
[Result] [nvarchar] (max) NULL,
[Msg] [nvarchar] (max) NULL,
[TestStartTime] [datetime] NOT NULL CONSTRAINT [DF:TestResult(TestStartTime)] DEFAULT (getdate()),
[TestEndTime] [datetime] NULL
)
GO
ALTER TABLE [tSQLt].[TestResult] ADD CONSTRAINT [PK__TestResu__3214EC07ED70DE94] PRIMARY KEY CLUSTERED ([Id])
GO
