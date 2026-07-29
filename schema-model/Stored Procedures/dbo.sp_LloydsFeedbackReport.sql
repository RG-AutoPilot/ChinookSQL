SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_LloydsFeedbackReport]
    @SessionName NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        SessionName,
        COUNT(FeedbackId) AS TotalResponses,
        ISNULL(AVG(CAST(FeatureRating AS DECIMAL(3,2))), 0) AS AverageRating,
        MIN(FeatureRating) AS MinRating,
        MAX(FeatureRating) AS MaxRating,
        MIN(SubmittedAt) AS FirstSubmission,
        MAX(SubmittedAt) AS LastSubmission
    FROM dbo.LloydsDemo
    WHERE (@SessionName IS NULL OR SessionName = @SessionName)
    GROUP BY SessionName
    ORDER BY AverageRating DESC;
END;
GO
