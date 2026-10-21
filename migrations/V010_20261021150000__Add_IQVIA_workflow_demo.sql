SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TABLE [dbo].[IQVIA]
(
[IQVIAId] [int] NOT NULL IDENTITY(1, 1),
[WorkflowName] [nvarchar] (100) NOT NULL,
[Status] [nvarchar] (20) NOT NULL,
[CreatedAt] [datetime2] (0) NOT NULL CONSTRAINT [DF_IQVIA_CreatedAt] DEFAULT (SYSUTCDATETIME())
)
GO
ALTER TABLE [dbo].[IQVIA] ADD CONSTRAINT [PK_IQVIA] PRIMARY KEY CLUSTERED ([IQVIAId])
GO
ALTER TABLE [dbo].[IQVIA] ADD CONSTRAINT [CK_IQVIA_Status] CHECK ([Status] IN (N'Pending', N'Running', N'Completed', N'Failed'))
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[getIQVIAWorkflowReport]
    @WorkflowName NVARCHAR(100) = NULL,
    @Status NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Synthetic workflow metadata only; no patient data.
    SELECT
        IQVIAId,
        WorkflowName,
        Status,
        CreatedAt
    FROM dbo.IQVIA
    WHERE (@WorkflowName IS NULL OR WorkflowName = @WorkflowName)
      AND (@Status IS NULL OR Status = @Status)
    ORDER BY CreatedAt DESC, IQVIAId DESC;
END;
GO
