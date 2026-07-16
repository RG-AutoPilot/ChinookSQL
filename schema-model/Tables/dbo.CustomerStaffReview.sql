CREATE TABLE [dbo].[CustomerStaffReview]
(
[ReviewId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[EmployeeId] [int] NOT NULL,
[CsatScore] [int] NOT NULL,
[ReviewComment] [nvarchar] (1000) NULL,
[ReviewDate] [datetime] NOT NULL CONSTRAINT [DF_CustomerStaffReview_ReviewDate] DEFAULT (getdate()),
[InvoiceId] [int] NULL
)
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [PK_CustomerStaffReview] PRIMARY KEY CLUSTERED ([ReviewId])
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [FK_CustomerStaffReview_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [FK_CustomerStaffReview_Employee] FOREIGN KEY ([EmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [FK_CustomerStaffReview_Invoice] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId])
GO
ALTER TABLE [dbo].[CustomerStaffReview] ADD CONSTRAINT [CK_CustomerStaffReview_CsatScore] CHECK (([CsatScore]>=(1) AND [CsatScore]<=(5)))
GO
