SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [FK_AlbumReview_Album]
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [FK_AlbumReview_Customer]
GO
PRINT N'Dropping foreign keys from [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT [FK_EmployeeManagerId]
GO
PRINT N'Dropping foreign keys from [dbo].[PlaylistTag]'
GO
ALTER TABLE [dbo].[PlaylistTag] DROP CONSTRAINT [FK_PlaylistTagPlaylistId]
GO
PRINT N'Dropping foreign keys from [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] DROP CONSTRAINT [FK_StaffCSATReview_Employee]
GO
ALTER TABLE [dbo].[StaffCSATReview] DROP CONSTRAINT [FK_StaffCSATReview_Customer]
GO
PRINT N'Dropping foreign keys from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [FK_TrackReview_Customer]
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [FK_TrackReview_Track]
GO
PRINT N'Dropping constraints from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [CK_AlbumReview_Rating]
GO
PRINT N'Dropping constraints from [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] DROP CONSTRAINT [CK_StaffCSATReview_Rating]
GO
PRINT N'Dropping constraints from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [CK_TrackReview_Rating]
GO
PRINT N'Dropping constraints from [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] DROP CONSTRAINT [PK_AddressBook]
GO
PRINT N'Dropping constraints from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [PK_AlbumReview]
GO
PRINT N'Dropping constraints from [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] DROP CONSTRAINT [UQ_AlbumReview_Album_Customer]
GO
PRINT N'Dropping constraints from [dbo].[AuditLog]'
GO
ALTER TABLE [dbo].[AuditLog] DROP CONSTRAINT [PK_AuditLog]
GO
PRINT N'Dropping constraints from [dbo].[PlaylistTag]'
GO
ALTER TABLE [dbo].[PlaylistTag] DROP CONSTRAINT [PK_PlaylistTag]
GO
PRINT N'Dropping constraints from [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] DROP CONSTRAINT [PK_StaffCSATReview]
GO
PRINT N'Dropping constraints from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [PK_TrackReview]
GO
PRINT N'Dropping constraints from [dbo].[AuditLog]'
GO
ALTER TABLE [dbo].[AuditLog] DROP CONSTRAINT [DF_AuditLog_ChangedDate]
GO
PRINT N'Dropping index [IX_AuditLog_TableName] from [dbo].[AuditLog]'
GO
DROP INDEX [IX_AuditLog_TableName] ON [dbo].[AuditLog]
GO
PRINT N'Dropping index [IX_AuditLog_ChangedDate] from [dbo].[AuditLog]'
GO
DROP INDEX [IX_AuditLog_ChangedDate] ON [dbo].[AuditLog]
GO
PRINT N'Dropping index [IFK_StaffCSATReview_Employee] from [dbo].[StaffCSATReview]'
GO
DROP INDEX [IFK_StaffCSATReview_Employee] ON [dbo].[StaffCSATReview]
GO
PRINT N'Dropping index [IFK_StaffCSATReview_Customer] from [dbo].[StaffCSATReview]'
GO
DROP INDEX [IFK_StaffCSATReview_Customer] ON [dbo].[StaffCSATReview]
GO
PRINT N'Dropping [dbo].[FlightTracker]'
GO
DROP TABLE [dbo].[FlightTracker]
GO
PRINT N'Dropping [dbo].[FlightStatus]'
GO
DROP TABLE [dbo].[FlightStatus]
GO
PRINT N'Dropping [dbo].[Customers]'
GO
DROP TABLE [dbo].[Customers]
GO
PRINT N'Dropping [dbo].[sp_StaffCSATReport]'
GO
DROP PROCEDURE [dbo].[sp_StaffCSATReport]
GO
PRINT N'Dropping [dbo].[getProducts]'
GO
DROP PROCEDURE [dbo].[getProducts]
GO
PRINT N'Dropping [dbo].[CustomerProducts]'
GO
DROP TABLE [dbo].[CustomerProducts]
GO
PRINT N'Dropping [dbo].[getGrossPay]'
GO
DROP PROCEDURE [dbo].[getGrossPay]
GO
PRINT N'Dropping [dbo].[getCustInfo]'
GO
DROP PROCEDURE [dbo].[getCustInfo]
GO
PRINT N'Dropping [dbo].[getAddress]'
GO
DROP PROCEDURE [dbo].[getAddress]
GO
PRINT N'Dropping [dbo].[AddressBook]'
GO
DROP TABLE [dbo].[AddressBook]
GO
PRINT N'Dropping [dbo].[StaffCSATReview]'
GO
DROP TABLE [dbo].[StaffCSATReview]
GO
PRINT N'Dropping [dbo].[PlaylistTag]'
GO
DROP TABLE [dbo].[PlaylistTag]
GO
PRINT N'Dropping [dbo].[AlbumReview]'
GO
DROP TABLE [dbo].[AlbumReview]
GO
PRINT N'Dropping [dbo].[AuditLog]'
GO
DROP TABLE [dbo].[AuditLog]
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] DROP
COLUMN [AlbumGrossPay]
GO
PRINT N'Altering [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] DROP
COLUMN [ManagerId]
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] DROP
COLUMN [HuxDemo],
COLUMN [TestRoger],
COLUMN [SDRDemo],
COLUMN [TestDemo],
COLUMN [CustomerLoyalty],
COLUMN [SalesRep],
COLUMN [PricePaid]
GO
PRINT N'Altering [dbo].[sp_SalesReport]'
GO
ALTER PROCEDURE [dbo].[sp_SalesReport]
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    -- Created by Huxley, changed number of days to 31
    -- Default to last 31 days if no dates provided
    IF @StartDate IS NULL SET @StartDate = DATEADD(DAY, -31, GETDATE());
    IF @EndDate IS NULL SET @EndDate = GETDATE();
    
    SELECT 
        CAST(i.InvoiceDate AS DATE) AS SaleDate,
        COUNT(i.InvoiceId) AS InvoiceCount,
        SUM(i.Total) AS DailyRevenue,
        AVG(i.Total) AS AverageInvoiceValue,
        COUNT(DISTINCT i.CustomerId) AS UniqueCustomers,
        SUM(il.Quantity) AS ItemsSold
    FROM Invoice i
    JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
    WHERE i.InvoiceDate BETWEEN @StartDate AND @EndDate
    GROUP BY CAST(i.InvoiceDate AS DATE)
    ORDER BY SaleDate DESC;
END;
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
PRINT N'Rebuilding [dbo].[TrackReview]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[ReviewerName] [nvarchar] (100) NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
INSERT INTO [dbo].[RG_Recovery_1_TrackReview]([ReviewId], [TrackId], [Rating], [ReviewText], [ReviewDate]) SELECT [ReviewId], [TrackId], [Rating], [ReviewText], [ReviewDate] FROM [dbo].[TrackReview]
GO
DROP TABLE [dbo].[TrackReview]
GO
EXEC sp_rename N'[dbo].[RG_Recovery_1_TrackReview]', N'TrackReview', N'OBJECT'
GO
PRINT N'Adding constraints to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

PRINT(N'Delete 2 rows from [dbo].[AppConfig]')
DELETE FROM [dbo].[AppConfig] WHERE [ConfigId] = 4
DELETE FROM [dbo].[AppConfig] WHERE [ConfigId] = 5

