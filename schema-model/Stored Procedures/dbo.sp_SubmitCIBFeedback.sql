SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_SubmitCIBFeedback]
    @CustomerId INT,
    @RelationshipManagerId INT = NULL,
    @Channel NVARCHAR(50),
    @Category NVARCHAR(100),
    @Rating INT,
    @FeedbackText NVARCHAR(2000) = NULL,
    @FeedbackId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF @Rating < 1 OR @Rating > 5
    BEGIN
        RAISERROR('Rating must be between 1 and 5.', 16, 1);
        RETURN;
    END;

    INSERT INTO [dbo].[CIBFeedback]
    (
        [CustomerId],
        [RelationshipManagerId],
        [FeedbackDate],
        [Channel],
        [Category],
        [Rating],
        [FeedbackText],
        [Status],
        [CreatedAt]
    )
    VALUES
    (
        @CustomerId,
        @RelationshipManagerId,
        GETDATE(),
        @Channel,
        @Category,
        @Rating,
        @FeedbackText,
        'New',
        GETDATE()
    );

    SET @FeedbackId = SCOPE_IDENTITY();
END;
GO
