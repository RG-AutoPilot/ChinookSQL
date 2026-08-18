SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[SalesMembersInTraining]'
GO
CREATE TABLE [dbo].[SalesMembersInTraining]
(
[TraineeId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (100) NOT NULL,
[LastName] [nvarchar] (100) NOT NULL,
[Email] [nvarchar] (255) NOT NULL,
[HireDate] [date] NOT NULL,
[TrainingStart] [date] NOT NULL,
[TrainingEnd] [date] NULL,
[Mentor] [nvarchar] (200) NULL,
[Region] [nvarchar] (100) NULL,
[Status] [nvarchar] (20) NOT NULL CONSTRAINT [DF__SalesMemb__Statu__0CC5D56F] DEFAULT ('In Progress'),
[ProgressPercent] [tinyint] NOT NULL CONSTRAINT [DF__SalesMemb__Progr__0EAE1DE1] DEFAULT ((0)),
[Notes] [nvarchar] (max) NULL,
[CreatedAt] [datetime2] NOT NULL CONSTRAINT [DF__SalesMemb__Creat__10966653] DEFAULT (sysutcdatetime()),
[UpdatedAt] [datetime2] NOT NULL CONSTRAINT [DF__SalesMemb__Updat__118A8A8C] DEFAULT (sysutcdatetime())
)
GO
PRINT N'Creating primary key [PK__SalesMem__3BA911CA71E92D85] on [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] ADD CONSTRAINT [PK__SalesMem__3BA911CA71E92D85] PRIMARY KEY CLUSTERED ([TraineeId])
GO
PRINT N'Adding constraints to [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] ADD CONSTRAINT [UQ__SalesMem__A9D105348B2A6CA2] UNIQUE NONCLUSTERED ([Email])
GO
PRINT N'Creating index [IX_SalesMembersInTraining_Status] on [dbo].[SalesMembersInTraining]'
GO
CREATE NONCLUSTERED INDEX [IX_SalesMembersInTraining_Status] ON [dbo].[SalesMembersInTraining] ([Status])
GO
PRINT N'Creating index [IX_SalesMembersInTraining_TrainingStart] on [dbo].[SalesMembersInTraining]'
GO
CREATE NONCLUSTERED INDEX [IX_SalesMembersInTraining_TrainingStart] ON [dbo].[SalesMembersInTraining] ([TrainingStart])
GO
PRINT N'Creating [dbo].[DemoSales]'
GO
CREATE TABLE [dbo].[DemoSales]
(
[Test] [int] NULL
)
GO
PRINT N'Creating [dbo].[Drift]'
GO
CREATE TABLE [dbo].[Drift]
(
[Test] [int] NULL
)
GO
PRINT N'Adding constraints to [dbo].[SalesMembersInTraining]'
GO
ALTER TABLE [dbo].[SalesMembersInTraining] ADD CONSTRAINT [CK__SalesMemb__Statu__0DB9F9A8] CHECK (([Status]='On Hold' OR [Status]='Withdrawn' OR [Status]='Completed' OR [Status]='In Progress'))
GO
ALTER TABLE [dbo].[SalesMembersInTraining] ADD CONSTRAINT [CK__SalesMemb__Progr__0FA2421A] CHECK (([ProgressPercent]>=(0) AND [ProgressPercent]<=(100)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

