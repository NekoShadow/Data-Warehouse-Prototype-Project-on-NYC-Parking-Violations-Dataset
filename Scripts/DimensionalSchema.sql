USE [Group_9_DB]
GO
/****** Object:  Table [dbo].[Dim_Car]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Car](
	[Car_Key] [int] IDENTITY(1,1) NOT NULL,
	[Body_Type] [varchar](10) NOT NULL,
	[Plate_Type] [varchar](5) NOT NULL,
	[Reg_State] [varchar](5) NOT NULL,
	[Color] [varchar](10) NOT NULL,
	[Vehicle_Year] [int] NOT NULL,
	[Vehicle_Make] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Dim_Car] PRIMARY KEY CLUSTERED 
(
	[Car_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Date]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Date](
	[Date_Key] [int] IDENTITY(1,1) NOT NULL,
	[Full_Date_Descr] [date] NOT NULL,
	[Year] [int] NOT NULL,
	[Month_Name] [varchar](10) NOT NULL,
	[Month] [int] NOT NULL,
	[Day_In_Year] [int] NOT NULL,
	[Day_In_Month] [int] NOT NULL,
	[Day_In_Week_Name] [varchar](10) NOT NULL,
	[Day_In_Week] [int] NOT NULL,
	[Weekend_Indicator] [int] NOT NULL,
	[Holiday_Indicator] [int] NOT NULL,
	[Fiscal_Year] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[Season] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Dim_Date] PRIMARY KEY CLUSTERED 
(
	[Date_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Issuer]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Issuer](
	[Issuer_Key] [int] IDENTITY(1,1) NOT NULL,
	[Issuer_Code] [int] NOT NULL,
	[Issuer_Precinct] [int] NOT NULL,
	[Issuing_Agency] [varchar](5) NOT NULL,
	[Issuer_Command] [varchar](10) NOT NULL,
	[Active_Ind] [int] NOT NULL,
	[Eff_Start_Date] [date] NOT NULL,
	[Eff_End_Date] [date] NULL,
 CONSTRAINT [PK_Dim_Issuer] PRIMARY KEY CLUSTERED 
(
	[Issuer_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Location]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Location](
	[Location_Key] [int] IDENTITY(1,1) NOT NULL,
	[Location_ID] [int] NOT NULL,
	[Violation_Location] [int] NOT NULL,
	[County] [varchar](50) NOT NULL,
	[Intersecting_Street] [varchar](50) NOT NULL,
	[Street_Name] [varchar](50) NOT NULL,
	[Precinct] [int] NOT NULL,
	[Active_Ind] [int] NOT NULL,
	[Eff_Start_Date] [date] NOT NULL,
	[Eff_End_Date] [date] NULL,
 CONSTRAINT [PK_Dim_Location] PRIMARY KEY CLUSTERED 
(
	[Location_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dim_Time]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dim_Time](
	[Time_Key] [int] IDENTITY(1,1) NOT NULL,
	[Time] [time](0) NOT NULL,
	[Hour_12] [int] NOT NULL,
	[Hour_24] [int] NOT NULL,
	[AM_PM] [varchar](2) NOT NULL,
	[Minute] [int] NOT NULL,
	[Morning_Rush_Hours] [int] NOT NULL,
	[Lunch_Time] [int] NOT NULL,
	[Evening_Rush_Hours] [int] NOT NULL,
	[Off_Hours] [int] NOT NULL,
 CONSTRAINT [PK_Dim_Time] PRIMARY KEY CLUSTERED 
(
	[Time_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fact_Parking_Tickets]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fact_Parking_Tickets](
	[Summons_Key] [int] NOT NULL,
	[Time_Key] [int] NOT NULL,
	[Date_Key] [int] NOT NULL,
	[Location_Key] [int] NOT NULL,
	[Issuer_Key] [int] NOT NULL,
	[Car_Key] [int] NOT NULL,
	[Violation_Code] [int] NOT NULL,
	[Ticket_Price] [int] NOT NULL,
	[Plate_ID] [varchar](10) NOT NULL,
	[House_Number] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Fact_Parking_Tickets] PRIMARY KEY CLUSTERED 
(
	[Summons_Key] ASC,
	[Time_Key] ASC,
	[Date_Key] ASC,
	[Location_Key] ASC,
	[Issuer_Key] ASC,
	[Car_Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Temp_Ticket]    Script Date: 2/25/2018 12:24:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Temp_Ticket](
	[Summons.id] [int] NULL,
	[Violation Time] [time](0) NULL,
	[Issue Date] [date] NULL,
	[Issuer Code] [int] NULL,
	[Vehicle body Type] [varchar](10) NULL,
	[Plate Type] [varchar](5) NULL,
	[Registration State] [varchar](5) NULL,
	[Vehicle Color] [varchar](50) NULL,
	[Vehicle Year] [int] NULL,
	[Vehicle Make] [varchar](50) NULL,
	[Violation Code] [int] NULL,
	[Plate ID] [varchar](10) NULL,
	[House Number] [varchar](50) NULL,
	[ticket price] [int] NULL,
	[Location ID] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Dim_Issuer] ADD  CONSTRAINT [DF_Dim_Issuer_Active_Ind]  DEFAULT ((1)) FOR [Active_Ind]
GO
ALTER TABLE [dbo].[Dim_Issuer] ADD  CONSTRAINT [DF_Dim_Issuer_Eff_Start_Date]  DEFAULT (getdate()) FOR [Eff_Start_Date]
GO
ALTER TABLE [dbo].[Dim_Location] ADD  CONSTRAINT [DF_Dim_Location_Eff_Start_Date]  DEFAULT (getdate()) FOR [Eff_Start_Date]
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Car] FOREIGN KEY([Car_Key])
REFERENCES [dbo].[Dim_Car] ([Car_Key])
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets] CHECK CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Car]
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Date] FOREIGN KEY([Date_Key])
REFERENCES [dbo].[Dim_Date] ([Date_Key])
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets] CHECK CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Date]
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Issuer] FOREIGN KEY([Issuer_Key])
REFERENCES [dbo].[Dim_Issuer] ([Issuer_Key])
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets] CHECK CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Issuer]
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Location] FOREIGN KEY([Location_Key])
REFERENCES [dbo].[Dim_Location] ([Location_Key])
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets] CHECK CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Location]
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Time] FOREIGN KEY([Time_Key])
REFERENCES [dbo].[Dim_Time] ([Time_Key])
GO
ALTER TABLE [dbo].[Fact_Parking_Tickets] CHECK CONSTRAINT [FK_Parking_Vio_Tikt_Dim_Time]
GO
