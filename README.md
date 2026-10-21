# Introduction 
ChinookSQL is a database project for the Chinook sample database. It manages SQL migrations and schema changes using Flyway, with automated testing and CI/CD integration.

# Getting Started
TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:
1.	Installation process
2.	Software dependencies
3.	Latest releases
4.	API references

# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

# IQVIA MCP / agentic workflow demo

`dbo.IQVIA` stores synthetic workflow metadata, not patient data. Each row has
an identity key, workflow name, status (`Pending`, `Running`, `Completed`, or
`Failed`), and a UTC creation timestamp. `dbo.getIQVIAWorkflowReport` returns
newest rows first, optionally filtered by workflow name and/or status.

The demo illustrates the database-change path: an agent edits the schema model,
Flyway MCP compares it with migrations and generates versioned/undo scripts,
and the migration build pipeline validates deployment before review.
The IQVIA migration scripts were authored manually because MCP generation was
blocked by SQL Server integrated authentication in the task environment.
The stored procedure queries demo data; it does not itself invoke MCP or an agent.

After applying migrations through version `010_20261021150000`, run this
transactional demo (the sample row is rolled back):

```sql
BEGIN TRANSACTION;

INSERT INTO dbo.IQVIA (WorkflowName, Status)
VALUES (N'MCP / agentic schema demo', N'Completed');

EXEC dbo.getIQVIAWorkflowReport;
EXEC dbo.getIQVIAWorkflowReport
    @WorkflowName = N'MCP / agentic schema demo',
    @Status = N'Completed';

ROLLBACK TRANSACTION;
```

Focused tSQLt tests are included in the unit-test schema model and run with the
existing Flyway build pipeline. After deploying that model to a test database,
run `EXEC tSQLt.Run N'IQVIAWorkflowTests';`.
The matching undo migration drops the procedure before the table and deletes
any IQVIA demo rows; use it only when that data can be discarded.
