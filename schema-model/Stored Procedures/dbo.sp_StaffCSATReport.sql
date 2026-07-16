SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
