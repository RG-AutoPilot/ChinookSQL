SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [CK_TrackReview_Rating]
GO
PRINT N'Creating [dbo].[AuditLog]'
GO
CREATE TABLE [dbo].[AuditLog]
(
[AuditLogId] [int] NOT NULL IDENTITY(1, 1),
[TableName] [nvarchar] (128) NOT NULL,
[Operation] [nvarchar] (10) NOT NULL,
[RecordId] [int] NOT NULL,
[ChangedBy] [nvarchar] (256) NOT NULL,
[ChangedDate] [datetime] NOT NULL CONSTRAINT [DF_AuditLog_ChangedDate] DEFAULT (getdate()),
[Details] [nvarchar] (max) NULL
)
GO
PRINT N'Creating primary key [PK_AuditLog] on [dbo].[AuditLog]'
GO
ALTER TABLE [dbo].[AuditLog] ADD CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED ([AuditLogId])
GO
PRINT N'Creating index [IX_AuditLog_ChangedDate] on [dbo].[AuditLog]'
GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_ChangedDate] ON [dbo].[AuditLog] ([ChangedDate])
GO
PRINT N'Creating index [IX_AuditLog_TableName] on [dbo].[AuditLog]'
GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_TableName] ON [dbo].[AuditLog] ([TableName])
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ADD
[AlbumGrossPay] [int] NULL
GO
PRINT N'Creating [dbo].[AlbumReview]'
GO
CREATE TABLE [dbo].[AlbumReview]
(
[ReviewId] [int] NOT NULL,
[AlbumId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_AlbumReview] on [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [PK_AlbumReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Adding constraints to [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [UQ_AlbumReview_Album_Customer] UNIQUE NONCLUSTERED ([AlbumId], [CustomerId])
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[HuxDemo] [int] NULL,
[TestRoger] [int] NULL,
[SDRDemo] [int] NULL,
[TestDemo] [int] NULL,
[CustomerLoyalty] [nvarchar] (24) NULL,
[SalesRep] [nvarchar] (60) NULL,
[PricePaid] [decimal] (10, 2) NULL
GO
PRINT N'Altering [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] ADD
[ManagerId] [int] NULL
GO
PRINT N'Creating [dbo].[PlaylistTag]'
GO
CREATE TABLE [dbo].[PlaylistTag]
(
[PlaylistId] [int] NOT NULL,
[Tag] [nvarchar] (120) NOT NULL
)
GO
PRINT N'Creating primary key [PK_PlaylistTag] on [dbo].[PlaylistTag]'
GO
ALTER TABLE [dbo].[PlaylistTag] ADD CONSTRAINT [PK_PlaylistTag] PRIMARY KEY NONCLUSTERED ([PlaylistId], [Tag])
GO
PRINT N'Creating [dbo].[StaffCSATReview]'
GO
CREATE TABLE [dbo].[StaffCSATReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[EmployeeId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Rating] [int] NOT NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_StaffCSATReview] on [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [PK_StaffCSATReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Creating index [IFK_StaffCSATReview_Customer] on [dbo].[StaffCSATReview]'
GO
CREATE NONCLUSTERED INDEX [IFK_StaffCSATReview_Customer] ON [dbo].[StaffCSATReview] ([CustomerId])
GO
PRINT N'Creating index [IFK_StaffCSATReview_Employee] on [dbo].[StaffCSATReview]'
GO
CREATE NONCLUSTERED INDEX [IFK_StaffCSATReview_Employee] ON [dbo].[StaffCSATReview] ([EmployeeId])
GO
PRINT N'Rebuilding [dbo].[TrackReview]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
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
PRINT N'Creating primary key [PK_TrackReview] on [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [PK_TrackReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Creating [dbo].[AddressBook]'
GO
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
PRINT N'Creating primary key [PK_AddressBook] on [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
GO
PRINT N'Creating [dbo].[getAddress]'
GO
--GO
CREATE PROCEDURE [dbo].[getAddress]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.AddressBook
END
GO
PRINT N'Creating [dbo].[getCustInfo]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[getCustInfo]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.Customer
END
GO
PRINT N'Creating [dbo].[getGrossPay]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[getGrossPay]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.Album
END
GO
PRINT N'Creating [dbo].[CustomerProducts]'
GO
CREATE TABLE [dbo].[CustomerProducts]
(
[FirstName] [nvarchar] (24) NULL,
[Company] [nvarchar] (24) NULL,
[Products] [nvarchar] (24) NULL
)
GO
PRINT N'Creating [dbo].[getProducts]'
GO
--GO
CREATE PROCEDURE [dbo].[getProducts]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.CustomerProducts
END
GO
PRINT N'Altering [dbo].[sp_SalesReport]'
GO

ALTER PROCEDURE [dbo].[sp_SalesReport]
    @StartDate DATE = NULL,
    @EndDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
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
PRINT N'Creating [dbo].[sp_StaffCSATReport]'
GO
CREATE PROCEDURE [dbo].[sp_StaffCSATReport]
    @EmployeeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Title,
        COUNT(r.ReviewId) AS TotalReviews,
        ISNULL(AVG(CAST(r.Rating AS DECIMAL(3,2))), 0) AS AverageRating,
        MIN(r.Rating) AS MinRating,
        MAX(r.Rating) AS MaxRating,
        MAX(r.ReviewDate) AS LastReviewDate
    FROM dbo.Employee e
    LEFT JOIN dbo.StaffCSATReview r ON e.EmployeeId = r.EmployeeId
    WHERE (@EmployeeId IS NULL OR e.EmployeeId = @EmployeeId)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title
    ORDER BY AverageRating DESC;
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
PRINT N'Creating [dbo].[Customers]'
GO
CREATE TABLE [dbo].[Customers]
(
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL
)
GO
PRINT N'Creating [dbo].[FlightStatus]'
GO
CREATE TABLE [dbo].[FlightStatus]
(
[CustomerInfo] [int] NULL
)
GO
PRINT N'Creating [dbo].[FlightTracker]'
GO
CREATE TABLE [dbo].[FlightTracker]
(
[FlightID] [int] NULL,
[FlightNumber] [int] NULL
)
GO
PRINT N'Adding constraints to [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [CK_AlbumReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding constraints to [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [CK_StaffCSATReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding constraints to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [FK_AlbumReview_Album] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[AlbumReview] ADD CONSTRAINT [FK_AlbumReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
PRINT N'Adding foreign keys to [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_EmployeeManagerId] FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
PRINT N'Adding foreign keys to [dbo].[PlaylistTag]'
GO
ALTER TABLE [dbo].[PlaylistTag] ADD CONSTRAINT [FK_PlaylistTagPlaylistId] FOREIGN KEY ([PlaylistId]) REFERENCES [dbo].[Playlist] ([PlaylistId])
GO
PRINT N'Adding foreign keys to [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [FK_StaffCSATReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [FK_StaffCSATReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
PRINT N'Adding foreign keys to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [FK_TrackReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [FK_TrackReview_Track] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

PRINT(N'Add 2 rows to [dbo].[AppConfig]')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (4, N'Central', N'ON')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (5, N'Prod', N'ON')

