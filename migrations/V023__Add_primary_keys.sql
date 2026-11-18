SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[HuxFour]'
GO
ALTER TABLE [dbo].[HuxFour] ADD
[HuxFourId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_HuxFour] on [dbo].[HuxFour]'
GO
ALTER TABLE [dbo].[HuxFour] ADD CONSTRAINT [PK_HuxFour] PRIMARY KEY CLUSTERED ([HuxFourId])
GO
PRINT N'Altering [dbo].[MCPExample]'
GO
ALTER TABLE [dbo].[MCPExample] ADD
[MCPExampleId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_MCPExample] on [dbo].[MCPExample]'
GO
ALTER TABLE [dbo].[MCPExample] ADD CONSTRAINT [PK_MCPExample] PRIMARY KEY CLUSTERED ([MCPExampleId])
GO
PRINT N'Altering [dbo].[MCPExampleChange]'
GO
ALTER TABLE [dbo].[MCPExampleChange] ADD
[MCPExampleChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_MCPExampleChange] on [dbo].[MCPExampleChange]'
GO
ALTER TABLE [dbo].[MCPExampleChange] ADD CONSTRAINT [PK_MCPExampleChange] PRIMARY KEY CLUSTERED ([MCPExampleChangeId])
GO
PRINT N'Altering [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] ADD
[SSISDemoReviewId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_SSISDemoReview] on [dbo].[SSISDemoReview]'
GO
ALTER TABLE [dbo].[SSISDemoReview] ADD CONSTRAINT [PK_SSISDemoReview] PRIMARY KEY CLUSTERED ([SSISDemoReviewId])
GO
PRINT N'Altering [dbo].[IVMCPChange]'
GO
ALTER TABLE [dbo].[IVMCPChange] ADD
[IVMCPChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_IVMCPChange] on [dbo].[IVMCPChange]'
GO
ALTER TABLE [dbo].[IVMCPChange] ADD CONSTRAINT [PK_IVMCPChange] PRIMARY KEY CLUSTERED ([IVMCPChangeId])
GO
PRINT N'Altering [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] ADD
[APIRateChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_APIRateChange] on [dbo].[APIRateChange]'
GO
ALTER TABLE [dbo].[APIRateChange] ADD CONSTRAINT [PK_APIRateChange] PRIMARY KEY CLUSTERED ([APIRateChangeId])
GO
PRINT N'Altering [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] ADD
[ClaudeChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_ClaudeChange] on [dbo].[ClaudeChange]'
GO
ALTER TABLE [dbo].[ClaudeChange] ADD CONSTRAINT [PK_ClaudeChange] PRIMARY KEY CLUSTERED ([ClaudeChangeId])
GO
PRINT N'Altering [dbo].[DevMCPTable]'
GO
ALTER TABLE [dbo].[DevMCPTable] ADD
[DevMCPTableId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_DevMCPTable] on [dbo].[DevMCPTable]'
GO
ALTER TABLE [dbo].[DevMCPTable] ADD CONSTRAINT [PK_DevMCPTable] PRIMARY KEY CLUSTERED ([DevMCPTableId])
GO
PRINT N'Altering [dbo].[Flyway]'
GO
ALTER TABLE [dbo].[Flyway] ADD
[FlywayId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_Flyway] on [dbo].[Flyway]'
GO
ALTER TABLE [dbo].[Flyway] ADD CONSTRAINT [PK_Flyway] PRIMARY KEY CLUSTERED ([FlywayId])
GO
PRINT N'Altering [dbo].[Huccer]'
GO
ALTER TABLE [dbo].[Huccer] ADD
[HuccerId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_Huccer] on [dbo].[Huccer]'
GO
ALTER TABLE [dbo].[Huccer] ADD CONSTRAINT [PK_Huccer] PRIMARY KEY CLUSTERED ([HuccerId])
GO
PRINT N'Altering [dbo].[HuxONe]'
GO
ALTER TABLE [dbo].[HuxONe] ADD
[HuxONeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_HuxONe] on [dbo].[HuxONe]'
GO
ALTER TABLE [dbo].[HuxONe] ADD CONSTRAINT [PK_HuxONe] PRIMARY KEY CLUSTERED ([HuxONeId])
GO
PRINT N'Altering [dbo].[HuxThree]'
GO
ALTER TABLE [dbo].[HuxThree] ADD
[HuxThreeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_HuxThree] on [dbo].[HuxThree]'
GO
ALTER TABLE [dbo].[HuxThree] ADD CONSTRAINT [PK_HuxThree] PRIMARY KEY CLUSTERED ([HuxThreeId])
GO
PRINT N'Altering [dbo].[HuxTwo]'
GO
ALTER TABLE [dbo].[HuxTwo] ADD
[HuxTwoId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_HuxTwo] on [dbo].[HuxTwo]'
GO
ALTER TABLE [dbo].[HuxTwo] ADD CONSTRAINT [PK_HuxTwo] PRIMARY KEY CLUSTERED ([HuxTwoId])
GO
PRINT N'Altering [dbo].[Hux]'
GO
ALTER TABLE [dbo].[Hux] ADD
[HuxId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_Hux] on [dbo].[Hux]'
GO
ALTER TABLE [dbo].[Hux] ADD CONSTRAINT [PK_Hux] PRIMARY KEY CLUSTERED ([HuxId])
GO
PRINT N'Altering [dbo].[JoshDuncan]'
GO
ALTER TABLE [dbo].[JoshDuncan] ADD
[JoshDuncanId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_JoshDuncan] on [dbo].[JoshDuncan]'
GO
ALTER TABLE [dbo].[JoshDuncan] ADD CONSTRAINT [PK_JoshDuncan] PRIMARY KEY CLUSTERED ([JoshDuncanId])
GO
PRINT N'Altering [dbo].[Landon]'
GO
ALTER TABLE [dbo].[Landon] ADD
[LandonId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_Landon] on [dbo].[Landon]'
GO
ALTER TABLE [dbo].[Landon] ADD CONSTRAINT [PK_Landon] PRIMARY KEY CLUSTERED ([LandonId])
GO
PRINT N'Altering [dbo].[MCPChangeWTW]'
GO
ALTER TABLE [dbo].[MCPChangeWTW] ADD
[MCPChangeWTWId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_MCPChangeWTW] on [dbo].[MCPChangeWTW]'
GO
ALTER TABLE [dbo].[MCPChangeWTW] ADD CONSTRAINT [PK_MCPChangeWTW] PRIMARY KEY CLUSTERED ([MCPChangeWTWId])
GO
PRINT N'Altering [dbo].[Mackie]'
GO
ALTER TABLE [dbo].[Mackie] ADD
[MackieId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_Mackie] on [dbo].[Mackie]'
GO
ALTER TABLE [dbo].[Mackie] ADD CONSTRAINT [PK_Mackie] PRIMARY KEY CLUSTERED ([MackieId])
GO
PRINT N'Altering [dbo].[SocialSignUp]'
GO
ALTER TABLE [dbo].[SocialSignUp] ADD
[SocialSignUpId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_SocialSignUp] on [dbo].[SocialSignUp]'
GO
ALTER TABLE [dbo].[SocialSignUp] ADD CONSTRAINT [PK_SocialSignUp] PRIMARY KEY CLUSTERED ([SocialSignUpId])
GO
PRINT N'Altering [dbo].[huxChange]'
GO
ALTER TABLE [dbo].[huxChange] ADD
[huxChangeId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_huxChange] on [dbo].[huxChange]'
GO
ALTER TABLE [dbo].[huxChange] ADD CONSTRAINT [PK_huxChange] PRIMARY KEY CLUSTERED ([huxChangeId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

