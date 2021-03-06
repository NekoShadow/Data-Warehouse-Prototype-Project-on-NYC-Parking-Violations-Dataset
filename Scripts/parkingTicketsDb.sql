USE [Group_9_DB]
GO
/****** Object:  Table [dbo].[ParkingTicketsDB]    Script Date: 2/12/2018 8:09:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParkingTicketsDB](
	[Summons_Number] [int] NOT NULL,
	[Plate_ID] [nvarchar](50) NULL,
	[Registration_State] [nvarchar](50) NULL,
	[Plate_Type] [nvarchar](50) NULL,
	[Issue_Date] [nvarchar](10) NULL,
	[Violation_Code] [int] NULL,
	[Vehicle_Body_Type] [nvarchar](50) NULL,
	[Vehicle_Make] [nvarchar](50) NULL,
	[Issuing_Agency] [nvarchar](50) NULL,
	[Street_Code1] [int] NULL,
	[Street_Code2] [int] NULL,
	[Street_Code3] [int] NULL,
	[Vehicle_Expiration_Date] [nvarchar](10) NULL,
	[Violation_Location] [int] NULL,
	[Violation_Precinct] [int] NULL,
	[Issuer_Precinct] [int] NULL,
	[Issuer_Code] [int] NULL,
	[Issuer_Command] [nvarchar](50) NULL,
	[Issuer_Squad] [int] NULL,
	[Violation_Time] [nvarchar](50) NULL,
	[Time_First_Observed] [nvarchar](50) NULL,
	[Violation_County] [nvarchar](50) NULL,
	[Violation_In_Front_Of_Or_Opposite] [nvarchar](50) NULL,
	[House_Number] [nvarchar](50) NULL,
	[Street_Name] [nvarchar](50) NULL,
	[Intersecting_Street] [nvarchar](50) NULL,
	[Date_First_Observed] [int] NULL,
	[Law_Section] [int] NULL,
	[Sub_Division] [nvarchar](50) NULL,
	[Violation_Legal_Code] [nvarchar](1) NULL,
	[Days_Parking_In_Effect] [nvarchar](50) NULL,
	[From_Hours_In_Effect] [nvarchar](50) NULL,
	[To_Hours_In_Effect] [nvarchar](50) NULL,
	[Vehicle_Color] [nvarchar](50) NULL,
	[Unregistered_Vehicle] [int] NULL,
	[Vehicle_Year] [int] NULL,
	[Meter_Number] [nvarchar](50) NULL,
	[Feet_From_Curb] [int] NULL,
	[Violation_Post_Code] [nvarchar](1) NULL,
	[Violation_Description] [nvarchar](1) NULL,
	[No_Standing_or_Stopping_Violation] [nvarchar](1) NULL,
	[Hydrant_Violation] [nvarchar](1) NULL,
	[Double_Parking_Violation] [nvarchar](1) NULL,
 CONSTRAINT [PK_ParkingTicketsDB] PRIMARY KEY CLUSTERED 
(
	[Summons_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
