USE Group_9_DB
GO

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
SELECT *
FROM
	(SELECT Color, COUNT(Summons_Key) AS "Number Of Tickets Issued",
		RANK() OVER (ORDER BY  COUNT(Summons_Key) DESC) AS "Rank"
	FROM
		[dbo].[Fact_Parking_Tickets]
		JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
		JOIN [dbo].[Dim_Car] ON [dbo].[Fact_Parking_Tickets].Car_Key = [dbo].[Dim_Car].[Car_Key]
		JOIN [dbo].[Dim_Issuer] ON [dbo].[Dim_Issuer].Issuer_Key = [dbo].[Fact_Parking_Tickets].Issuer_Key
		JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
		JOIN [dbo].[Dim_Time] ON [dbo].[Dim_Time].Time_Key = [dbo].[Fact_Parking_Tickets].Time_Key
	WHERE Color not like 'OTHER'
	GROUP BY Color) AS sub
	WHERE "Rank" <= 5


/* Ques 5 */

SELECT County, FORMAT(SUM(Ticket_Price), 'C') AS "Total Amount of Fine Issued",
	RANK() OVER (ORDER BY  SUM(Ticket_Price) DESC) AS "Rank"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
Where Quarter = 3
GROUP BY County 
ORDER BY "Rank"

/* Bonus */
SELECT *
FROM
	(SELECT House_Number "House Number", Street_Name AS "Street Name",  COUNT(Summons_Key) AS "Number Of Tickets Issued",
		RANK() OVER (ORDER BY  COUNT(Summons_Key) DESC) AS "Rank"
	FROM
		[dbo].[Fact_Parking_Tickets]
		JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	WHERE House_Number not like ''
	GROUP BY House_Number, Street_Name) AS House_Street
WHERE "Rank" <= 10
ORDER BY "Rank"

/* Rollup with Time dimension */
SELECT Year, Quarter, Month, COUNT(Summons_Key) AS "Number Of Tickets Issued"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
GROUP BY Year, Quarter, Month WITH ROLLUP;