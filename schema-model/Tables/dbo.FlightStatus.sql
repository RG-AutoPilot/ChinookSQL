CREATE TABLE [dbo].[FlightStatus]
(
[FlightStatusId] [int] NOT NULL IDENTITY(1, 1),
[CustomerInfo] [int] NULL
)
GO
ALTER TABLE [dbo].[FlightStatus] ADD CONSTRAINT [PK_FlightStatus] PRIMARY KEY CLUSTERED ([FlightStatusId])
GO
