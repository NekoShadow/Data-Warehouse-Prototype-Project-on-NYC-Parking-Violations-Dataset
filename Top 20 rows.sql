USE Group_9_DB
GO

SELECT TOP (25) Summons_Key,
		Ticket_Price,
		Plate_ID,
		Street_Name,
		County,
		Body_Type,
		Color,
		Issuer_Command,
		Full_Date_Descr,
		Day_In_Week_Name,
		[Time]
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Car] ON [dbo].[Fact_Parking_Tickets].Car_Key = [dbo].[Dim_Car].[Car_Key]
	JOIN [dbo].[Dim_Issuer] ON [dbo].[Dim_Issuer].Issuer_Key = [dbo].[Fact_Parking_Tickets].Issuer_Key
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
	JOIN [dbo].[Dim_Time] ON [dbo].[Dim_Time].Time_Key = [dbo].[Fact_Parking_Tickets].Time_Key