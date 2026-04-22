CREATE TABLE [dbo].[Invoice]
(
[InvoiceId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[InvoiceDate] [datetime] NOT NULL,
[BillingAddress] [nvarchar] (70) NULL,
[BillingCity] [nvarchar] (40) NULL,
[BillingState] [nvarchar] (40) NULL,
[BillingCountry] [nvarchar] (40) NULL,
[BillingPostalCode] [nvarchar] (10) NULL,
[Total] [numeric] (10, 2) NOT NULL
)
GO
ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED ([InvoiceId])
GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceCustomerId] ON [dbo].[Invoice] ([CustomerId])
GO
ALTER TABLE [dbo].[Invoice] ADD CONSTRAINT [FK_InvoiceCustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
