SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[CustomerProducts]'
GO
CREATE TABLE [dbo].[CustomerProducts]
(
[FirstName] [nvarchar] (24) NULL,
[Company] [nvarchar] (24) NULL,
[Products] [nvarchar] (24) NULL
)
GO
PRINT N'Creating [dbo].[getProducts]'
GO
--GO
CREATE PROCEDURE [dbo].[getProducts]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.CustomerProducts
END
GO
PRINT N'Creating [dbo].[Customers]'
GO
CREATE TABLE [dbo].[Customers]
(
[FirstName] [nvarchar] (24) NULL,
[LastName] [nvarchar] (24) NULL
)
GO
PRINT N'Creating [dbo].[DemoQuick]'
GO
CREATE TABLE [dbo].[DemoQuick]
(
[FirstTable] [int] NULL
)
GO
PRINT N'Creating [dbo].[FiresideChat]'
GO
CREATE TABLE [dbo].[FiresideChat]
(
[Demo] [int] NULL
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

