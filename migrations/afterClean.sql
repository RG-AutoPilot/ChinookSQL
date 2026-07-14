/*
Run this script on:

        WIN2016.Chinook_Build    -  This database will be modified

to synchronize it with:

        WIN2016.Chinook_Test

You are recommended to back up your database before running this script

Script created by SQL Compare version 15.4.29.28207 from Red Gate Software Ltd at 2/17/2026 4:25:17 PM

*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL Serializable
GO
BEGIN TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping types'
GO
IF TYPE_ID(N'[tSQLt].[AssertStringTable]') IS NOT NULL
DROP TYPE [tSQLt].[AssertStringTable]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
IF TYPE_ID(N'[tSQLt].[Private]') IS NOT NULL
DROP TYPE [tSQLt].[Private]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping CLR assemblies'
GO
IF EXISTS (SELECT 1 FROM sys.assemblies WHERE name = N'tSQLtCLR')
DROP ASSEMBLY [tSQLtCLR]
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
PRINT N'Dropping schemas'
GO
IF SCHEMA_ID(N'tSQLt') IS NOT NULL
DROP SCHEMA [tSQLt]
GO
COMMIT TRANSACTION
GO
IF @@ERROR <> 0 SET NOEXEC ON
GO
-- This statement writes to the SQL Server Log so SQL Monitor can show this deployment.
IF HAS_PERMS_BY_NAME(N'sys.xp_logevent', N'OBJECT', N'EXECUTE') = 1
BEGIN
    DECLARE @databaseName AS nvarchar(2048), @eventMessage AS nvarchar(2048)
    SET @databaseName = REPLACE(REPLACE(DB_NAME(), N'\', N'\\'), N'"', N'\"')
    SET @eventMessage = N'Redgate SQL Compare: { "deployment": { "description": "Redgate SQL Compare deployed to ' + @databaseName + N'", "database": "' + @databaseName + N'" }}'
    EXECUTE sys.xp_logevent 55000, @eventMessage
END
GO
DECLARE @Success AS BIT
SET @Success = 1
SET NOEXEC OFF
IF (@Success = 1) PRINT 'The database update succeeded'
ELSE BEGIN
	IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION
	PRINT 'The database update failed'
END
GO
