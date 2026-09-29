SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[getAmsterdamClients]'
GO
CREATE PROCEDURE [dbo].[getAmsterdamClients]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ab.*
    FROM dbo.AddressBook ab
    JOIN dbo.Customer c ON c.CustomerId = ab.CustomerId
    WHERE c.City = N'Amsterdam';
END
GO
PRINT N'Altering [dbo].[CustomerProducts]'
GO
ALTER TABLE [dbo].[CustomerProducts] ADD
[TestID] [int] NULL
GO
PRINT N'Creating [dbo].[AmsterdamDemo]'
GO
CREATE TABLE [dbo].[AmsterdamDemo]
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

