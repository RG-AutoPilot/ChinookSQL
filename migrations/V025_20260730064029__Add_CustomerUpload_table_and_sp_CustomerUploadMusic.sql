SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[CustomerUpload]'
GO
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
[UploadedAt] [datetime] NOT NULL CONSTRAINT [DF_CustomerUpload_UploadedAt] DEFAULT (getdate()),
[Status] [nvarchar] (20) NOT NULL CONSTRAINT [DF_CustomerUpload_Status] DEFAULT ('Pending')
)
GO
PRINT N'Creating primary key [PK_CustomerUpload] on [dbo].[CustomerUpload]'
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [PK_CustomerUpload] PRIMARY KEY CLUSTERED ([UploadId])
GO
PRINT N'Creating [dbo].[sp_CustomerUploadMusic]'
GO

CREATE PROCEDURE [dbo].[sp_CustomerUploadMusic]
    @CustomerId INT,
    @TrackName NVARCHAR(200),
    @AlbumTitle NVARCHAR(160) = NULL,
    @ArtistName NVARCHAR(120) = NULL,
    @GenreId INT = NULL,
    @MediaTypeId INT,
    @Composer NVARCHAR(220) = NULL,
    @Milliseconds INT = NULL,
    @Bytes INT = NULL,
    @UnitPrice NUMERIC(10, 2) = 0.99
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[CustomerUpload]
    (
        [CustomerId],
        [TrackName],
        [AlbumTitle],
        [ArtistName],
        [GenreId],
        [MediaTypeId],
        [Composer],
        [Milliseconds],
        [Bytes],
        [UnitPrice],
        [UploadedAt],
        [Status]
    )
    VALUES
    (
        @CustomerId,
        @TrackName,
        @AlbumTitle,
        @ArtistName,
        @GenreId,
        @MediaTypeId,
        @Composer,
        @Milliseconds,
        @Bytes,
        @UnitPrice,
        GETDATE(),
        'Pending'
    );

    SELECT SCOPE_IDENTITY() AS UploadId;
END;
GO
PRINT N'Adding foreign keys to [dbo].[CustomerUpload]'
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [FK_CustomerUpload_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [FK_CustomerUpload_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId])
GO
ALTER TABLE [dbo].[CustomerUpload] ADD CONSTRAINT [FK_CustomerUpload_MediaTypeId] FOREIGN KEY ([MediaTypeId]) REFERENCES [dbo].[MediaType] ([MediaTypeId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

