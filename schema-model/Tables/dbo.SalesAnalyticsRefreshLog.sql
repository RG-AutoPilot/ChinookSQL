CREATE TABLE [dbo].[SalesAnalyticsRefreshLog]
(
[SalesAnalyticsRefreshLogId] [int] NOT NULL IDENTITY(1, 1),
[StartTimeUtc] [datetime2] NOT NULL,
[EndTimeUtc] [datetime2] NOT NULL,
[DurationMs] [int] NOT NULL,
[Iterations] [int] NOT NULL,
[RowsTouched] [bigint] NOT NULL
)
GO
ALTER TABLE [dbo].[SalesAnalyticsRefreshLog] ADD CONSTRAINT [PK_SalesAnalyticsRefreshLog] PRIMARY KEY CLUSTERED ([SalesAnalyticsRefreshLogId])
GO
CREATE NONCLUSTERED INDEX [IX_SalesAnalyticsRefreshLog_StartTimeUtc] ON [dbo].[SalesAnalyticsRefreshLog] ([StartTimeUtc])
GO
