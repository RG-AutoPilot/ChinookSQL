SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP CONSTRAINT [PK_APIRateChange]
GO
PRINT N'Dropping constraints from [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] DROP CONSTRAINT [PK_ClaudeChange]
GO
PRINT N'Dropping constraints from [dbo].[DevMCPTable]'
GO
ALTER TABLE [dbo].[DevMCPTable] DROP CONSTRAINT [PK_DevMCPTable]
GO
PRINT N'Dropping constraints from [dbo].[Flyway]'
GO
ALTER TABLE [dbo].[Flyway] DROP CONSTRAINT [PK_Flyway]
GO
PRINT N'Dropping constraints from [dbo].[Huccer]'
GO
ALTER TABLE [dbo].[Huccer] DROP CONSTRAINT [PK_Huccer]
GO
PRINT N'Dropping constraints from [dbo].[HuxFour]'
GO
ALTER TABLE [dbo].[HuxFour] DROP CONSTRAINT [PK_HuxFour]
GO
PRINT N'Dropping constraints from [dbo].[HuxONe]'
GO
ALTER TABLE [dbo].[HuxONe] DROP CONSTRAINT [PK_HuxONe]
GO
PRINT N'Dropping constraints from [dbo].[HuxThree]'
GO
ALTER TABLE [dbo].[HuxThree] DROP CONSTRAINT [PK_HuxThree]
GO
PRINT N'Dropping constraints from [dbo].[HuxTwo]'
GO
ALTER TABLE [dbo].[HuxTwo] DROP CONSTRAINT [PK_HuxTwo]
GO
PRINT N'Dropping constraints from [dbo].[Hux]'
GO
ALTER TABLE [dbo].[Hux] DROP CONSTRAINT [PK_Hux]
GO
PRINT N'Dropping constraints from [dbo].[IVMCPChange]'
GO
ALTER TABLE [dbo].[IVMCPChange] DROP CONSTRAINT [PK_IVMCPChange]
GO
PRINT N'Dropping constraints from [dbo].[JoshDuncan]'
GO
ALTER TABLE [dbo].[JoshDuncan] DROP CONSTRAINT [PK_JoshDuncan]
GO
PRINT N'Dropping constraints from [dbo].[Landon]'
GO
ALTER TABLE [dbo].[Landon] DROP CONSTRAINT [PK_Landon]
GO
PRINT N'Dropping constraints from [dbo].[MCPChangeWTW]'
GO
ALTER TABLE [dbo].[MCPChangeWTW] DROP CONSTRAINT [PK_MCPChangeWTW]
GO
PRINT N'Dropping constraints from [dbo].[MCPExampleChange]'
GO
ALTER TABLE [dbo].[MCPExampleChange] DROP CONSTRAINT [PK_MCPExampleChange]
GO
PRINT N'Dropping constraints from [dbo].[MCPExample]'
GO
ALTER TABLE [dbo].[MCPExample] DROP CONSTRAINT [PK_MCPExample]
GO
PRINT N'Dropping constraints from [dbo].[Mackie]'
GO
ALTER TABLE [dbo].[Mackie] DROP CONSTRAINT [PK_Mackie]
GO
PRINT N'Dropping constraints from [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] DROP CONSTRAINT [PK_SSISDemoReview]
GO
PRINT N'Dropping constraints from [dbo].[SocialSignUp]'
GO
ALTER TABLE [dbo].[SocialSignUp] DROP CONSTRAINT [PK_SocialSignUp]
GO
PRINT N'Dropping constraints from [dbo].[huxChange]'
GO
ALTER TABLE [dbo].[huxChange] DROP CONSTRAINT [PK_huxChange]
GO
PRINT N'Altering [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] DROP
COLUMN [SSISDemoReviewId]
GO
PRINT N'Altering [dbo].[MCPExample]'
GO
ALTER TABLE [dbo].[MCPExample] DROP
COLUMN [MCPExampleId]
GO
PRINT N'Altering [dbo].[MCPExampleChange]'
GO
ALTER TABLE [dbo].[MCPExampleChange] DROP
COLUMN [MCPExampleChangeId]
GO
PRINT N'Altering [dbo].[IVMCPChange]'
GO
ALTER TABLE [dbo].[IVMCPChange] DROP
COLUMN [IVMCPChangeId]
GO
PRINT N'Altering [dbo].[HuxFour]'
GO
ALTER TABLE [dbo].[HuxFour] DROP
COLUMN [HuxFourId]
GO
PRINT N'Altering [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] DROP
COLUMN [APIRateChangeId]
GO
PRINT N'Altering [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] DROP
COLUMN [ClaudeChangeId]
GO
PRINT N'Altering [dbo].[DevMCPTable]'
GO
ALTER TABLE [dbo].[DevMCPTable] DROP
COLUMN [DevMCPTableId]
GO
PRINT N'Altering [dbo].[Flyway]'
GO
ALTER TABLE [dbo].[Flyway] DROP
COLUMN [FlywayId]
GO
PRINT N'Altering [dbo].[Huccer]'
GO
ALTER TABLE [dbo].[Huccer] DROP
COLUMN [HuccerId]
GO
PRINT N'Altering [dbo].[HuxONe]'
GO
ALTER TABLE [dbo].[HuxONe] DROP
COLUMN [HuxONeId]
GO
PRINT N'Altering [dbo].[HuxThree]'
GO
ALTER TABLE [dbo].[HuxThree] DROP
COLUMN [HuxThreeId]
GO
PRINT N'Altering [dbo].[HuxTwo]'
GO
ALTER TABLE [dbo].[HuxTwo] DROP
COLUMN [HuxTwoId]
GO
PRINT N'Altering [dbo].[Hux]'
GO
ALTER TABLE [dbo].[Hux] DROP
COLUMN [HuxId]
GO
PRINT N'Altering [dbo].[JoshDuncan]'
GO
ALTER TABLE [dbo].[JoshDuncan] DROP
COLUMN [JoshDuncanId]
GO
PRINT N'Altering [dbo].[Landon]'
GO
ALTER TABLE [dbo].[Landon] DROP
COLUMN [LandonId]
GO
PRINT N'Altering [dbo].[MCPChangeWTW]'
GO
ALTER TABLE [dbo].[MCPChangeWTW] DROP
COLUMN [MCPChangeWTWId]
GO
PRINT N'Altering [dbo].[Mackie]'
GO
ALTER TABLE [dbo].[Mackie] DROP
COLUMN [MackieId]
GO
PRINT N'Altering [dbo].[SocialSignUp]'
GO
ALTER TABLE [dbo].[SocialSignUp] DROP
COLUMN [SocialSignUpId]
GO
PRINT N'Altering [dbo].[huxChange]'
GO
ALTER TABLE [dbo].[huxChange] DROP
COLUMN [huxChangeId]
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

