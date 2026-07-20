CREATE TABLE [dbo].[AddressBook]
(
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[Age] [int] NULL,
[AddressBookId] [int] NOT NULL IDENTITY(1, 1)
)
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
GO
