CREATE TABLE [dbo].[Customers]
(
[CustomersId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL
)
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomersId])
GO
