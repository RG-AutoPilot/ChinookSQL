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
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [PK_EmployeeReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeReview_Employee] ON [dbo].[EmployeeReview] ([EmployeeId])
GO
CREATE NONCLUSTERED INDEX [IFK_EmployeeReview_Manager] ON [dbo].[EmployeeReview] ([ManagerId])
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [FK_EmployeeReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [FK_EmployeeReview_Manager] FOREIGN KEY ([ManagerId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [CK_EmployeeReview_OverallRating] CHECK (([OverallRating]>=(1) AND [OverallRating]<=(5)))
GO
ALTER TABLE [dbo].[EmployeeReview] ADD CONSTRAINT [CK_EmployeeReview_Status] CHECK ([Status] IN ('Draft', 'Completed', 'Acknowledged'))
GO
