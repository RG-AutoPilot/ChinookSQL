SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[Discount]'
GO
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
[IsActive] [bit] NOT NULL CONSTRAINT [DF_Discount_IsActive] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_Discount] on [dbo].[Discount]'
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [PK_Discount] PRIMARY KEY CLUSTERED ([DiscountId])
GO
PRINT N'Adding constraints to [dbo].[Discount]'
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [UQ_Discount_DiscountCode] UNIQUE NONCLUSTERED ([DiscountCode])
GO
PRINT N'Creating [dbo].[sp_ApplyDiscount]'
GO
CREATE PROCEDURE [dbo].[sp_ApplyDiscount]
    @InvoiceId INT,
    @DiscountCode NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DiscountId INT;
    DECLARE @DiscountType NVARCHAR(20);
    DECLARE @DiscountValue NUMERIC(10, 2);
    DECLARE @MinOrderAmount NUMERIC(10, 2);
    DECLARE @StartDate DATETIME;
    DECLARE @EndDate DATETIME;
    DECLARE @IsActive BIT;
    DECLARE @InvoiceTotal NUMERIC(10, 2);
    DECLARE @DiscountAmount NUMERIC(10, 2);
    DECLARE @NewTotal NUMERIC(10, 2);

    -- Validate InvoiceId
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Invoice] WHERE [InvoiceId] = @InvoiceId)
    BEGIN
        RAISERROR('Invoice not found.', 16, 1);
        RETURN;
    END;

    -- Look up discount
    SELECT
        @DiscountId = [DiscountId],
        @DiscountType = [DiscountType],
        @DiscountValue = [DiscountValue],
        @MinOrderAmount = [MinOrderAmount],
        @StartDate = [StartDate],
        @EndDate = [EndDate],
        @IsActive = [IsActive]
    FROM [dbo].[Discount]
    WHERE [DiscountCode] = @DiscountCode;

    IF @DiscountId IS NULL
    BEGIN
        RAISERROR('Discount code not found.', 16, 1);
        RETURN;
    END;

    IF @IsActive = 0
    BEGIN
        RAISERROR('Discount code is not active.', 16, 1);
        RETURN;
    END;

    IF @StartDate IS NOT NULL AND GETDATE() < @StartDate
    BEGIN
        RAISERROR('Discount code is not yet valid.', 16, 1);
        RETURN;
    END;

    IF @EndDate IS NOT NULL AND GETDATE() > @EndDate
    BEGIN
        RAISERROR('Discount code has expired.', 16, 1);
        RETURN;
    END;

    -- Get current invoice total
    SELECT @InvoiceTotal = [Total]
    FROM [dbo].[Invoice]
    WHERE [InvoiceId] = @InvoiceId;

    IF @MinOrderAmount IS NOT NULL AND @InvoiceTotal < @MinOrderAmount
    BEGIN
        RAISERROR('Invoice total does not meet the minimum order amount for this discount.', 16, 1);
        RETURN;
    END;

    -- Calculate discount amount
    IF @DiscountType = 'Percentage'
        SET @DiscountAmount = @InvoiceTotal * (@DiscountValue / 100);
    ELSE
        SET @DiscountAmount = @DiscountValue;

    -- Ensure discount does not exceed invoice total
    IF @DiscountAmount > @InvoiceTotal
        SET @DiscountAmount = @InvoiceTotal;

    SET @NewTotal = @InvoiceTotal - @DiscountAmount;

    -- Apply discount to invoice
    UPDATE [dbo].[Invoice]
    SET [Total] = @NewTotal
    WHERE [InvoiceId] = @InvoiceId;

    -- Return updated invoice summary
    SELECT
        @InvoiceId AS [InvoiceId],
        @InvoiceTotal AS [OriginalTotal],
        @DiscountCode AS [DiscountCode],
        @DiscountAmount AS [DiscountAmount],
        @NewTotal AS [NewTotal];
END;
GO
PRINT N'Adding constraints to [dbo].[Discount]'
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [CK_Discount_DiscountType] CHECK (([DiscountType]='Fixed' OR [DiscountType]='Percentage'))
GO
ALTER TABLE [dbo].[Discount] ADD CONSTRAINT [CK_Discount_DiscountValue] CHECK (([DiscountValue]>(0)))
GO

SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
SET XACT_ABORT ON
GO

