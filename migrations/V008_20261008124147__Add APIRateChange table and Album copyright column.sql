SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[APIRateChange]'
GO
CREATE TABLE [dbo].[APIRateChange]
(
[APIRateChangeId] [int] NOT NULL IDENTITY(1, 1),
[APIKey] [int] NOT NULL,
[APIRate] [decimal] (18, 4) NOT NULL,
[ChangedDate] [datetime] NOT NULL CONSTRAINT [DF_APIRateChange_ChangedDate] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_APIRateChange] on [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] ADD CONSTRAINT [PK_APIRateChange] PRIMARY KEY CLUSTERED ([APIRateChangeId])
GO
PRINT N'Creating index [IX_APIRateChange_APIKey_ChangedDate] on [dbo].[APIRateChange]'
GO
CREATE NONCLUSTERED INDEX [IX_APIRateChange_APIKey_ChangedDate] ON [dbo].[APIRateChange] ([APIKey], [ChangedDate])
GO
PRINT N'Altering [dbo].[Album]'
GO
ALTER TABLE [dbo].[Album] ADD
[AlbumCopyright] [nvarchar] (200) NULL
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

