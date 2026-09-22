SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] ADD
[CustomerId] [int] NULL
GO
PRINT N'Creating index [IFK_AddressBookCustomerId] on [dbo].[AddressBook]'
GO
CREATE NONCLUSTERED INDEX [IFK_AddressBookCustomerId] ON [dbo].[AddressBook] ([CustomerId])
GO
PRINT N'Altering [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] ADD
[CustomerProductsId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_CustomerProducts] on [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] ADD CONSTRAINT [PK_CustomerProducts] PRIMARY KEY CLUSTERED ([CustomerProductsId])
GO
PRINT N'Altering [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ADD
[CustomersId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_Customers] on [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomersId])
GO
PRINT N'Altering [dbo].[FlightStatus]'
GO
ALTER TABLE [dbo].[FlightStatus] ADD
[FlightStatusId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_FlightStatus] on [dbo].[FlightStatus]'
GO
ALTER TABLE [dbo].[FlightStatus] ADD CONSTRAINT [PK_FlightStatus] PRIMARY KEY CLUSTERED ([FlightStatusId])
GO
PRINT N'Altering [dbo].[FlightTracker]'
GO
ALTER TABLE [dbo].[FlightTracker] ADD
[FlightTrackerId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_FlightTracker] on [dbo].[FlightTracker]'
GO
ALTER TABLE [dbo].[FlightTracker] ADD CONSTRAINT [PK_FlightTracker] PRIMARY KEY CLUSTERED ([FlightTrackerId])
GO
PRINT N'Adding foreign keys to [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [FK_AddressBookCustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

