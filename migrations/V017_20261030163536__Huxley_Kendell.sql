SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Altering [dbo].[Customer]'
GO
ALTER TABLE [dbo].[Customer] ADD
[SocialSignedUp] [INT] NULL,
[TestID2] [INT] NULL
GO
PRINT N'Creating [dbo].[getSPHux]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[getSPHux]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM Album
END
GO
PRINT N'Refreshing [dbo].[vw_CustomerInvoiceSummary]'
GO
EXEC sp_refreshview N'[dbo].[vw_CustomerInvoiceSummary]'
GO
PRINT N'Refreshing [dbo].[vw_EmployeePerformance]'
GO
EXEC sp_refreshview N'[dbo].[vw_EmployeePerformance]'
GO
PRINT N'Altering [dbo].[Flyway]'
GO
ALTER TABLE [dbo].[Flyway] ADD
[EncryptKey] [int] NULL
GO
PRINT N'Creating [dbo].[HuxONe]'
GO
CREATE TABLE [dbo].[HuxONe]
(
[HuxChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[HuxThree]'
GO
CREATE TABLE [dbo].[HuxThree]
(
[HuxChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[HuxTwo]'
GO
CREATE TABLE [dbo].[HuxTwo]
(
[HuxChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[Hux]'
GO
CREATE TABLE [dbo].[Hux]
(
[HuxChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[Mackie]'
GO
CREATE TABLE [dbo].[Mackie]
(
[HuxChange] [int] NULL
)
GO
PRINT N'Creating [dbo].[SandboxDemo]'
GO
CREATE TABLE [dbo].[SandboxDemo]
(
[SandboxDemoId] [INT] NOT NULL IDENTITY(1, 1),
[Note] [NVARCHAR] (100) NULL
)
GO
PRINT N'Creating primary key [PK_SandboxDemo] on [dbo].[SandboxDemo]'
GO
ALTER TABLE [dbo].[SandboxDemo] ADD CONSTRAINT [PK_SandboxDemo] PRIMARY KEY CLUSTERED ([SandboxDemoId])
GO
PRINT N'Creating [dbo].[SocialSignUp]'
GO
CREATE TABLE [dbo].[SocialSignUp]
(
[SignedUp] [INT] NULL,
[FaceBookName] [nvarchar] (24) NULL,
[Age] [INT] NULL
)
GO
PRINT N'Creating [dbo].[huxChange]'
GO
CREATE TABLE [dbo].[huxChange]
(
[HuxChange] [int] NULL
)
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

