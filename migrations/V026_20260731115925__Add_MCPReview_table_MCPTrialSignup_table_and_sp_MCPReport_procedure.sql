SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[MCPReview]'
GO
CREATE TABLE [dbo].[MCPReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[ReviewerName] [nvarchar] (255) NOT NULL,
[ReviewerEmail] [nvarchar] (255) NOT NULL,
[MCPToolName] [nvarchar] (255) NOT NULL,
[Rating] [int] NOT NULL,
[ReviewText] [nvarchar] (2000) NULL,
[SubmittedAt] [datetime] NOT NULL CONSTRAINT [DF_MCPReview_SubmittedAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_MCPReview] on [dbo].[MCPReview]'
GO
ALTER TABLE [dbo].[MCPReview] ADD CONSTRAINT [PK_MCPReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Creating [dbo].[MCPTrialSignup]'
GO
CREATE TABLE [dbo].[MCPTrialSignup]
(
[SignupId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (100) NOT NULL,
[LastName] [nvarchar] (100) NOT NULL,
[Email] [nvarchar] (255) NOT NULL,
[CompanyName] [nvarchar] (255) NULL,
[SignupDate] [datetime] NOT NULL CONSTRAINT [DF_MCPTrialSignup_SignupDate] DEFAULT (getdate()),
[TrialStatus] [nvarchar] (50) NOT NULL CONSTRAINT [DF_MCPTrialSignup_TrialStatus] DEFAULT ('Pending')
)
GO
PRINT N'Creating primary key [PK_MCPTrialSignup] on [dbo].[MCPTrialSignup]'
GO
ALTER TABLE [dbo].[MCPTrialSignup] ADD CONSTRAINT [PK_MCPTrialSignup] PRIMARY KEY CLUSTERED ([SignupId])
GO
PRINT N'Creating index [IX_MCPTrialSignup_Email] on [dbo].[MCPTrialSignup]'
GO
CREATE NONCLUSTERED INDEX [IX_MCPTrialSignup_Email] ON [dbo].[MCPTrialSignup] ([Email])
GO
PRINT N'Creating [dbo].[sp_MCPReport]'
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
PRINT N'Adding constraints to [dbo].[MCPReview]'
GO
ALTER TABLE [dbo].[MCPReview] ADD CONSTRAINT [CK_MCPReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

