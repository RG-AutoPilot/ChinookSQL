CREATE TABLE [dbo].[MCPTrialSignup]
(
[SignupId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (100) NOT NULL,
[LastName] [nvarchar] (100) NOT NULL,
[Email] [nvarchar] (255) NOT NULL,
[CompanyName] [nvarchar] (255) NULL,
[SignupDate] [datetime] NOT NULL CONSTRAINT [DF_MCPTrialSignup_SignupDate] DEFAULT (getdate()),
[TrialStatus] [nvarchar] (50) NOT NULL CONSTRAINT [DF_MCPTrialSignup_TrialStatus] DEFAULT ('Pending')
)
GO
ALTER TABLE [dbo].[MCPTrialSignup] ADD CONSTRAINT [PK_MCPTrialSignup] PRIMARY KEY CLUSTERED ([SignupId])
GO
CREATE NONCLUSTERED INDEX [IX_MCPTrialSignup_Email] ON [dbo].[MCPTrialSignup] ([Email])
GO
