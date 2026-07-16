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
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[TestRoger] [int] NULL,
[SDRDemo] [int] NULL,
[TestDemo] [int] NULL
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
PRINT N'Adding constraints to [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [CK_StaffCSATReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[StaffCSATReview]'
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [FK_StaffCSATReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [FK_StaffCSATReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

