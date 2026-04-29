CREATE TABLE [dbo].[Customer]
(
[CustomerId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (40) NOT NULL,
[LastName] [nvarchar] (20) NOT NULL,
[Company] [nvarchar] (80) NULL,
[Address] [nvarchar] (70) NULL,
[City] [nvarchar] (40) NULL,
[State] [nvarchar] (40) NULL,
[Country] [nvarchar] (40) NULL,
[PostalCode] [nvarchar] (10) NULL,
[Phone] [nvarchar] (24) NULL,
[Fax] [nvarchar] (24) NULL,
[Email] [nvarchar] (60) NOT NULL,
[SupportRepId] [int] NULL
)
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerId])
GO
CREATE NONCLUSTERED INDEX [IFK_CustomerSupportRepId] ON [dbo].[Customer] ([SupportRepId])
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_CustomerSupportRepId] FOREIGN KEY ([SupportRepId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
