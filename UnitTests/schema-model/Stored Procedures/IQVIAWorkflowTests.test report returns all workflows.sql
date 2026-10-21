SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [IQVIAWorkflowTests].[test report returns all workflows]
AS
BEGIN
    SET NOCOUNT ON;

    EXEC tSQLt.FakeTable @TableName = N'dbo.IQVIA';

    INSERT INTO dbo.IQVIA (IQVIAId, WorkflowName, Status, CreatedAt)
    VALUES (1, N'Schema demo', N'Completed', '20261021'),
           (2, N'Migration demo', N'Pending', '20261021');

    SELECT IQVIAId, WorkflowName, Status, CreatedAt
    INTO #Expected
    FROM dbo.IQVIA;

    SELECT TOP (0) IQVIAId, WorkflowName, Status, CreatedAt
    INTO #Actual
    FROM dbo.IQVIA;

    INSERT INTO #Actual
    EXEC dbo.getIQVIAWorkflowReport;

    EXEC tSQLt.AssertEqualsTable @Expected = N'#Expected', @Actual = N'#Actual';
END;
GO
