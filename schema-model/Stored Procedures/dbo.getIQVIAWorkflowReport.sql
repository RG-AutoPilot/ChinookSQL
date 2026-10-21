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
