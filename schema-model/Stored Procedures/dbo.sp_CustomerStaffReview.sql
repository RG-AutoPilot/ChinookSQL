SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
