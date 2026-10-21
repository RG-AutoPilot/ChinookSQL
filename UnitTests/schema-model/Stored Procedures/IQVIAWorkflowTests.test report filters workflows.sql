SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [IQVIAWorkflowTests].[test report filters workflows]
AS
BEGIN
    SET NOCOUNT ON;

    EXEC tSQLt.FakeTable @TableName = N'dbo.IQVIA';

    INSERT INTO dbo.IQVIA (IQVIAId, WorkflowName, Status, CreatedAt)
    VALUES (1, N'Schema demo', N'Completed', '20261021'),
           (2, N'Schema demo', N'Pending', '20261021'),
           (3, N'Migration demo', N'Completed', '20261021');

    SELECT IQVIAId, WorkflowName, Status, CreatedAt
    INTO #Expected
    FROM dbo.IQVIA
    WHERE IQVIAId = 1;

    SELECT TOP (0) IQVIAId, WorkflowName, Status, CreatedAt
    INTO #Actual
    FROM dbo.IQVIA;

    INSERT INTO #Actual
    EXEC dbo.getIQVIAWorkflowReport
        @WorkflowName = N'Schema demo', @Status = N'Completed';

    EXEC tSQLt.AssertEqualsTable @Expected = N'#Expected', @Actual = N'#Actual';

    DELETE FROM #Actual;
    DELETE FROM #Expected;

    INSERT INTO #Actual
    EXEC dbo.getIQVIAWorkflowReport @WorkflowName = N'Unknown workflow';

    EXEC tSQLt.AssertEqualsTable @Expected = N'#Expected', @Actual = N'#Actual';
END;
GO
