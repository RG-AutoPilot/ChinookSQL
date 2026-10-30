SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP CONSTRAINT [PK_APIRateChange]
GO
PRINT N'Dropping constraints from [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] DROP CONSTRAINT [PK_ClaudeChange]
GO
PRINT N'Dropping constraints from [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] DROP CONSTRAINT [PK_SSISDemoReview]
GO
PRINT N'Dropping constraints from [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP CONSTRAINT [DF_APIRateChange_ChangedDate]
GO
PRINT N'Dropping index [IX_APIRateChange_APIKey_ChangedDate] from [dbo].[APIRateChange]'
GO
DROP INDEX [IX_APIRateChange_APIKey_ChangedDate] ON [dbo].[APIRateChange]
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] DROP
COLUMN [TestID],
COLUMN [HuxDemo],
COLUMN [TestRoger],
COLUMN [SDRDemo],
COLUMN [TestDemo]
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
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ALTER COLUMN [AlbumCopyright] [nvarchar] (24) NULL
GO
PRINT N'Creating [dbo].[getAmsterdamClients]'
GO
CREATE PROCEDURE [dbo].[getAmsterdamClients]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ab.*
    FROM dbo.AddressBook ab
    JOIN dbo.Customer c ON c.CustomerId = ab.CustomerId
    WHERE c.City = N'Amsterdam';
END
GO
PRINT N'Creating [dbo].[MCPExample]'
GO
CREATE TABLE [dbo].[MCPExample]
(
[MCPChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[getMCP]'
GO
--GO
CREATE PROCEDURE [dbo].[getMCP]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.MCPExample
END
GO
PRINT N'Creating [dbo].[MCPExampleChange]'
GO
CREATE TABLE [dbo].[MCPExampleChange]
(
[MCPChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[getMCPChange]'
GO
CREATE PROCEDURE [dbo].[getMCPChange]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.MCPExampleChange
END
GO
PRINT N'Altering [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] ADD
[CustomerProductsId] [int] NOT NULL IDENTITY(1, 1)
GO
ALTER TABLE [dbo].[CustomerProducts] ADD
[TestID] [int] NULL
GO
PRINT N'Creating primary key [PK_CustomerProducts] on [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] ADD CONSTRAINT [PK_CustomerProducts] PRIMARY KEY CLUSTERED ([CustomerProductsId])
GO
PRINT N'Altering [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] DROP
COLUMN [SSISDemoReviewId]
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
PRINT N'Altering [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP
COLUMN [APIRateChangeId],
COLUMN [ChangedDate]
GO
ALTER TABLE [dbo].[APIRateChange] ALTER COLUMN [APIKey] [int] NULL
GO
ALTER TABLE [dbo].[APIRateChange] ALTER COLUMN [APIRate] [decimal] (18, 0) NULL
GO
PRINT N'Altering [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] DROP
COLUMN [ClaudeChangeId]
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

