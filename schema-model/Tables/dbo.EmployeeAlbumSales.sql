CREATE TABLE [dbo].[EmployeeAlbumSales]
(
[EmployeeAlbumSaleId] [int] NOT NULL IDENTITY(1, 1),
[EmployeeId] [int] NOT NULL,
[AlbumId] [int] NOT NULL,
[TotalUnitsSold] [int] NOT NULL CONSTRAINT [DF_EmployeeAlbumSales_TotalUnitsSold] DEFAULT (0),
[TotalRevenue] [numeric] (10, 2) NOT NULL CONSTRAINT [DF_EmployeeAlbumSales_TotalRevenue] DEFAULT (0),
[LastUpdated] [datetime] NOT NULL CONSTRAINT [DF_EmployeeAlbumSales_LastUpdated] DEFAULT (GETDATE())
)
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [PK_EmployeeAlbumSales] PRIMARY KEY CLUSTERED ([EmployeeAlbumSaleId])
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeAlbumSales_EmployeeId] ON [dbo].[EmployeeAlbumSales] ([EmployeeId])
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeAlbumSales_AlbumId] ON [dbo].[EmployeeAlbumSales] ([AlbumId])
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [UQ_EmployeeAlbumSales_EmployeeAlbum] UNIQUE ([EmployeeId], [AlbumId])
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [FK_EmployeeAlbumSales_EmployeeId] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeAlbumSales] ADD CONSTRAINT [FK_EmployeeAlbumSales_AlbumId] FOREIGN KEY ([AlbumId]) REFERENCES [dbo].[Album] ([AlbumId])
GO
