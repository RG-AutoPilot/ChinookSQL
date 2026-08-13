CREATE PROCEDURE [dbo].[sp_EnsekReport]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT * FROM [dbo].[EnsekDemo];

    SELECT * FROM [dbo].[Customer];
END
GO
