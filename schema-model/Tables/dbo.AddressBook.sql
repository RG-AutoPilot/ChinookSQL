CREATE TABLE [dbo].[AddressBook]
(
[AddressBookId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NULL,
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[Age] [int] NULL,
[TwitterID] [nchar] (10) NULL,
[Test] [nchar] (10) NULL,
[ReviewId] [int] NULL,
[SocialSignUp] [int] NULL,
[MCPChange] [int] NULL
)
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
GO
CREATE NONCLUSTERED INDEX [IFK_AddressBookCustomerId] ON [dbo].[AddressBook] ([CustomerId])
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [FK_AddressBookCustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
