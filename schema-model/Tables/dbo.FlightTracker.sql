CREATE TABLE [dbo].[FlightTracker]
(
[FlightTrackerId] [int] NOT NULL IDENTITY(1, 1),
[FlightID] [int] NULL,
[FlightNumber] [int] NULL
)
GO
ALTER TABLE [dbo].[FlightTracker] ADD CONSTRAINT [PK_FlightTracker] PRIMARY KEY CLUSTERED ([FlightTrackerId])
GO
