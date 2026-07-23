SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[LloydsFeedback]'
GO
CREATE TABLE [dbo].[LloydsFeedback]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[SessionDate] [date] NOT NULL,
[AttendeeFirstName] [nvarchar] (100) NOT NULL,
[AttendeeLastName] [nvarchar] (100) NOT NULL,
[AttendeeRole] [nvarchar] (200) NULL,
[FeatureRated] [nvarchar] (200) NOT NULL,
[Rating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[WouldRecommend] [bit] NOT NULL,
[CreatedAt] [datetime] NOT NULL CONSTRAINT [DF_LloydsFeedback_CreatedAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_LloydsFeedback] on [dbo].[LloydsFeedback]'
GO
ALTER TABLE [dbo].[LloydsFeedback] ADD CONSTRAINT [PK_LloydsFeedback] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
PRINT N'Creating [dbo].[sp_LloydsFeedbackReport]'
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
PRINT N'Creating [dbo].[vw_LloydsFeedback]'
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
PRINT N'Adding constraints to [dbo].[LloydsFeedback]'
GO
ALTER TABLE [dbo].[LloydsFeedback] ADD CONSTRAINT [CK_LloydsFeedback_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

