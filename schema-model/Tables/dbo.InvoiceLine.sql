CREATE TABLE [dbo].[InvoiceLine]
(
[InvoiceLineId] [int] NOT NULL IDENTITY(1, 1),
[InvoiceId] [int] NOT NULL,
[TrackId] [int] NOT NULL,
[UnitPrice] [numeric] (10, 2) NOT NULL,
[Quantity] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [PK_InvoiceLine] PRIMARY KEY CLUSTERED ([InvoiceLineId])
GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceLineInvoiceId] ON [dbo].[InvoiceLine] ([InvoiceId])
GO
CREATE NONCLUSTERED INDEX [IFK_InvoiceLineTrackId] ON [dbo].[InvoiceLine] ([TrackId])
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLineInvoiceId] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([InvoiceId])
GO
ALTER TABLE [dbo].[InvoiceLine] ADD CONSTRAINT [FK_InvoiceLineTrackId] FOREIGN KEY ([TrackId]) REFERENCES [dbo].[Track] ([TrackId])
GO
