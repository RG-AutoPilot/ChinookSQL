SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_WebsiteReviewSummary] AS
SELECT
    wr.ReviewId,
    wr.Rating,
    wr.ReviewText,
    wr.PageUrl,
    wr.ReviewDate,
    wr.IsApproved,
    COALESCE(c.FirstName + ' ' + c.LastName, wr.ReviewerName) AS ReviewerName,
    COALESCE(c.Email, wr.ReviewerEmail) AS ReviewerEmail,
    wr.CustomerId
FROM [dbo].[WebsiteReview] wr
LEFT JOIN [dbo].[Customer] c ON wr.CustomerId = c.CustomerId;
GO
