SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ADD
[GrossRevenueDollar] [int] NULL
GO
PRINT N'Creating [dbo].[SSISDemoReview]'
GO
CREATE TABLE [dbo].[SSISDemoReview]
(
[Demo] [int] NULL,
[ReviewFeedback] [nvarchar] (24) NULL
)
GO
PRINT N'Creating [dbo].[getSSISReviews]'
GO
CREATE PROCEDURE [dbo].[getSSISReviews]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.SSISDemoReview
END
GO
PRINT N'Refreshing [dbo].[vw_GenreStatistics]'
GO
EXEC sp_refreshview N'[dbo].[vw_GenreStatistics]'
GO
PRINT N'Refreshing [dbo].[vw_TrackPopularity]'
GO
EXEC sp_refreshview N'[dbo].[vw_TrackPopularity]'
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

PRINT(N'Add 1 row to [dbo].[AppConfig]')
INSERT INTO [dbo].[AppConfig] ([ConfigId], [ConfigKey], [ConfigValue]) VALUES (6, N'Central', N'ON')

