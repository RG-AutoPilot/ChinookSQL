CREATE TABLE [dbo].[CustomerUpload]
(
[UploadId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[TrackName] [nvarchar] (200) NOT NULL,
[AlbumTitle] [nvarchar] (160) NULL,
[ArtistName] [nvarchar] (120) NULL,
[GenreId] [int] NULL,
[MediaTypeId] [int] NOT NULL,
[Composer] [nvarchar] (220) NULL,
[Milliseconds] [int] NULL,
[Bytes] [int] NULL,
[UnitPrice] [numeric] (10, 2) NOT NULL,
[UploadedAt] [datetime] NOT NULL,
[Status] [nvarchar] (20) NOT NULL
)
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [PK_CustomerUpload] PRIMARY KEY CLUSTERED ([UploadId])
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [DF_CustomerUpload_UploadedAt] DEFAULT (GETDATE()) FOR [UploadedAt]
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [DF_CustomerUpload_Status] DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [FK_CustomerUpload_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [FK_CustomerUpload_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId])
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [FK_CustomerUpload_MediaTypeId] FOREIGN KEY ([MediaTypeId]) REFERENCES [dbo].[MediaType] ([MediaTypeId])
GO
