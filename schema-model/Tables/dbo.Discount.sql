CREATE TABLE [dbo].[Discount]
(
[DiscountId] [int] NOT NULL IDENTITY(1, 1),
[DiscountCode] [nvarchar] (50) NOT NULL,
[Description] [nvarchar] (255) NULL,
[DiscountType] [nvarchar] (20) NOT NULL,
[DiscountValue] [numeric] (10, 2) NOT NULL,
[MinOrderAmount] [numeric] (10, 2) NULL,
[StartDate] [datetime] NULL,
[EndDate] [datetime] NULL,
[IsActive] [bit] NOT NULL
)
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED ([DiscountId])
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [UQ_Discount_DiscountCode] UNIQUE ([DiscountCode])
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [CK_Discount_DiscountType] CHECK (([DiscountType]='Fixed' OR [DiscountType]='Percentage'))
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [CK_Discount_DiscountValue] CHECK (([DiscountValue]>(0)))
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [DF_Discount_IsActive] DEFAULT ((1)) FOR [IsActive]
GO
