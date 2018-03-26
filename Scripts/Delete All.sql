USE [Group_9_DB]
GO

DELETE FROM [dbo].[Dim_Car]
DELETE FROM [dbo].[Dim_Date]
DELETE FROM [dbo].[Dim_Issuer]
DELETE FROM [dbo].[Dim_Time]
DELETE FROM [dbo].[Dim_Location]
DELETE FROM [dbo].[Temp_Ticket]

DELETE FROM [dbo].[Fact_Parking_Tickets]