SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [FK_InnovatorsGuild_HostEmployeeId]
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [FK_InnovatorsGuild_CustomerId]
GO
PRINT N'Dropping constraints from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [CK_InnovatorsGuild_EnjoymentRating]
GO
PRINT N'Dropping constraints from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [PK_InnovatorsGuild]
GO
PRINT N'Dropping constraints from [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP CONSTRAINT [DF_InnovatorsGuild_RegisteredAt]
GO
PRINT N'Dropping index [IFK_InnovatorsGuild_HostEmployeeId] from [dbo].[InnovatorsGuild]'
GO
DROP INDEX [IFK_InnovatorsGuild_HostEmployeeId] ON [dbo].[InnovatorsGuild]
GO
PRINT N'Dropping index [IFK_InnovatorsGuild_CustomerId] from [dbo].[InnovatorsGuild]'
GO
DROP INDEX [IFK_InnovatorsGuild_CustomerId] ON [dbo].[InnovatorsGuild]
GO
PRINT N'Creating [dbo].[getCustInfo]'
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[getCustInfo]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT * FROM dbo.Customer
END
GO
PRINT N'Altering [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] DROP
COLUMN [AttendeeId],
COLUMN [HostEmployeeId],
COLUMN [FirstName],
COLUMN [LastName],
COLUMN [Email],
COLUMN [SessionDate],
COLUMN [EnjoymentRating],
COLUMN [Comments],
COLUMN [RegisteredAt],
COLUMN [WasThisHelpful]
GO
EXEC sp_rename N'[dbo].[InnovatorsGuild].[CustomerId]', N'DemoV2', N'COLUMN'
GO
PRINT N'Creating [dbo].[FlightTracker]'
GO
CREATE TABLE [dbo].[FlightTracker]
(
[FlightID] [int] NULL,
[FlightNumber] [int] NULL
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

