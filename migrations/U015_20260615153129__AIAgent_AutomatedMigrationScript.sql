SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping constraints from [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] DROP CONSTRAINT [PK_AddressBook]
GO
PRINT N'Dropping [dbo].[InnovatorsGuild]'
GO
DROP TABLE [dbo].[InnovatorsGuild]
GO
PRINT N'Altering [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] DROP
COLUMN [AddressBookId]
GO
PRINT N'Creating [dbo].[HuxleyTest]'
GO
CREATE TABLE [dbo].[HuxleyTest]
(
[AlbumId] [int] NOT NULL IDENTITY(1, 1)
)
GO
PRINT N'Creating [dbo].[Huxley]'
GO
CREATE TABLE [dbo].[Huxley]
(
[Hux] [int] NOT NULL
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

