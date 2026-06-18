SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[InnovatorsGuild]'
GO
CREATE TABLE [dbo].[InnovatorsGuild]
(
[AttendeeId] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NULL,
[HostEmployeeId] [int] NULL,
[FirstName] [nvarchar] (40) NOT NULL,
[LastName] [nvarchar] (40) NOT NULL,
[Email] [nvarchar] (60) NOT NULL,
[SessionDate] [datetime] NOT NULL,
[EnjoymentRating] [tinyint] NOT NULL,
[Comments] [nvarchar] (500) NULL,
[RegisteredAt] [datetime] NOT NULL CONSTRAINT [DF_InnovatorsGuild_RegisteredAt] DEFAULT (getdate())
)
GO
PRINT N'Creating primary key [PK_InnovatorsGuild] on [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [PK_InnovatorsGuild] PRIMARY KEY CLUSTERED ([AttendeeId])
GO
PRINT N'Creating index [IFK_InnovatorsGuild_CustomerId] on [dbo].[InnovatorsGuild]'
GO
CREATE NONCLUSTERED INDEX [IFK_InnovatorsGuild_CustomerId] ON [dbo].[InnovatorsGuild] ([CustomerId])
GO
PRINT N'Creating index [IFK_InnovatorsGuild_HostEmployeeId] on [dbo].[InnovatorsGuild]'
GO
CREATE NONCLUSTERED INDEX [IFK_InnovatorsGuild_HostEmployeeId] ON [dbo].[InnovatorsGuild] ([HostEmployeeId])
GO
PRINT N'Adding constraints to [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [CK_InnovatorsGuild_EnjoymentRating] CHECK (([EnjoymentRating]>=(1) AND [EnjoymentRating]<=(10)))
GO
PRINT N'Adding foreign keys to [dbo].[InnovatorsGuild]'
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [FK_InnovatorsGuild_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [FK_InnovatorsGuild_HostEmployeeId] FOREIGN KEY ([HostEmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

