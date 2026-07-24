SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[CIBFeedback]'
GO
CREATE TABLE [dbo].[CIBFeedback]
(
[FeedbackId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[RelationshipManagerId] [int] NULL,
[FeedbackDate] [datetime] NOT NULL CONSTRAINT [DF_CIBFeedback_FeedbackDate] DEFAULT (getdate()),
[Channel] [nvarchar] (50) NOT NULL,
[Category] [nvarchar] (100) NOT NULL,
[Rating] [int] NOT NULL,
[FeedbackText] [nvarchar] (2000) NULL,
[Status] [nvarchar] (50) NOT NULL CONSTRAINT [DF_CIBFeedback_Status] DEFAULT ('New'),
[CreatedAt] [datetime] NOT NULL CONSTRAINT [DF_CIBFeedback_CreatedAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_CIBFeedback] on [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [PK_CIBFeedback] PRIMARY KEY CLUSTERED ([FeedbackId])
GO
PRINT N'Creating index [IFK_CIBFeedback_Customer] on [dbo].[CIBFeedback]'
GO
CREATE NONCLUSTERED INDEX [IFK_CIBFeedback_Customer] ON [dbo].[CIBFeedback] ([CustomerId])
GO
PRINT N'Creating index [IFK_CIBFeedback_RelationshipManager] on [dbo].[CIBFeedback]'
GO
CREATE NONCLUSTERED INDEX [IFK_CIBFeedback_RelationshipManager] ON [dbo].[CIBFeedback] ([RelationshipManagerId])
GO
PRINT N'Creating [dbo].[sp_SubmitCIBFeedback]'
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
PRINT N'Adding constraints to [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [CK_CIBFeedback_Rating] CHECK (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [CK_CIBFeedback_Status] CHECK ((([Status]='Closed' OR [Status]='Resolved' OR [Status]='In Review' OR [Status]='New')))
GO
PRINT N'Adding foreign keys to [dbo].[CIBFeedback]'
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [FK_CIBFeedback_Customer] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[CIBFeedback] ADD CONSTRAINT [FK_CIBFeedback_RelationshipManager] FOREIGN KEY ([RelationshipManagerId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

