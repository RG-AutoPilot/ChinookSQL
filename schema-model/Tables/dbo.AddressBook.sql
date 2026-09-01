CREATE TABLE [dbo].[AddressBook]
(
[AddressBookId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[Age] [int] NULL,
[TwitterID] [nchar] (10) NULL,
[Test] [nchar] (10) NULL,
[ReviewId] [int] NULL
)
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
GO
