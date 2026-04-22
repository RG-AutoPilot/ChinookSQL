CREATE TABLE [dbo].[MediaType]
(
[MediaTypeId] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (120) NULL
)
GO
ALTER TABLE [dbo].[MediaType] ADD CONSTRAINT [PK_MediaType] PRIMARY KEY CLUSTERED ([MediaTypeId])
GO
