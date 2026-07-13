SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [FK_CustomerTestID]
GO
PRINT N'Dropping index [IFK_CustomerTestID] from [dbo].[Customer]'
GO
DROP INDEX [IFK_CustomerTestID] ON [dbo].[Customer]
GO
PRINT N'Altering [dbo].[AlbumReview]'
GO
ALTER TABLE [dbo].[AlbumReview] ADD
[RevenueGrossed] [decimal] (18, 2) NULL
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[TestRoger] [int] NULL,
[SDRDemo] [int] NULL,
[TestDemo] [int] NULL
GO
PRINT N'Altering [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD
[RevenueGrossed] [decimal] (18, 2) NULL
GO
PRINT N'Refreshing [dbo].[vw_CustomerInvoiceSummary]'
GO
EXEC sp_refreshview N'[dbo].[vw_CustomerInvoiceSummary]'
GO
PRINT N'Refreshing [dbo].[vw_EmployeePerformance]'
GO
EXEC sp_refreshview N'[dbo].[vw_EmployeePerformance]'
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

