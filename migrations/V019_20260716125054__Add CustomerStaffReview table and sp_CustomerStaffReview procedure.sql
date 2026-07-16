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
PRINT N'Creating [dbo].[CustomerStaffReview]'
GO
CREATE TABLE [dbo].[CustomerStaffReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[EmployeeId] [int] NOT NULL,
[CsatScore] [int] NOT NULL,
[ReviewComment] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL CONSTRAINT [DF_CustomerStaffReview_ReviewDate] DEFAULT (getdate()),
[InvoiceId] [int] NULL
)
GO
PRINT N'Creating primary key [PK_CustomerStaffReview] on [dbo].[CustomerStaffReview]'
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [PK_CustomerStaffReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[TestRoger] [int] NULL,
[SDRDemo] [int] NULL,
[TestDemo] [int] NULL
GO
PRINT N'Creating [dbo].[sp_CustomerStaffReview]'
GO
CREATE PROCEDURE [dbo].[sp_CustomerStaffReview]
    @EmployeeId INT = NULL,
    @CustomerId INT = NULL,
    @StartDate DATETIME = NULL,
    @EndDate DATETIME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Title,
        COUNT(r.ReviewId) AS TotalReviews,
        ISNULL(AVG(CAST(r.CsatScore AS DECIMAL(5, 2))), 0) AS AverageCsatScore,
        SUM(CASE WHEN r.CsatScore = 1 THEN 1 ELSE 0 END) AS Score1Count,
        SUM(CASE WHEN r.CsatScore = 2 THEN 1 ELSE 0 END) AS Score2Count,
        SUM(CASE WHEN r.CsatScore = 3 THEN 1 ELSE 0 END) AS Score3Count,
        SUM(CASE WHEN r.CsatScore = 4 THEN 1 ELSE 0 END) AS Score4Count,
        SUM(CASE WHEN r.CsatScore = 5 THEN 1 ELSE 0 END) AS Score5Count
    FROM dbo.Employee e
    LEFT JOIN dbo.CustomerStaffReview r
        ON e.EmployeeId = r.EmployeeId
        AND (@CustomerId IS NULL OR r.CustomerId = @CustomerId)
        AND (@StartDate IS NULL OR r.ReviewDate >= @StartDate)
        AND (@EndDate IS NULL OR r.ReviewDate <= @EndDate)
    WHERE (@EmployeeId IS NULL OR e.EmployeeId = @EmployeeId)
    GROUP BY e.EmployeeId, e.FirstName, e.LastName, e.Title
    ORDER BY AverageCsatScore DESC;
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
PRINT N'Adding constraints to [dbo].[CustomerStaffReview]'
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [CK_CustomerStaffReview_CsatScore] CHECK (([CsatScore]>=(1) AND [CsatScore]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[CustomerStaffReview]'
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [FK_CustomerStaffReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [FK_CustomerStaffReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [FK_CustomerStaffReview_Invoice] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

