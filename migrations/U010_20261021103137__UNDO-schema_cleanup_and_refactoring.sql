SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] DROP CONSTRAINT [FK_AddressBookCustomerId]
GO
PRINT N'Dropping constraints from [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] DROP CONSTRAINT [PK_CustomerProducts]
GO
PRINT N'Dropping constraints from [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] DROP CONSTRAINT [PK_Customers]
GO
PRINT N'Dropping constraints from [dbo].[FlightStatus]'
GO
ALTER TABLE [dbo].[FlightStatus] DROP CONSTRAINT [PK_FlightStatus]
GO
PRINT N'Dropping constraints from [dbo].[FlightTracker]'
GO
ALTER TABLE [dbo].[FlightTracker] DROP CONSTRAINT [PK_FlightTracker]
GO
PRINT N'Dropping index [IFK_AddressBookCustomerId] from [dbo].[AddressBook]'
GO
DROP INDEX [IFK_AddressBookCustomerId] ON [dbo].[AddressBook]
GO
PRINT N'Dropping [dbo].[getMCPChange]'
GO
DROP PROCEDURE [dbo].[getMCPChange]
GO
PRINT N'Dropping [dbo].[MCPExampleChange]'
GO
DROP TABLE [dbo].[MCPExampleChange]
GO
PRINT N'Dropping [dbo].[getMCP]'
GO
DROP PROCEDURE [dbo].[getMCP]
GO
PRINT N'Dropping [dbo].[MCPExample]'
GO
DROP TABLE [dbo].[MCPExample]
GO
PRINT N'Dropping [dbo].[getAmsterdamClients]'
GO
DROP PROCEDURE [dbo].[getAmsterdamClients]
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ALTER COLUMN [AlbumCopyright] [nvarchar] (200) NULL
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[TestID] [int] NULL,
[HuxDemo] [int] NULL,
[TestRoger] [int] NULL,
[SDRDemo] [int] NULL,
[TestDemo] [int] NULL
GO
PRINT N'Refreshing [dbo].[vw_CustomerInvoiceSummary]'
GO
EXEC sp_refreshview N'[dbo].[vw_CustomerInvoiceSummary]'
GO
PRINT N'Refreshing [dbo].[vw_EmployeePerformance]'
GO
EXEC sp_refreshview N'[dbo].[vw_EmployeePerformance]'
GO
PRINT N'Refreshing [dbo].[vw_GenreStatistics]'
GO
EXEC sp_refreshview N'[dbo].[vw_GenreStatistics]'
GO
PRINT N'Refreshing [dbo].[vw_TrackPopularity]'
GO
EXEC sp_refreshview N'[dbo].[vw_TrackPopularity]'
GO
PRINT N'Altering [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] DROP
COLUMN [CustomerId]
GO
PRINT N'Altering [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] DROP
COLUMN [CustomerProductsId],
COLUMN [TestID]
GO
PRINT N'Altering [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] ADD
[SSISDemoReviewId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_SSISDemoReview] on [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] ADD CONSTRAINT [PK_SSISDemoReview] PRIMARY KEY CLUSTERED ([SSISDemoReviewId])
GO
PRINT N'Altering [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] ADD
[APIRateChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
ALTER TABLE [dbo].[APIRateChange] ADD
[ChangedDate] [datetime] NOT NULL CONSTRAINT [DF_APIRateChange_ChangedDate] DEFAULT (getdate())
GO
ALTER TABLE [dbo].[APIRateChange] ALTER COLUMN [APIKey] [int] NOT NULL
GO
ALTER TABLE [dbo].[APIRateChange] ALTER COLUMN [APIRate] [decimal] (18, 4) NOT NULL
GO
PRINT N'Creating primary key [PK_APIRateChange] on [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] ADD CONSTRAINT [PK_APIRateChange] PRIMARY KEY CLUSTERED ([APIRateChangeId])
GO
PRINT N'Creating index [IX_APIRateChange_APIKey_ChangedDate] on [dbo].[APIRateChange]'
GO
CREATE NONCLUSTERED INDEX [IX_APIRateChange_APIKey_ChangedDate] ON [dbo].[APIRateChange] ([APIKey], [ChangedDate])
GO
PRINT N'Altering [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] ADD
[ClaudeChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_ClaudeChange] on [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] ADD CONSTRAINT [PK_ClaudeChange] PRIMARY KEY CLUSTERED ([ClaudeChangeId])
GO
PRINT N'Altering [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] DROP
COLUMN [CustomersId]
GO
PRINT N'Altering [dbo].[FlightStatus]'
GO
ALTER TABLE [dbo].[FlightStatus] DROP
COLUMN [FlightStatusId]
GO
PRINT N'Altering [dbo].[FlightTracker]'
GO
ALTER TABLE [dbo].[FlightTracker] DROP
COLUMN [FlightTrackerId]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

