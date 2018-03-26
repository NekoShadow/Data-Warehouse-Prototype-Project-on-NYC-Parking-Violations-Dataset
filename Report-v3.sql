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
/* Rollup with Time dimension */
SELECT Year, Quarter, Month, COUNT(Summons_Key) AS "Number Of Tickets Issued"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
GROUP BY Year, Quarter, Month WITH ROLLUP;

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

/* Revenue Per Street By County*/
SELECT County, Sum(Ticket_Price) AS "Total Ticket Amount", COUNT(DISTINCT Street_Name) AS "Number of Streets",
	Sum(Ticket_Price)/COUNT(DISTINCT Street_Name) AS "Revenue Per Street",
	Rank() OVER (ORDER BY Sum(Ticket_Price)/COUNT(DISTINCT Street_Name) DESC) AS Rank
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
GROUP BY County;


/* Revenue difference in Brooklyn if ticket prices increased by $10 */
SELECT Year, Quarter, Month,  SUM(Ticket_Price) AS "Current Revenue", SUM(Ticket_Price + 10) AS "Revenue if Ticket Price increased by 10%",
	SUM(Ticket_Price + 10) - SUM(Ticket_Price) AS "Increase in Revenue"
FROM
	[dbo].[Fact_Parking_Tickets]
	JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
	JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
WHERE County like 'BROOKLYN'
GROUP BY Year, Quarter, Month WITH ROLLUP;

/* The most frequent violation type in each season */
SELECT Season, Violation_Code
FROM
	(SELECT Season, Violation_Code,
		Row_Number() OVER (PARTITION BY Season ORDER BY COUNT(Violation_Code) DESC) AS Rank
	FROM
		[dbo].[Fact_Parking_Tickets]
		JOIN [dbo].[Dim_Location] on [dbo].[Dim_Location].[Location_Key] = [dbo].[Fact_Parking_Tickets].[Location_Key]
		JOIN [dbo].[Dim_Car] ON [dbo].[Fact_Parking_Tickets].Car_Key = [dbo].[Dim_Car].[Car_Key]
		JOIN [dbo].[Dim_Issuer] ON [dbo].[Dim_Issuer].Issuer_Key = [dbo].[Fact_Parking_Tickets].Issuer_Key
		JOIN [dbo].[Dim_Date] ON [dbo].[Dim_Date].Date_Key = [dbo].[Fact_Parking_Tickets].Date_Key
		JOIN [dbo].[Dim_Time] ON [dbo].[Dim_Time].Time_Key = [dbo].[Fact_Parking_Tickets].Time_Key
	GROUP BY Season, Violation_Code) AS Inner_query
WHERE Rank = 1;