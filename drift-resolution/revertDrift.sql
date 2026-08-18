SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [CK__SalesMemb__Statu__0DB9F9A8]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [CK__SalesMemb__Progr__0FA2421A]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [PK__SalesMem__3BA911CA71E92D85]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [UQ__SalesMem__A9D105348B2A6CA2]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [DF__SalesMemb__Statu__0CC5D56F]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [DF__SalesMemb__Progr__0EAE1DE1]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [DF__SalesMemb__Creat__10966653]
GO
PRINT N'Dropping constraints from [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] DROP CONSTRAINT [DF__SalesMemb__Updat__118A8A8C]
GO
PRINT N'Dropping index [IX_SalesMembersInTraining_TrainingStart] from [dbo].[SalesMembersInTraining]'
GO
DROP INDEX [IX_SalesMembersInTraining_TrainingStart] ON [dbo].[SalesMembersInTraining]
GO
PRINT N'Dropping index [IX_SalesMembersInTraining_Status] from [dbo].[SalesMembersInTraining]'
GO
DROP INDEX [IX_SalesMembersInTraining_Status] ON [dbo].[SalesMembersInTraining]
GO
PRINT N'Dropping [dbo].[Drift]'
GO
DROP TABLE [dbo].[Drift]
GO
PRINT N'Dropping [dbo].[DemoSales]'
GO
DROP TABLE [dbo].[DemoSales]
GO
PRINT N'Dropping [dbo].[SalesMembersInTraining]'
GO
DROP TABLE [dbo].[SalesMembersInTraining]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

