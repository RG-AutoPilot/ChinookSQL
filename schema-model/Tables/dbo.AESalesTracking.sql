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
ALTER TABLE [dbo].[AESalesTracking] ADD CONSTRAINT [PK_AESalesTracking] PRIMARY KEY CLUSTERED ([AEId])
GO
