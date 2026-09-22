CREATE TABLE [dbo].[CustomerProducts]
(
[CustomerProductsId] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (24) NULL,
[Company] [nvarchar] (24) NULL,
[Products] [nvarchar] (24) NULL
)
GO
ALTER TABLE [dbo].[CustomerProducts] ADD CONSTRAINT [PK_CustomerProducts] PRIMARY KEY CLUSTERED ([CustomerProductsId])
GO
