SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[getAmsterdamClients]
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ab.*
    FROM dbo.AddressBook ab
    JOIN dbo.Customer c ON c.CustomerId = ab.CustomerId
    WHERE c.City = N'Amsterdam';
END
GO
