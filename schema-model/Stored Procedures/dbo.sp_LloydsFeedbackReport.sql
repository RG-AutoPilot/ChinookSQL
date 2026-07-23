SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_LloydsFeedbackReport]
    @SessionDate DATE = NULL,
    @FeatureRated NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        f.FeedbackId,
        f.SessionDate,
        f.AttendeeFirstName + ' ' + f.AttendeeLastName AS AttendeeName,
        f.AttendeeRole,
        f.FeatureRated,
        f.Rating,
        f.Comments,
        f.WouldRecommend,
        f.CreatedAt
    FROM dbo.LloydsFeedback f
    WHERE (@SessionDate IS NULL OR f.SessionDate = @SessionDate)
      AND (@FeatureRated IS NULL OR f.FeatureRated = @FeatureRated)
    ORDER BY f.SessionDate DESC, f.Rating DESC;
END;
GO
