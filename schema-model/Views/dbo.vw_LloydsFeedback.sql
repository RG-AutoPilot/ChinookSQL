SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_LloydsFeedback] AS
SELECT
    f.FeedbackId,
    f.SessionDate,
    f.AttendeeFirstName + ' ' + f.AttendeeLastName AS AttendeeName,
    f.AttendeeRole,
    f.FeatureRated,
    f.Rating,
    CASE
        WHEN f.Rating = 5 THEN 'Excellent'
        WHEN f.Rating = 4 THEN 'Good'
        WHEN f.Rating = 3 THEN 'Neutral'
        WHEN f.Rating = 2 THEN 'Poor'
        ELSE 'Very Poor'
    END AS RatingLabel,
    f.Comments,
    f.WouldRecommend,
    f.CreatedAt,
    COUNT(*) OVER (PARTITION BY f.SessionDate) AS TotalResponsesForSession,
    AVG(CAST(f.Rating AS DECIMAL(3,2))) OVER (PARTITION BY f.FeatureRated) AS AvgRatingForFeature
FROM dbo.LloydsFeedback f;
GO
