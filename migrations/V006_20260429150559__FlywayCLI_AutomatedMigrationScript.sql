SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] DROP CONSTRAINT [CK_TrackReview_Rating]
GO
PRINT N'Rebuilding [dbo].[TrackReview]'
GO
CREATE TABLE [dbo].[RG_Recovery_1_TrackReview]
(
[ReviewId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
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
PRINT N'Creating primary key [PK_TrackReview] on [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [PK_TrackReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Adding constraints to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [CK_TrackReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
PRINT N'Adding foreign keys to [dbo].[TrackReview]'
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [FK_TrackReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[TrackReview] ADD CONSTRAINT [FK_TrackReview_Track] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

