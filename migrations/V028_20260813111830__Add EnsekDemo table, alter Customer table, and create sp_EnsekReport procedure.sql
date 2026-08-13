SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[EnsekDemo]'
GO
CREATE TABLE [dbo].[EnsekDemo]
(
[EnsekDemoId] [int] NOT NULL IDENTITY(1, 1),
[AccountNumber] [nvarchar] (50) NOT NULL,
[CustomerName] [nvarchar] (100) NOT NULL,
[EnergyType] [nvarchar] (20) NULL,
[TariffCode] [nvarchar] (30) NULL,
[MeterReading] [decimal] (18, 2) NULL,
[ReadingDate] [datetime] NULL,
[CreatedAt] [datetime] NOT NULL CONSTRAINT [DF_EnsekDemo_CreatedAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_EnsekDemo] on [dbo].[EnsekDemo]'
GO
ALTER TABLE [dbo].[EnsekDemo] ADD CONSTRAINT [PK_EnsekDemo] PRIMARY KEY CLUSTERED ([EnsekDemoId])
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[EnsekAccount] [nvarchar] (50) NULL
GO
PRINT N'Creating [dbo].[sp_EnsekReport]'
GO
CREATE PROCEDURE [dbo].[sp_EnsekReport]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[EnsekDemo];

    SELECT * FROM [dbo].[Customer];
END
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

