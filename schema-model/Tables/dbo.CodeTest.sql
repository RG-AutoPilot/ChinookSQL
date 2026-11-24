CREATE TABLE [dbo].CodeTest
(
[AddressBookId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NULL,
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL,
[Age] [int] NULL,
[TwitterID] [nchar] (10) NULL,
[Test] [nchar] (10) NULL,
[ReviewId] [int] NULL,
[SocialSingUp] [int] NULL,
[MCPChange] [int] NULL,
[PayingCustomer] [int] NULL
)
GO

