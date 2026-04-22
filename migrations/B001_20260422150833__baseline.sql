SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[Artist]'
GO
CREATE TABLE [dbo].[Artist]
(
[ArtistId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
PRINT N'Creating primary key [PK_Artist] on [dbo].[Artist]'
GO
ALTER TABLE [dbo].[Artist] ADD CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED ([ArtistId])
GO
PRINT N'Creating [dbo].[Album]'
GO
CREATE TABLE [dbo].[Album]
(
[AlbumId] [int] NOT NULL IDENTITY(1, 1),
[Title] [nvarchar] (160) NOT NULL,
[ArtistId] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Album] on [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ADD CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED ([AlbumId])
GO
PRINT N'Creating index [IFK_AlbumArtistId] on [dbo].[Album]'
GO
CREATE NONCLUSTERED INDEX [IFK_AlbumArtistId] ON [dbo].[Album] ([ArtistId])
GO
PRINT N'Creating [dbo].[Employee]'
GO
CREATE TABLE [dbo].[Employee]
(
[EmployeeId] [int] NOT NULL IDENTITY(1, 1),
[LastName] [nvarchar] (20) NOT NULL,
[FirstName] [nvarchar] (20) NOT NULL,
[Title] [nvarchar] (30) NULL,
[ReportsTo] [int] NULL,
[BirthDate] [datetime] NULL,
[HireDate] [datetime] NULL,
[Address] [nvarchar] (70) NULL,
[City] [nvarchar] (40) NULL,
[State] [nvarchar] (40) NULL,
[Country] [nvarchar] (40) NULL,
[PostalCode] [nvarchar] (10) NULL,
[Phone] [nvarchar] (24) NULL,
[Fax] [nvarchar] (24) NULL,
[Email] [nvarchar] (60) NULL
)
GO
PRINT N'Creating primary key [PK_Employee] on [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED ([EmployeeId])
GO
PRINT N'Creating index [IFK_EmployeeReportsTo] on [dbo].[Employee]'
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeReportsTo] ON [dbo].[Employee] ([ReportsTo])
GO
PRINT N'Creating [dbo].[Customer]'
GO
CREATE TABLE [dbo].[Customer]
(
[CustomerId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (40) NOT NULL,
[LastName] [nvarchar] (20) NOT NULL,
[Company] [nvarchar] (80) NULL,
[Address] [nvarchar] (70) NULL,
[City] [nvarchar] (40) NULL,
[State] [nvarchar] (40) NULL,
[Country] [nvarchar] (40) NULL,
[PostalCode] [nvarchar] (10) NULL,
[Phone] [nvarchar] (24) NULL,
[Fax] [nvarchar] (24) NULL,
[Email] [nvarchar] (60) NOT NULL,
[SupportRepId] [int] NULL
)
GO
PRINT N'Creating primary key [PK_Customer] on [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerId])
GO
PRINT N'Creating index [IFK_CustomerSupportRepId] on [dbo].[Customer]'
GO
CREATE NONCLUSTERED INDEX [IFK_CustomerSupportRepId] ON [dbo].[Customer] ([SupportRepId])
GO
PRINT N'Creating [dbo].[Invoice]'
GO
CREATE TABLE [dbo].[Invoice]
(
[InvoiceId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[InvoiceDate] [datetime] NOT NULL,
[BillingAddress] [nvarchar] (70) NULL,
[BillingCity] [nvarchar] (40) NULL,
[BillingState] [nvarchar] (40) NULL,
[BillingCountry] [nvarchar] (40) NULL,
[BillingPostalCode] [nvarchar] (10) NULL,
[Total] [numeric] (10, 2) NOT NULL
)
GO
PRINT N'Creating primary key [PK_Invoice] on [dbo].[Invoice]'
GO
ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED ([InvoiceId])
GO
PRINT N'Creating index [IFK_InvoiceCustomerId] on [dbo].[Invoice]'
GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceCustomerId] ON [dbo].[Invoice] ([CustomerId])
GO
PRINT N'Creating [dbo].[InvoiceLine]'
GO
CREATE TABLE [dbo].[InvoiceLine]
(
[InvoiceLineId] [int] NOT NULL IDENTITY(1, 1),
[InvoiceId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[UnitPrice] [numeric] (10, 2) NOT NULL,
[Quantity] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_InvoiceLine] on [dbo].[InvoiceLine]'
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED ([InvoiceLineId])
GO
PRINT N'Creating index [IFK_InvoiceLineInvoiceId] on [dbo].[InvoiceLine]'
GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceLineInvoiceId] ON [dbo].[InvoiceLine] ([InvoiceId])
GO
PRINT N'Creating index [IFK_InvoiceLineTrackId] on [dbo].[InvoiceLine]'
GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceLineTrackId] ON [dbo].[InvoiceLine] ([TrackId])
GO
PRINT N'Creating [dbo].[Track]'
GO
CREATE TABLE [dbo].[Track]
(
[TrackId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (200) NOT NULL,
[AlbumId] [int] NULL,
[MediaTypeId] [int] NOT NULL,
[GenreId] [int] NULL,
[Composer] [nvarchar] (220) NULL,
[Milliseconds] [int] NOT NULL,
[Bytes] [int] NULL,
[UnitPrice] [numeric] (10, 2) NOT NULL
)
GO
PRINT N'Creating primary key [PK_Track] on [dbo].[Track]'
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED ([TrackId])
GO
PRINT N'Creating index [IFK_TrackAlbumId] on [dbo].[Track]'
GO
CREATE NONCLUSTERED INDEX [IFK_TrackAlbumId] ON [dbo].[Track] ([AlbumId])
GO
PRINT N'Creating index [IFK_TrackGenreId] on [dbo].[Track]'
GO
CREATE NONCLUSTERED INDEX [IFK_TrackGenreId] ON [dbo].[Track] ([GenreId])
GO
PRINT N'Creating index [IFK_TrackMediaTypeId] on [dbo].[Track]'
GO
CREATE NONCLUSTERED INDEX [IFK_TrackMediaTypeId] ON [dbo].[Track] ([MediaTypeId])
GO
PRINT N'Creating [dbo].[Playlist]'
GO
CREATE TABLE [dbo].[Playlist]
(
[PlaylistId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
PRINT N'Creating primary key [PK_Playlist] on [dbo].[Playlist]'
GO
ALTER TABLE [dbo].[Playlist] ADD CONSTRAINT [PK_Playlist] PRIMARY KEY CLUSTERED ([PlaylistId])
GO
PRINT N'Creating [dbo].[PlaylistTrack]'
GO
CREATE TABLE [dbo].[PlaylistTrack]
(
[PlaylistId] [int] NOT NULL,
[TrackId] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_PlaylistTrack] on [dbo].[PlaylistTrack]'
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [PK_PlaylistTrack] PRIMARY KEY NONCLUSTERED ([PlaylistId], [TrackId])
GO
PRINT N'Creating index [IFK_PlaylistTrackPlaylistId] on [dbo].[PlaylistTrack]'
GO
CREATE NONCLUSTERED INDEX [IFK_PlaylistTrackPlaylistId] ON [dbo].[PlaylistTrack] ([PlaylistId])
GO
PRINT N'Creating index [IFK_PlaylistTrackTrackId] on [dbo].[PlaylistTrack]'
GO
CREATE NONCLUSTERED INDEX [IFK_PlaylistTrackTrackId] ON [dbo].[PlaylistTrack] ([TrackId])
GO
PRINT N'Creating [dbo].[SystemLog]'
GO
CREATE TABLE [dbo].[SystemLog]
(
[LogId] [int] NOT NULL,
[InvoiceId] [int] NOT NULL,
[LogDate] [datetime] NOT NULL,
[LogMessage] [nvarchar] (max) NULL
)
GO
PRINT N'Creating primary key [PK_SystemLog] on [dbo].[SystemLog]'
GO
ALTER TABLE [dbo].[SystemLog] ADD CONSTRAINT [PK_SystemLog] PRIMARY KEY CLUSTERED ([LogId])
GO
PRINT N'Creating [dbo].[Genre]'
GO
CREATE TABLE [dbo].[Genre]
(
[GenreId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
PRINT N'Creating primary key [PK_Genre] on [dbo].[Genre]'
GO
ALTER TABLE [dbo].[Genre] ADD CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED ([GenreId])
GO
PRINT N'Creating [dbo].[MediaType]'
GO
CREATE TABLE [dbo].[MediaType]
(
[MediaTypeId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
PRINT N'Creating primary key [PK_MediaType] on [dbo].[MediaType]'
GO
ALTER TABLE [dbo].[MediaType] ADD CONSTRAINT [PK_MediaType] PRIMARY KEY CLUSTERED ([MediaTypeId])
GO
PRINT N'Creating [dbo].[sp_CustomerSummary]'
GO
CREATE PROCEDURE [dbo].[sp_CustomerSummary]
    @CustomerId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        c.CustomerId,
        c.FirstName + ' ' + c.LastName AS FullName,
        c.Email,
        c.Country,
        COUNT(i.InvoiceId) AS TotalInvoices,
        ISNULL(SUM(i.Total), 0) AS TotalSpent,
        ISNULL(AVG(i.Total), 0) AS AverageOrderValue,
        MAX(i.InvoiceDate) AS LastPurchaseDate,
        (SELECT COUNT(*) FROM InvoiceLine il 
         JOIN Invoice i2 ON il.InvoiceId = i2.InvoiceId 
         WHERE i2.CustomerId = c.CustomerId) AS TotalItemsPurchased
    FROM Customer c
    LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
    WHERE c.CustomerId = @CustomerId
    GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Email, c.Country;
END;
GO
PRINT N'Creating [dbo].[sp_EmployeeStats]'
GO
CREATE PROCEDURE [dbo].[sp_EmployeeStats]
    @EmployeeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Title,
        COUNT(c.CustomerId) AS CustomersSupported,
        COUNT(i.InvoiceId) AS TotalInvoices,
        ISNULL(SUM(i.Total), 0) AS TotalSalesGenerated,
        ISNULL(AVG(i.Total), 0) AS AverageInvoiceValue
    FROM Employee e
    LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
    LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
    WHERE (@EmployeeId IS NULL OR e.EmployeeId = @EmployeeId)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title
    ORDER BY TotalSalesGenerated DESC;
END;
GO
PRINT N'Creating [dbo].[sp_InvoiceReport]'
GO
CREATE PROCEDURE [dbo].[sp_InvoiceReport]
    @InvoiceId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Simulate a junior developer's approach with inefficient queries
    -- Multiple unnecessary subqueries and cross joins
    SELECT DISTINCT
        t.TrackId,
        t.Name AS TrackName,
        t.Composer,
        t.GenreId,
        t.Milliseconds,
        (SELECT TOP 1 UnitPrice FROM InvoiceLine 
         WHERE InvoiceId = @InvoiceId AND TrackId = t.TrackId) AS UnitPrice,
        (SELECT TOP 1 Quantity FROM InvoiceLine 
         WHERE InvoiceId = @InvoiceId AND TrackId = t.TrackId) AS Quantity,
        -- Unnecessary subqueries for demo purposes
        (SELECT COUNT(*) FROM Album WHERE AlbumId = t.AlbumId) AS AlbumTrackCount,
        (SELECT Name FROM Genre WHERE GenreId = t.GenreId) AS GenreName
    FROM Track t
    CROSS JOIN Invoice i2
    WHERE t.TrackId IN (
        SELECT DISTINCT il2.TrackId
        FROM InvoiceLine il2
        WHERE il2.InvoiceId = @InvoiceId
        AND EXISTS (
            SELECT 1 FROM Invoice i3 
            WHERE i3.InvoiceId = il2.InvoiceId
            AND i3.InvoiceId = @InvoiceId
        )
    )
    AND EXISTS (
        SELECT 1 FROM InvoiceLine il3
        WHERE il3.TrackId = t.TrackId
        AND il3.InvoiceId = @InvoiceId
    )
    AND i2.InvoiceId = @InvoiceId
    AND EXISTS (
        SELECT 1 FROM InvoiceLine il4
        WHERE il4.InvoiceId = @InvoiceId
        AND il4.TrackId = t.TrackId
    );
    
    -- Add artificial delay for demonstration
    WAITFOR DELAY '00:00:02';
END;
GO
PRINT N'Creating [dbo].[sp_SalesReport]'
GO
CREATE   PROCEDURE [dbo].[sp_SalesReport]
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
PRINT N'Creating [dbo].[sp_TopTracks]'
GO
CREATE PROCEDURE [dbo].[sp_TopTracks]
    @TopCount INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT TOP (@TopCount)
        t.TrackId,
        t.Name AS TrackName,
        a.Title AS AlbumTitle,
        ar.Name AS ArtistName,
        g.Name AS GenreName,
        COUNT(il.InvoiceLineId) AS TimesPurchased,
        SUM(il.Quantity) AS TotalQuantitySold,
        SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
    FROM Track t
    JOIN Album a ON t.AlbumId = a.AlbumId
    JOIN Artist ar ON a.ArtistId = ar.ArtistId
    JOIN Genre g ON t.GenreId = g.GenreId
    LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
    GROUP BY t.TrackId, t.Name, a.Title, ar.Name, g.Name
    ORDER BY TimesPurchased DESC, TotalRevenue DESC;
END;
GO
PRINT N'Creating [dbo].[vw_CustomerInvoiceSummary]'
GO
CREATE VIEW [dbo].[vw_CustomerInvoiceSummary] AS
SELECT 
    c.CustomerId,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email,
    c.Country,
    c.City,
    COUNT(i.InvoiceId) AS TotalInvoices,
    ISNULL(SUM(i.Total), 0) AS TotalSpent,
    ISNULL(AVG(i.Total), 0) AS AverageOrderValue,
    MIN(i.InvoiceDate) AS FirstPurchase,
    MAX(i.InvoiceDate) AS LastPurchase,
    DATEDIFF(DAY, MIN(i.InvoiceDate), MAX(i.InvoiceDate)) AS CustomerLifespanDays
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId, c.FirstName, c.LastName, c.Email, c.Country, c.City;
GO
PRINT N'Creating [dbo].[vw_EmployeePerformance]'
GO
CREATE VIEW [dbo].[vw_EmployeePerformance] AS
SELECT 
    e.EmployeeId,
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    e.Title,
    COUNT(DISTINCT c.CustomerId) AS CustomersSupported,
    COUNT(i.InvoiceId) AS TotalInvoices,
    ISNULL(SUM(i.Total), 0) AS TotalSalesGenerated,
    ISNULL(AVG(i.Total), 0) AS AverageInvoiceValue,
    CASE 
        WHEN COUNT(i.InvoiceId) > 50 THEN 'High Performer'
        WHEN COUNT(i.InvoiceId) > 20 THEN 'Good Performer'
        ELSE 'Developing'
    END AS PerformanceCategory
FROM Employee e
LEFT JOIN Customer c ON e.EmployeeId = c.SupportRepId
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title;
GO
PRINT N'Creating [dbo].[vw_GenreStatistics]'
GO
CREATE VIEW [dbo].[vw_GenreStatistics] AS
SELECT 
    g.GenreId,
    g.Name AS GenreName,
    COUNT(DISTINCT t.TrackId) AS TotalTracks,
    COUNT(DISTINCT a.AlbumId) AS TotalAlbums,
    COUNT(DISTINCT ar.ArtistId) AS TotalArtists,
    COUNT(il.InvoiceLineId) AS TimesPurchased,
    SUM(il.Quantity) AS TotalQuantitySold,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue,
    AVG(il.UnitPrice) AS AverageTrackPrice
FROM Genre g
LEFT JOIN Track t ON g.GenreId = t.GenreId
LEFT JOIN Album a ON t.AlbumId = a.AlbumId
LEFT JOIN Artist ar ON a.ArtistId = ar.ArtistId
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY g.GenreId, g.Name;
GO
PRINT N'Creating [dbo].[vw_MonthlyRevenue]'
GO
CREATE VIEW [dbo].[vw_MonthlyRevenue] AS
SELECT 
    YEAR(i.InvoiceDate) AS RevenueYear,
    MONTH(i.InvoiceDate) AS RevenueMonth,
    DATENAME(MONTH, i.InvoiceDate) AS MonthName,
    COUNT(i.InvoiceId) AS InvoiceCount,
    SUM(i.Total) AS MonthlyRevenue,
    AVG(i.Total) AS AverageInvoiceValue,
    COUNT(DISTINCT i.CustomerId) AS UniqueCustomers,
    SUM(il.Quantity) AS ItemsSold
FROM Invoice i
JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY YEAR(i.InvoiceDate), MONTH(i.InvoiceDate), DATENAME(MONTH, i.InvoiceDate);
GO
PRINT N'Creating [dbo].[vw_TrackPopularity]'
GO
CREATE VIEW [dbo].[vw_TrackPopularity] AS
SELECT 
    t.TrackId,
    t.Name AS TrackName,
    a.Title AS AlbumTitle,
    ar.Name AS ArtistName,
    g.Name AS GenreName,
    t.Milliseconds,
    COUNT(il.InvoiceLineId) AS TimesPurchased,
    SUM(il.Quantity) AS TotalQuantitySold,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue,
    AVG(il.UnitPrice) AS AveragePrice
FROM Track t
JOIN Album a ON t.AlbumId = a.AlbumId
JOIN Artist ar ON a.ArtistId = ar.ArtistId
JOIN Genre g ON t.GenreId = g.GenreId
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY t.TrackId, t.Name, a.Title, ar.Name, g.Name, t.Milliseconds;
GO
PRINT N'Creating [dbo].[TrackReview]'
GO
CREATE TABLE [dbo].[TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[ReviewerName] [nvarchar] (100) NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
PRINT N'Creating [dbo].[AppConfig]'
GO
CREATE TABLE [dbo].[AppConfig]
(
[ConfigId] [int] NOT NULL,
[ConfigKey] [nvarchar] (50) NOT NULL,
[ConfigValue] [nvarchar] (200) NOT NULL
)
GO
PRINT N'Creating primary key [PK_AppConfig] on [dbo].[AppConfig]'
GO
ALTER TABLE [dbo].[AppConfig] ADD CONSTRAINT [PK_AppConfig] PRIMARY KEY CLUSTERED ([ConfigId])
GO
PRINT N'Adding constraints to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ADD CONSTRAINT [FK_AlbumArtistId] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId])
GO
PRINT N'Adding foreign keys to [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [FK_CustomerSupportRepId] FOREIGN KEY ([SupportRepId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
PRINT N'Adding foreign keys to [dbo].[Employee]'
GO
ALTER TABLE [dbo].[Employee] ADD CONSTRAINT [FK_EmployeeReportsTo] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
PRINT N'Adding foreign keys to [dbo].[InvoiceLine]'
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLineInvoiceId] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId])
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLineTrackId] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO
PRINT N'Adding foreign keys to [dbo].[Invoice]'
GO
ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [FK_InvoiceCustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
PRINT N'Adding foreign keys to [dbo].[PlaylistTrack]'
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrackPlaylistId] FOREIGN KEY ([PlaylistId]) REFERENCES [dbo].[Playlist] ([PlaylistId])
GO
ALTER TABLE [dbo].[PlaylistTrack] ADD CONSTRAINT [FK_PlaylistTrackTrackId] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO
PRINT N'Adding foreign keys to [dbo].[SystemLog]'
GO
ALTER TABLE [dbo].[SystemLog] ADD CONSTRAINT [FK_SystemLog_Invoice] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId])
GO
PRINT N'Adding foreign keys to [dbo].[Track]'
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackAlbumId] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackGenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId])
GO
ALTER TABLE [dbo].[Track] ADD CONSTRAINT [FK_TrackMediaTypeId] FOREIGN KEY ([MediaTypeId]) REFERENCES [dbo].[MediaType] ([MediaTypeId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

PRINT(N'Add 3 rows to [dbo].[AppConfig]')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (1, N'ProductVersion', N'v1.0.0')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (2, N'DefaultCurrency', N'USD')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (3, N'MaintenanceMode', N'Off')

