SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_AESalesReport]
    @Region NVARCHAR(50) = NULL,
    @DealStage NVARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ae.AEId,
        ae.FirstName,
        ae.LastName,
        ae.Email,
        ae.Region,
        ae.DealName,
        ae.DealValue,
        ae.DealStage,
        ae.DealDate,
        ae.CreatedAt
    FROM [dbo].[AESalesTracking] ae
    WHERE (@Region IS NULL OR ae.Region = @Region)
      AND (@DealStage IS NULL OR ae.DealStage = @DealStage)
    ORDER BY ae.CreatedAt DESC;
END;
GO
