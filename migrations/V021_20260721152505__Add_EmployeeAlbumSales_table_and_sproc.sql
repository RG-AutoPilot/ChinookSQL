SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[EmployeeAlbumSales]'
GO
CREATE TABLE [dbo].[EmployeeAlbumSales]
(
[EmployeeAlbumSaleId] [int] NOT NULL IDENTITY(1, 1),
[EmployeeId] [int] NOT NULL,
[AlbumId] [int] NOT NULL,
[TotalUnitsSold] [int] NOT NULL CONSTRAINT [DF_EmployeeAlbumSales_TotalUnitsSold] DEFAULT ((0)),
[TotalRevenue] [numeric] (10, 2) NOT NULL CONSTRAINT [DF_EmployeeAlbumSales_TotalRevenue] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL CONSTRAINT [DF_EmployeeAlbumSales_LastUpdated] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_EmployeeAlbumSales] on [dbo].[EmployeeAlbumSales]'
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [PK_EmployeeAlbumSales] PRIMARY KEY CLUSTERED ([EmployeeAlbumSaleId])
GO
PRINT N'Creating index [IFK_EmployeeAlbumSales_AlbumId] on [dbo].[EmployeeAlbumSales]'
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeAlbumSales_AlbumId] ON [dbo].[EmployeeAlbumSales] ([AlbumId])
GO
PRINT N'Creating index [IFK_EmployeeAlbumSales_EmployeeId] on [dbo].[EmployeeAlbumSales]'
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeAlbumSales_EmployeeId] ON [dbo].[EmployeeAlbumSales] ([EmployeeId])
GO
PRINT N'Adding constraints to [dbo].[EmployeeAlbumSales]'
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [UQ_EmployeeAlbumSales_EmployeeAlbum] UNIQUE NONCLUSTERED ([EmployeeId], [AlbumId])
GO
PRINT N'Creating [dbo].[sp_EmployeeAlbumSales]'
GO
CREATE PROCEDURE [dbo].[sp_EmployeeAlbumSales]
    @EmployeeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        e.Title,
        a.AlbumId,
        a.Title AS AlbumTitle,
        ar.Name AS ArtistName,
        COUNT(DISTINCT i.InvoiceId) AS InvoiceCount,
        SUM(il.Quantity) AS TotalUnitsSold,
        SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
    FROM [dbo].[Employee] e
    INNER JOIN [dbo].[Customer] c ON e.EmployeeId = c.SupportRepId
    INNER JOIN [dbo].[Invoice] i ON c.CustomerId = i.CustomerId
    INNER JOIN [dbo].[InvoiceLine] il ON i.InvoiceId = il.InvoiceId
    INNER JOIN [dbo].[Track] t ON il.TrackId = t.TrackId
    INNER JOIN [dbo].[Album] a ON t.AlbumId = a.AlbumId
    INNER JOIN [dbo].[Artist] ar ON a.ArtistId = ar.ArtistId
    WHERE (@EmployeeId IS NULL OR e.EmployeeId = @EmployeeId)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title, a.AlbumId, a.Title, ar.Name
    ORDER BY e.EmployeeId, TotalRevenue DESC;
END;
GO
PRINT N'Adding foreign keys to [dbo].[EmployeeAlbumSales]'
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [FK_EmployeeAlbumSales_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [FK_EmployeeAlbumSales_AlbumId] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

