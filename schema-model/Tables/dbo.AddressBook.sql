CREATE TABLE [dbo].[AddressBook]
(
[AddressBookId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[Age] [int] NULL,
[TwitterID] [nchar] (10) NULL,
[Test] [nchar] (10) NULL,
[ReviewId] [int] NULL,
CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
)
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [FK_AddressBook_MCPReview] FOREIGN KEY ([ReviewId]) REFERENCES [dbo].[MCPReview] ([ReviewId])
GO
