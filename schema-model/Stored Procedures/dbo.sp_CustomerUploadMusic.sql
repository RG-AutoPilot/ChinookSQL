SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
