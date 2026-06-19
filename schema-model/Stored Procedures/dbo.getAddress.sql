SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--GO
CREATE PROCEDURE [dbo].[getAddress]
    @parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT [AddressBookId], [FirstName], [LastName], [Age] FROM dbo.AddressBook WHERE [AddressBookId] = @parameter_name
END
GO
