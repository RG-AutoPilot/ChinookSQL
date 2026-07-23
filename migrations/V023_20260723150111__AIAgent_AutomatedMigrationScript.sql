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
PRINT N'Creating [dbo].[AESalesTracking]'
GO
CREATE TABLE [dbo].[AESalesTracking]
(
[AEId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (50) NOT NULL,
[LastName] [nvarchar] (50) NOT NULL,
[Email] [nvarchar] (100) NOT NULL,
[Region] [nvarchar] (50) NULL,
[DealName] [nvarchar] (200) NOT NULL,
[DealValue] [numeric] (18, 2) NOT NULL,
[DealStage] [nvarchar] (50) NOT NULL,
[DealDate] [date] NULL,
[CreatedAt] [datetime] NOT NULL CONSTRAINT [DF_AESalesTracking_CreatedAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_AESalesTracking] on [dbo].[AESalesTracking]'
GO
ALTER TABLE [dbo].[AESalesTracking] ADD CONSTRAINT [PK_AESalesTracking] PRIMARY KEY CLUSTERED ([AEId])
GO
PRINT N'Creating [dbo].[sp_AESalesReport]'
GO

CREATE PROCEDURE [dbo].[sp_AESalesReport]
    @Region NVARCHAR(50) = NULL,
    @DealStage NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ae.AEId,
        ae.FirstName,
        ae.LastName,
        ae.Email,
        ae.Region,
        ae.DealName,
        ae.DealValue,
        ae.DealStage,
        ae.DealDate,
        ae.CreatedAt
    FROM [dbo].[AESalesTracking] ae
    WHERE (@Region IS NULL OR ae.Region = @Region)
      AND (@DealStage IS NULL OR ae.DealStage = @DealStage)
    ORDER BY ae.CreatedAt DESC;
END;
GO
PRINT N'Creating [dbo].[vw_AESalesPerformance]'
GO
CREATE VIEW [dbo].[vw_AESalesPerformance] AS
SELECT
    ae.AEId,
    ae.FirstName + ' ' + ae.LastName AS AEName,
    ae.Email,
    ae.Region,
    COUNT(ae.AEId) AS TotalDeals,
    SUM(CASE WHEN ae.DealStage = 'Closed Won' THEN 1 ELSE 0 END) AS WonDeals,
    SUM(CASE WHEN ae.DealStage = 'Closed Lost' THEN 1 ELSE 0 END) AS LostDeals,
    ISNULL(SUM(ae.DealValue), 0) AS TotalDealValue,
    ISNULL(SUM(CASE WHEN ae.DealStage = 'Closed Won' THEN ae.DealValue ELSE 0 END), 0) AS WonDealValue,
    ISNULL(AVG(ae.DealValue), 0) AS AverageDealValue,
    CASE
        WHEN COUNT(ae.AEId) = 0 THEN 0
        ELSE CAST(SUM(CASE WHEN ae.DealStage = 'Closed Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(ae.AEId) AS numeric(5, 2))
    END AS WinRatePct
FROM [dbo].[AESalesTracking] ae
GROUP BY ae.AEId, ae.FirstName, ae.LastName, ae.Email, ae.Region;
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

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

