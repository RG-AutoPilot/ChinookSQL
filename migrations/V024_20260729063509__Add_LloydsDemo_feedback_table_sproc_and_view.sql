SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Rebuilding [dbo].[LloydsDemo]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_LloydsDemo]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[AttendeeEmail] [nvarchar] (255) NOT NULL,
[AttendeeName] [nvarchar] (255) NULL,
[FeatureRating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[SubmittedAt] [datetime] NOT NULL CONSTRAINT [DF_LloydsDemo_SubmittedAt] DEFAULT (getdate()),
[SessionName] [nvarchar] (255) NULL
)
GO
DROP TABLE [dbo].[LloydsDemo]
GO
EXEC sp_rename N'[dbo].[RG_Recovery_1_LloydsDemo]', N'LloydsDemo', N'OBJECT'
GO
PRINT N'Creating primary key [PK_LloydsDemo] on [dbo].[LloydsDemo]'
GO
ALTER TABLE [dbo].[LloydsDemo] ADD CONSTRAINT [PK_LloydsDemo] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
PRINT N'Creating [dbo].[sp_LloydsFeedbackReport]'
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
PRINT N'Creating [dbo].[vw_LloydsFeedbackSummary]'
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
PRINT N'Adding constraints to [dbo].[LloydsDemo]'
GO
ALTER TABLE [dbo].[LloydsDemo] ADD CONSTRAINT [CK_LloydsDemo_FeatureRating] CHECK (([FeatureRating]>=(1) AND [FeatureRating]<=(5)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

