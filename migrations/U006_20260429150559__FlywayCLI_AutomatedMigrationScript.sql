SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [FK_TrackReview_Customer]
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [FK_TrackReview_Track]
GO
PRINT N'Dropping constraints from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [CK_TrackReview_Rating]
GO
PRINT N'Dropping constraints from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [PK_TrackReview]
GO
PRINT N'Rebuilding [dbo].[TrackReview]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[ReviewerName] [nvarchar] (100) NOT NULL,
[Rating] [int] NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
INSERT INTO [dbo].[RG_Recovery_1_TrackReview]([ReviewId], [TrackId], [Rating], [ReviewText], [ReviewDate]) SELECT [ReviewId], [TrackId], [Rating], [ReviewText], [ReviewDate] FROM [dbo].[TrackReview]
GO
DROP TABLE [dbo].[TrackReview]
GO
EXEC sp_rename N'[dbo].[RG_Recovery_1_TrackReview]', N'TrackReview', N'OBJECT'
GO
PRINT N'Adding constraints to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

