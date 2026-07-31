SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[SimonsMCPFeedback]'
GO
CREATE TABLE [dbo].[SimonsMCPFeedback]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[SubmitterName] [nvarchar] (255) NOT NULL,
[SubmitterEmail] [nvarchar] (255) NULL,
[MCPFeature] [nvarchar] (255) NOT NULL,
[Rating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[SubmittedAt] [datetime] NOT NULL CONSTRAINT [DF_SimonsMCPFeedback_SubmittedAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_SimonsMCPFeedback] on [dbo].[SimonsMCPFeedback]'
GO
ALTER TABLE [dbo].[SimonsMCPFeedback] ADD CONSTRAINT [PK_SimonsMCPFeedback] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
PRINT N'Creating [dbo].[vw_SimonsMCPFeedbackSummary]'
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
PRINT N'Adding constraints to [dbo].[SimonsMCPFeedback]'
GO
ALTER TABLE [dbo].[SimonsMCPFeedback] ADD CONSTRAINT [CK_SimonsMCPFeedback_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

