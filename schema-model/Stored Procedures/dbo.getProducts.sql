SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[getProducts]
AS
BEGIN
    SELECT [FirstName], [Company], [Products] FROM dbo.CustomerProducts
END
GO
