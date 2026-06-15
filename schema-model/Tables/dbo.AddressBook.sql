CREATE TABLE [dbo].[AddressBook]
(
[AddressBookId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[Age] [int] NULL,
CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
)
GO
