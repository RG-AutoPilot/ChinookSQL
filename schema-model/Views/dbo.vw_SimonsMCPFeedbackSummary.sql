SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_SimonsMCPFeedbackSummary] AS
SELECT
    f.FeedbackId,
    f.SubmitterName,
    f.SubmitterEmail,
    f.MCPFeature,
    f.Rating,
    f.Comments,
    f.SubmittedAt,
    CASE
        WHEN f.Rating >= 4 THEN 'Positive'
        WHEN f.Rating = 3 THEN 'Neutral'
        ELSE 'Negative'
    END AS Sentiment
FROM dbo.SimonsMCPFeedback f;
GO
