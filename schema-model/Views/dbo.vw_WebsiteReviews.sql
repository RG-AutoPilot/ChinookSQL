SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_WebsiteReviews] AS
SELECT
    wr.ReviewId,
    wr.ReviewerName,
    wr.ReviewerEmail,
    wr.Rating,
    wr.ReviewText,
    wr.ReviewDate,
    wr.IsApproved,
    c.CustomerId,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email AS CustomerEmail,
    c.Country AS CustomerCountry
FROM [dbo].[WebsiteReview] wr
LEFT JOIN [dbo].[Customer] c ON wr.CustomerId = c.CustomerId;
GO
