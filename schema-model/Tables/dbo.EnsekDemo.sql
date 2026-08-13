CREATE TABLE [dbo].[EnsekDemo]
(
[EnsekDemoId] [int] NOT NULL IDENTITY(1, 1),
[AccountNumber] [nvarchar] (50) NOT NULL,
[CustomerName] [nvarchar] (100) NOT NULL,
[EnergyType] [nvarchar] (20) NULL,
[TariffCode] [nvarchar] (30) NULL,
[MeterReading] [decimal] (18, 2) NULL,
[ReadingDate] [datetime] NULL,
[CreatedAt] [datetime] NOT NULL CONSTRAINT [DF_EnsekDemo_CreatedAt] DEFAULT (getdate())
)
GO
ALTER TABLE [dbo].[EnsekDemo] ADD CONSTRAINT [PK_EnsekDemo] PRIMARY KEY CLUSTERED ([EnsekDemoId])
GO
