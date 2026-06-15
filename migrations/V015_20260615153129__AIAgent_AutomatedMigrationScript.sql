SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping [dbo].[Huxley]'
GO
DROP TABLE [dbo].[Huxley]
GO
PRINT N'Dropping [dbo].[HuxleyTest]'
GO
DROP TABLE [dbo].[HuxleyTest]
GO
PRINT N'Altering [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] ADD
[AddressBookId] [int] NOT NULL IDENTITY(1, 1)
GO
PRINT N'Creating primary key [PK_AddressBook] on [dbo].[AddressBook]'
GO
ALTER TABLE [dbo].[AddressBook] ADD CONSTRAINT [PK_AddressBook] PRIMARY KEY CLUSTERED ([AddressBookId])
GO
PRINT N'Creating [dbo].[InnovatorsGuild]'
GO
CREATE TABLE [dbo].[InnovatorsGuild]
(
[DemoV2] [int] NULL
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

