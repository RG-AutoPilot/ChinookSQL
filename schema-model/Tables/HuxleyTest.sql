CREATE TABLE [dbo].[HuxleyTest]
(
[AlbumId] [int] NOT NULL IDENTITY(1, 1)
)
GO
ALTER TABLE [dbo].[HuxleyTest] ADD CONSTRAINT [PK_HuxleyTest] PRIMARY KEY CLUSTERED ([AlbumId])
GO
