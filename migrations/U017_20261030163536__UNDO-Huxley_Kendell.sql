SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[SandboxDemo]'
GO
ALTER TABLE [dbo].[SandboxDemo] DROP CONSTRAINT [PK_SandboxDemo]
GO
PRINT N'Dropping [dbo].[huxChange]'
GO
DROP TABLE [dbo].[huxChange]
GO
PRINT N'Dropping [dbo].[SocialSignUp]'
GO
DROP TABLE [dbo].[SocialSignUp]
GO
PRINT N'Dropping [dbo].[SandboxDemo]'
GO
DROP TABLE [dbo].[SandboxDemo]
GO
PRINT N'Dropping [dbo].[Mackie]'
GO
DROP TABLE [dbo].[Mackie]
GO
PRINT N'Dropping [dbo].[Hux]'
GO
DROP TABLE [dbo].[Hux]
GO
PRINT N'Dropping [dbo].[HuxTwo]'
GO
DROP TABLE [dbo].[HuxTwo]
GO
PRINT N'Dropping [dbo].[HuxThree]'
GO
DROP TABLE [dbo].[HuxThree]
GO
PRINT N'Dropping [dbo].[HuxONe]'
GO
DROP TABLE [dbo].[HuxONe]
GO
PRINT N'Dropping [dbo].[getSPHux]'
GO
DROP PROCEDURE [dbo].[getSPHux]
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] DROP
COLUMN [SocialSignedUp],
COLUMN [TestID2]
GO
PRINT N'Refreshing [dbo].[vw_CustomerInvoiceSummary]'
GO
EXEC sp_refreshview N'[dbo].[vw_CustomerInvoiceSummary]'
GO
PRINT N'Refreshing [dbo].[vw_EmployeePerformance]'
GO
EXEC sp_refreshview N'[dbo].[vw_EmployeePerformance]'
GO
PRINT N'Altering [dbo].[Flyway]'
GO
ALTER TABLE [dbo].[Flyway] DROP
COLUMN [EncryptKey]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

