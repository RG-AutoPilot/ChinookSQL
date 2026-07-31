SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_MCPReport]
    @MCPToolName NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        r.MCPToolName,
        COUNT(r.ReviewId) AS TotalReviews,
        ISNULL(AVG(CAST(r.Rating AS DECIMAL(3,2))), 0) AS AverageRating,
        MIN(r.Rating) AS MinRating,
        MAX(r.Rating) AS MaxRating,
        MIN(r.SubmittedAt) AS FirstReview,
        MAX(r.SubmittedAt) AS LastReview,
        (
            SELECT COUNT(*)
            FROM dbo.MCPTrialSignup s
            WHERE s.TrialStatus = 'Pending'
              AND (@MCPToolName IS NULL)
        ) AS PendingTrialSignups
    FROM dbo.MCPReview r
    WHERE (@MCPToolName IS NULL OR r.MCPToolName = @MCPToolName)
    GROUP BY r.MCPToolName
    ORDER BY AverageRating DESC;
END;
GO
