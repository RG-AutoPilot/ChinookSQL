CREATE TABLE [dbo].[StaffCSATReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[EmployeeId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Rating] [int] NOT NULL,
[ReviewText] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL
)
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [PK_StaffCSATReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
CREATE NONCLUSTERED INDEX [IFK_StaffCSATReview_Employee] ON [dbo].[StaffCSATReview] ([EmployeeId])
GO
CREATE NONCLUSTERED INDEX [IFK_StaffCSATReview_Customer] ON [dbo].[StaffCSATReview] ([CustomerId])
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [FK_StaffCSATReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [FK_StaffCSATReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[StaffCSATReview] ADD CONSTRAINT [CK_StaffCSATReview_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
