/** Template*/
SELECT *
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Car] ON [dbo].[Fact_Parking_Tickets].Car_Key = [dbo].[Dim_Car].[Car_Key]
	JOIN [dbo].[Dim_Issuer] ON [dbo].[Dim_Issuer].Issuer_Key = [dbo].[Fact_Parking_Tickets].Issuer_Key
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
	JOIN [dbo].[Dim_Time] ON [dbo].[Dim_Time].Time_Key = [dbo].[Fact_Parking_Tickets].Time_Key

/* Ques1 */

SELECT CONCAT(Hour_24,':00') AS "Time Slot(24-hour)", COUNT(Summons_Key) AS "Number Of Tickets Issued",
	RANK() OVER (ORDER BY  COUNT(Summons_Key) DESC) AS "Rank"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
	JOIN [dbo].[Dim_Time] ON [dbo].[Dim_Time].Time_Key = [dbo].[Fact_Parking_Tickets].Time_Key
WHERE Evening_Rush_Hours = 1
	AND Day_In_Week = 5
	AND County like 'BROOKLYN'
GROUP BY Hour_24
ORDER BY "Rank"

/* Ques 2 */
SELECT County AS "Borough", COUNT(Summons_Key) AS "Number Of Tickets Issued",
	RANK() OVER (ORDER BY  COUNT(Summons_Key) DESC) AS "Rank"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
WHERE Weekend_Indicator = 1
GROUP BY County
ORDER BY "Rank"

/* Ques 3 */
SELECT Season, COUNT(Summons_Key) AS "Number Of Tickets Issued",
	RANK() OVER (ORDER BY  COUNT(Summons_Key) DESC) AS "Rank"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
GROUP BY Season
ORDER BY "Rank"

/* Ques 4 */
SELECT Issuer_Precinct AS "Tickets Issued in Precinct", COUNT(Summons_Key) AS "Number Of Tickets Issued",
	RANK() OVER (ORDER BY  COUNT(Summons_Key) DESC) AS "Rank"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Car] ON [dbo].[Fact_Parking_Tickets].Car_Key = [dbo].[Dim_Car].[Car_Key]
	JOIN [dbo].[Dim_Issuer] ON [dbo].[Dim_Issuer].Issuer_Key = [dbo].[Fact_Parking_Tickets].Issuer_Key
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
	JOIN [dbo].[Dim_Time] ON [dbo].[Dim_Time].Time_Key = [dbo].[Fact_Parking_Tickets].Time_Key
WHERE Month = 1
	AND Year = 2017
GROUP BY Precinct
ORDER BY "Rank"