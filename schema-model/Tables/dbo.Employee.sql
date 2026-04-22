CREATE TABLE [dbo].[Employee]
(
[EmployeeId] [int] NOT NULL IDENTITY(1, 1),
[LastName] [nvarchar] (20) NOT NULL,
[FirstName] [nvarchar] (20) NOT NULL,
[Title] [nvarchar] (30) NULL,
[ReportsTo] [int] NULL,
[BirthDate] [datetime] NULL,
[HireDate] [datetime] NULL,
[Address] [nvarchar] (70) NULL,
[City] [nvarchar] (40) NULL,
[State] [nvarchar] (40) NULL,
[Country] [nvarchar] (40) NULL,
[PostalCode] [nvarchar] (10) NULL,
[Phone] [nvarchar] (24) NULL,
[Fax] [nvarchar] (24) NULL,
[Email] [nvarchar] (60) NULL
)
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeId])
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeReportsTo] ON [dbo].[Employee] ([ReportsTo])
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_EmployeeReportsTo] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
