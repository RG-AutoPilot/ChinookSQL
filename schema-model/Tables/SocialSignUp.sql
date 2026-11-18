CREATE TABLE [dbo].[SocialSignUp]
(
[SocialSignUpId] [int] NOT NULL IDENTITY(1, 1),
[SignedUp] [int] NULL,
[FaceBookName] [nvarchar] (24) NULL,
[Age] [int] NULL
)
GO
ALTER TABLE [dbo].[SocialSignUp] ADD CONSTRAINT [PK_SocialSignUp] PRIMARY KEY CLUSTERED ([SocialSignUpId])
GO
