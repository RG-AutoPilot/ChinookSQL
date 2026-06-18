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
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [PK_InnovatorsGuild] PRIMARY KEY CLUSTERED ([AttendeeId])
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [CK_InnovatorsGuild_EnjoymentRating] CHECK ([EnjoymentRating] >= 1 AND [EnjoymentRating] <= 10)
GO
CREATE NONCLUSTERED INDEX [IFK_InnovatorsGuild_CustomerId] ON [dbo].[InnovatorsGuild] ([CustomerId])
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [FK_InnovatorsGuild_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customer] ([CustomerId])
GO
CREATE NONCLUSTERED INDEX [IFK_InnovatorsGuild_HostEmployeeId] ON [dbo].[InnovatorsGuild] ([HostEmployeeId])
GO
ALTER TABLE [dbo].[InnovatorsGuild] ADD CONSTRAINT [FK_InnovatorsGuild_HostEmployeeId] FOREIGN KEY ([HostEmployeeId]) REFERENCES [dbo].[Employee] ([EmployeeId])
GO
