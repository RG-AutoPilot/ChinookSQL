SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [FK_CIBFeedback_Customer]
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [FK_CIBFeedback_RelationshipManager]
GO
PRINT N'Dropping constraints from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [CK_CIBFeedback_Rating]
GO
PRINT N'Dropping constraints from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [CK_CIBFeedback_Status]
GO
PRINT N'Dropping constraints from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [PK_CIBFeedback]
GO
PRINT N'Dropping constraints from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [DF_CIBFeedback_FeedbackDate]
GO
PRINT N'Dropping constraints from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [DF_CIBFeedback_Status]
GO
PRINT N'Dropping constraints from [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] DROP CONSTRAINT [DF_CIBFeedback_CreatedAt]
GO
PRINT N'Dropping index [IFK_CIBFeedback_Customer] from [dbo].[CIBFeedback]'
GO
DROP INDEX [IFK_CIBFeedback_Customer] ON [dbo].[CIBFeedback]
GO
PRINT N'Dropping index [IFK_CIBFeedback_RelationshipManager] from [dbo].[CIBFeedback]'
GO
DROP INDEX [IFK_CIBFeedback_RelationshipManager] ON [dbo].[CIBFeedback]
GO
PRINT N'Dropping [dbo].[sp_SubmitCIBFeedback]'
GO
DROP PROCEDURE [dbo].[sp_SubmitCIBFeedback]
GO
PRINT N'Dropping [dbo].[CIBFeedback]'
GO
DROP TABLE [dbo].[CIBFeedback]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

