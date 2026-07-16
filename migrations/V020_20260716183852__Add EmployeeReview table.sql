SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[EmployeeReview]'
GO
CREATE TABLE [dbo].[EmployeeReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[EmployeeId] [int] NOT NULL,
[ManagerId] [int] NOT NULL,
[ReviewDate] [datetime] NOT NULL,
[ReviewPeriodStart] [date] NOT NULL,
[ReviewPeriodEnd] [date] NOT NULL,
[OverallRating] [int] NOT NULL,
[Comments] [nvarchar] (2000) NULL,
[Goals] [nvarchar] (2000) NULL,
[Status] [nvarchar] (20) NOT NULL CONSTRAINT [DF_EmployeeReview_Status] DEFAULT ('Draft')
)
GO
PRINT N'Creating primary key [PK_EmployeeReview] on [dbo].[EmployeeReview]'
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [PK_EmployeeReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
PRINT N'Creating index [IFK_EmployeeReview_Employee] on [dbo].[EmployeeReview]'
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeReview_Employee] ON [dbo].[EmployeeReview] ([EmployeeId])
GO
PRINT N'Creating index [IFK_EmployeeReview_Manager] on [dbo].[EmployeeReview]'
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeReview_Manager] ON [dbo].[EmployeeReview] ([ManagerId])
GO
PRINT N'Adding constraints to [dbo].[EmployeeReview]'
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [CK_EmployeeReview_OverallRating] CHECK (([OverallRating]>=(1) AND [OverallRating]<=(5)))
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [CK_EmployeeReview_Status] CHECK ((([Status]='Acknowledged' OR [Status]='Completed' OR [Status]='Draft')))
GO
PRINT N'Adding foreign keys to [dbo].[EmployeeReview]'
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [FK_EmployeeReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [FK_EmployeeReview_Manager] FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

