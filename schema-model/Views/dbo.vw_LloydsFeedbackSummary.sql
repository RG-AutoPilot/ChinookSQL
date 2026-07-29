SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_LloydsFeedbackSummary] AS
SELECT
    f.FeedbackId,
    f.AttendeeName,
    f.AttendeeEmail,
    f.SessionName,
    f.FeatureRating,
    f.Comments,
    f.SubmittedAt,
    CASE
        WHEN f.FeatureRating >= 4 THEN 'Positive'
        WHEN f.FeatureRating = 3 THEN 'Neutral'
        ELSE 'Negative'
    END AS Sentiment
FROM dbo.LloydsDemo f;
GO
