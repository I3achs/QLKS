USE [HotelManagement]
GO
/****** Object:  UserDefinedFunction [dbo].[ConvertString]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ConvertString] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO
/****** Object:  Table [dbo].[ACCESS]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCESS](
	[IDStaffType] [int] NOT NULL,
	[IDJob] [int] NOT NULL,
 CONSTRAINT [PK_Access] PRIMARY KEY CLUSTERED 
(
	[IDStaffType] ASC,
	[IDJob] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDReceiveRoom] [int] NOT NULL,
	[StaffSetUp] [nvarchar](100) NOT NULL,
	[DateOfCreate] [smalldatetime] NULL,
	[RoomPrice] [int] NOT NULL,
	[ServicePrice] [int] NOT NULL,
	[TotalPrice] [int] NOT NULL,
	[Discount] [int] NOT NULL,
	[IDStatusBill] [int] NOT NULL,
	[Surcharge] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillDetails]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDetails](
	[IDBill] [int] NOT NULL,
	[IDService] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[TotalPrice] [int] NOT NULL,
 CONSTRAINT [PK_BillInfo] PRIMARY KEY CLUSTERED 
(
	[IDService] ASC,
	[IDBill] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookRoom]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookRoom](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDCustomer] [int] NOT NULL,
	[IDRoomType] [int] NOT NULL,
	[DateBookRoom] [smalldatetime] NOT NULL,
	[DateCheckIn] [date] NOT NULL,
	[DateCheckOut] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDCard] [nvarchar](100) NOT NULL,
	[IDCustomerType] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[PhoneNumber] [int] NOT NULL,
	[Sex] [nvarchar](100) NOT NULL,
	[Nationality] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerType]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JOB]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOB](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[NameForm] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parameter]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parameter](
	[Name] [nvarchar](100) NOT NULL,
	[Value] [float] NULL,
	[Describe] [nvarchar](200) NULL,
	[DateModify] [smalldatetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceiveRoom]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiveRoom](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDBookRoom] [int] NOT NULL,
	[IDRoom] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReceiveRoomDetails]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReceiveRoomDetails](
	[IDReceiveRoom] [int] NOT NULL,
	[IDCustomerOther] [int] NOT NULL,
 CONSTRAINT [PK_ReceiveRoomDetails] PRIMARY KEY CLUSTERED 
(
	[IDReceiveRoom] ASC,
	[IDCustomerOther] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REPORT]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REPORT](
	[idRoomType] [int] NOT NULL,
	[value] [int] NOT NULL,
	[rate] [float] NOT NULL,
	[Month] [int] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED 
(
	[idRoomType] ASC,
	[Month] ASC,
	[Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IDRoomType] [int] NOT NULL,
	[IDStatusRoom] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomType]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Price] [int] NOT NULL,
	[LimitPerson] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Service]    Script Date: 6/25/2018 2:42:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Service](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[IDServiceType] [int] NOT NULL,
	[Price] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[UserName] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[PassWord] [nvarchar](100) NOT NULL,
	[IDStaffType] [int] NOT NULL,
	[IDCard] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Sex] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[PhoneNumber] [int] NOT NULL,
	[StartDay] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusBill]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusBill](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusRoom](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 1)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 2)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 3)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 4)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 5)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 6)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 7)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 8)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 9)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (1, 10)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 1)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 2)
INSERT [dbo].[ACCESS] ([IDStaffType], [IDJob]) VALUES (2, 3)
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3017, 3018, N'admin', CAST(N'2018-06-24T18:34:00' AS SmallDateTime), 5000000, 0, 7500000, 0, 2, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3018, 3016, N'admin', CAST(N'2018-06-24T18:34:00' AS SmallDateTime), 40000000, 0, 60000000, 10, 2, 20000000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3019, 3017, N'admin', CAST(N'2018-06-24T18:17:00' AS SmallDateTime), 4000000, 0, 0, 0, 1, 2000000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3020, 3019, N'admin', CAST(N'2018-06-24T18:45:00' AS SmallDateTime), 4000000, 1500000, 7500000, 1, 2, 2000000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3021, 3016, N'admin', CAST(N'2018-06-24T18:42:00' AS SmallDateTime), 40000000, 0, 0, 0, 1, 20000000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3022, 3018, N'admin', CAST(N'2018-06-24T18:42:00' AS SmallDateTime), 5000000, 0, 0, 0, 1, 2500000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3023, 3019, N'admin', CAST(N'2018-06-25T01:56:00' AS SmallDateTime), 4000000, 3000000, 10000000, 2, 2, 3000000)
INSERT [dbo].[Bill] ([ID], [IDReceiveRoom], [StaffSetUp], [DateOfCreate], [RoomPrice], [ServicePrice], [TotalPrice], [Discount], [IDStatusBill], [Surcharge]) VALUES (3024, 3021, N'admin', CAST(N'2018-06-25T02:29:00' AS SmallDateTime), 8000000, 125000, 8125000, 5, 2, 0)
SET IDENTITY_INSERT [dbo].[Bill] OFF
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3020, 1, 1, 1000000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3023, 1, 1, 1000000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3020, 2, 1, 100000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3020, 3, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3020, 8, 1, 200000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3023, 16, 1, 2000000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3024, 20, 1, 75000)
INSERT [dbo].[BillDetails] ([IDBill], [IDService], [Count], [TotalPrice]) VALUES (3024, 21, 1, 50000)
SET IDENTITY_INSERT [dbo].[BookRoom] ON 

INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3020, 4, 1, CAST(N'2018-06-24T18:12:00' AS SmallDateTime), CAST(N'2018-06-24' AS Date), CAST(N'2018-06-28' AS Date))
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3021, 10, 1, CAST(N'2018-06-24T18:13:00' AS SmallDateTime), CAST(N'2018-06-24' AS Date), CAST(N'2018-06-25' AS Date))
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3022, 1, 1, CAST(N'2018-06-24T18:14:00' AS SmallDateTime), CAST(N'2018-06-25' AS Date), CAST(N'2018-06-28' AS Date))
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3023, 5, 4, CAST(N'2018-06-24T18:15:00' AS SmallDateTime), CAST(N'2018-06-24' AS Date), CAST(N'2018-06-29' AS Date))
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3024, 11, 4, CAST(N'2018-06-24T18:38:00' AS SmallDateTime), CAST(N'2018-06-24' AS Date), CAST(N'2018-06-28' AS Date))
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3025, 14, 3, CAST(N'2018-06-25T01:54:00' AS SmallDateTime), CAST(N'2018-06-25' AS Date), CAST(N'2018-06-27' AS Date))
INSERT [dbo].[BookRoom] ([ID], [IDCustomer], [IDRoomType], [DateBookRoom], [DateCheckIn], [DateCheckOut]) VALUES (3026, 15, 3, CAST(N'2018-06-25T02:27:00' AS SmallDateTime), CAST(N'2018-06-25' AS Date), CAST(N'2018-06-27' AS Date))
SET IDENTITY_INSERT [dbo].[BookRoom] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (1, N'16520147', 1, N'Nguyễn Duy Cương', CAST(N'1998-04-06' AS Date), N'New York', 1648222347, N'Nam', N'Việt Nam')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (2, N'206117926', 3, N'Nguyễn Duy Cương', CAST(N'1998-04-06' AS Date), N'Quảng Nam', 1648222347, N'Nam', N'Singapore')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (4, N'123456', 2, N'Nguyen Duy Cuong', CAST(N'1998-04-06' AS Date), N'Tam Kỳ', 1648222347, N'Nam', N'Trung Quốc')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (5, N'12782389', 1, N'Vi Chí Thiện', CAST(N'1998-04-06' AS Date), N'Đồng Nai', 12782389, N'Nam', N'Nhật Bản')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (8, N'2563', 1, N'Triết', CAST(N'1998-04-06' AS Date), N'Quảng ngãi', 147852, N'Nữ', N'Việt Nam')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (9, N'123456788', 1, N'Nguyễn Văn Thịnh', CAST(N'1998-07-08' AS Date), N'Tam Kỳ,  Quảng Nam', 123456789, N'Nam', N'Việt Nam')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (10, N'123456787', 1, N'Nguyễn Trần Duy Cương', CAST(N'1998-04-06' AS Date), N'Tam Kỳ', 123456785, N'Nam', N'Hoa Kỳ')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (11, N'27263950', 4, N'Vi Chí Thiện', CAST(N'1998-06-06' AS Date), N'Đồng Nai', 966144938, N'Nam', N'Trung Quốc')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (12, N'145236', 1, N'Lâm Ngọc Lan', CAST(N'1998-04-06' AS Date), N'Thái bình', 1655201124, N'Nữ', N'Việt Nam')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (13, N'96852361', 3, N'Nguyễn Ngọc Dung', CAST(N'1998-04-06' AS Date), N'Đồng nai', 145230, N'Nữ', N'Việt Nam')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (14, N'123458523', 1, N'Nguyễn Văn Anh', CAST(N'1998-04-06' AS Date), N'Hồ Chí Minh', 123452367, N'Nam', N'Việt Nam')
INSERT [dbo].[Customer] ([ID], [IDCard], [IDCustomerType], [Name], [DateOfBirth], [Address], [PhoneNumber], [Sex], [Nationality]) VALUES (15, N'963587', 3, N'Nguyễn Duy', CAST(N'1998-04-08' AS Date), N'Hà Nội', 164853564, N'Nam', N'Việt Nam')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[CustomerType] ON 

INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (1, N'Khách du lịch')
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (2, N'Khách vãng lai')
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (3, N'Khách địa phương')
INSERT [dbo].[CustomerType] ([ID], [Name]) VALUES (4, N'Khách đi qua các tổ chức trung gian')
SET IDENTITY_INSERT [dbo].[CustomerType] OFF
SET IDENTITY_INSERT [dbo].[JOB] ON 

INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (1, N'Đặt Phòng', N'fBookRoom')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (2, N'Nhận Phòng', N'fReceiveRoom')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (3, N'Sử dụng dịch vụ và Thanh toán', N'fUseService')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (4, N'Thống kê và doanh thu', N'fReport')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (5, N'Quản lí phòng', N'fRoom')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (6, N'Quản lí nhân viên', N'fStaff')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (7, N'Quản lí khách hàng', N'fCustomer')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (8, N'Quản lí hoá đơn', N'fBill')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (9, N'Quản lí dịch vụ', N'fService')
INSERT [dbo].[JOB] ([ID], [Name], [NameForm]) VALUES (10, N'Quy định', N'fParameter')
SET IDENTITY_INSERT [dbo].[JOB] OFF
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.1', 9, N'Phòng Suite (SUT) có tối đa 9 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.2', 6, N'Phòng Deluxe (DLX) có tối đa 6 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.3', 4, N'Phòng Superior (SUP) có tối đa 4 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ1.4', 3, N'Phòng Standard (STD) có tối đa 3 người', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.1', 6, N'Đơn giá phòng cho 6 khách Phòng Suite (SUT)', CAST(N'2018-06-25T02:02:00' AS SmallDateTime))
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.2', 4, N'Đơn giá phòng cho 4 khách Phòng Deluxe (DLX)', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.3', 3, N'Đơn giá phòng cho 3 khách Phòng Superior (SUP)', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ2.4', 2, N'Đơn giá phòng cho 2 khách Phòng Phòng Standard (STD)', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ3', 0.25, N'Mỗi khách hàng vượt số lượng tiêu chuẩn phụ thu thêm 0.25', NULL)
INSERT [dbo].[Parameter] ([Name], [Value], [Describe], [DateModify]) VALUES (N'QĐ4', 1.5, N'Khách nước ngoài phụ thu 1.5', CAST(N'2018-06-24T18:29:00' AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[ReceiveRoom] ON 

INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3016, 3020, 17)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3017, 3021, 11)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3018, 3023, 20)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3019, 3024, 8)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3020, 3025, 10)
INSERT [dbo].[ReceiveRoom] ([ID], [IDBookRoom], [IDRoom]) VALUES (3021, 3026, 24)
SET IDENTITY_INSERT [dbo].[ReceiveRoom] OFF
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (3018, 4)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (3018, 10)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (3019, 12)
INSERT [dbo].[ReceiveRoomDetails] ([IDReceiveRoom], [IDCustomerOther]) VALUES (3019, 13)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (1, 60000000, 64.43, 6, 2018)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (2, 0, 0, 6, 2018)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (3, 8125000, 8.72, 6, 2018)
INSERT [dbo].[REPORT] ([idRoomType], [value], [rate], [Month], [Year]) VALUES (4, 25000000, 26.85, 6, 2018)
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (1, N'Phòng 101', 1, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (2, N'Phòng 102', 2, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (3, N'Phòng 103', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (4, N'Phòng 104', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (5, N'Phòng 105', 1, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (6, N'Phòng 106', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (7, N'Phòng 107', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (8, N'Phòng 108', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (9, N'Phòng 109', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (10, N'Phòng 201', 3, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (11, N'Phòng 202', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (12, N'Phòng 203', 2, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (13, N'Phòng 204', 2, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (14, N'Phòng 205', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (15, N'Phòng 206', 3, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (16, N'Phòng 207', 2, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (17, N'Phòng 208', 1, 2)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (18, N'Phòng 209', 2, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (19, N'Phòng 210', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (20, N'Phòng 211', 4, 1)
INSERT [dbo].[Room] ([ID], [Name], [IDRoomType], [IDStatusRoom]) VALUES (24, N'Phòng 212', 3, 1)
SET IDENTITY_INSERT [dbo].[Room] OFF
SET IDENTITY_INSERT [dbo].[RoomType] ON 

INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (1, N'Phòng Suite (SUT)', 10000000, 6)
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (2, N'Phòng Deluxe (DLX)', 7000000, 4)
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (3, N'Phòng Superior (SUP)', 4000000, 3)
INSERT [dbo].[RoomType] ([ID], [Name], [Price], [LimitPerson]) VALUES (4, N'Phòng Standard (STD)', 1000000, 2)
SET IDENTITY_INSERT [dbo].[RoomType] OFF
SET IDENTITY_INSERT [dbo].[Service] ON 

INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (1, N'Spa', 2, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (2, N'Fitness', 2, 100000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (3, N'Tam dương trùng phùng với bông cải uyên ương', 1, 200000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (4, N'Karaoke', 2, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (6, N'Giặt ủi quần áo', 3, 150000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (8, N'Dịch vụ xe đưa đón sân bay', 3, 200000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (9, N'Dịch vụ cho thuê tự lái', 3, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (10, N'Dịch vụ trông trẻ', 3, 800000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (11, N'Bể bơi 4 mùa', 2, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (13, N'Sân tennis', 2, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (14, N'Mực khoanh chiên vàng & Gỏi bắp bò rau mùi với bánh tráng mè kiểu Thái & Phượng Hoàng tảo biển', 1, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (15, N'Súp nấm hải vị với gà và thịt cua', 1, 200000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (16, N'Heo sữa quay bánh bao nửa con', 1, 2000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (17, N'Chè bột báng trái cây kiểu Melaka', 1, 50000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (18, N'Gỏi bò Cung đình & Phượng hoàng tảo biển & Sườn heo nướng kiểu Hàn Quốc', 1, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (19, N'Súp kem bắp hải sản kiểu Pháp', 1, 150000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (20, N'Cơm chiên gà cá mặn kiểu Hongkong', 1, 75000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (21, N'Bánh tiramisu socola', 1, 50000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (22, N'Chivas 18', 4, 1800000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (23, N'Vodka 3 Zoka', 4, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (24, N'Chivas 12', 4, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (25, N'Cocktail Negroni', 4, 300000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (26, N'Cocktail Bellini', 4, 300000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (27, N'Cocktail The Bloody Mary', 4, 500000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (28, N'Cocktail Old Fashioned', 4, 400000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (29, N'Lẩu dê', 1, 100000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (30, N'Vịt quay Bắc Kinh', 1, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (31, N'Lẩu hải sản', 1, 1000000)
INSERT [dbo].[Service] ([ID], [Name], [IDServiceType], [Price]) VALUES (32, N'Cháo vịt', 1, 200000)
SET IDENTITY_INSERT [dbo].[Service] OFF
SET IDENTITY_INSERT [dbo].[ServiceType] ON 

INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (1, N'Ăn uống')
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (2, N'Giải trí')
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (3, N'Tiện ích')
INSERT [dbo].[ServiceType] ([ID], [Name]) VALUES (4, N'Đồ uống')
SET IDENTITY_INSERT [dbo].[ServiceType] OFF
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'admin', N'Nguyễn Văn Thiện', N'e10adc3949ba59abbe56e057f20f883e', 1, N'123457145', CAST(N'1991-04-18' AS Date), N'Nam', N'Hà Nội', 147852, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'meo', N'meo', N'e10adc3949ba59abbe56e057f20f883e', 1, N'2712', CAST(N'1998-04-06' AS Date), N'Nam', N'Dong Nai', 123456789, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'meomeo', N'meomeo', N'14e1b600b1fd579f47433b88e8d85291', 1, N'16521169', CAST(N'1990-01-01' AS Date), N'Nam', N'Dong Nai', 123456789, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'ndc', N'Nguyễn Duy Cương', N'e10adc3949ba59abbe56e057f20f883e', 2, N'206117926', CAST(N'1990-01-01' AS Date), N'Nữ', N'Tam Kỳ, Quảng Nam', 1648222347, CAST(N'2018-05-16' AS Date))
INSERT [dbo].[Staff] ([UserName], [DisplayName], [PassWord], [IDStaffType], [IDCard], [DateOfBirth], [Sex], [Address], [PhoneNumber], [StartDay]) VALUES (N'ndc07', N'Nguyễn Duy Cương', N'c4ca4238a0b923820dcc509a6f75849b', 1, N'123456789', CAST(N'1998-04-06' AS Date), N'Nam', N'Tam Ky', 1648222347, CAST(N'2018-05-16' AS Date))
SET IDENTITY_INSERT [dbo].[StaffType] ON 

INSERT [dbo].[StaffType] ([ID], [Name]) VALUES (1, N'Quản lí')
INSERT [dbo].[StaffType] ([ID], [Name]) VALUES (2, N'Lễ tân')
SET IDENTITY_INSERT [dbo].[StaffType] OFF
SET IDENTITY_INSERT [dbo].[StatusBill] ON 

INSERT [dbo].[StatusBill] ([ID], [Name]) VALUES (1, N'Chưa thanh toán')
INSERT [dbo].[StatusBill] ([ID], [Name]) VALUES (2, N'Đã thanh toán')
SET IDENTITY_INSERT [dbo].[StatusBill] OFF
SET IDENTITY_INSERT [dbo].[StatusRoom] ON 

INSERT [dbo].[StatusRoom] ([ID], [Name]) VALUES (1, N'Trống')
INSERT [dbo].[StatusRoom] ([ID], [Name]) VALUES (2, N'Có người')
SET IDENTITY_INSERT [dbo].[StatusRoom] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__43A2A4E36DFC81EC]    Script Date: 6/25/2018 2:42:22 AM ******/
ALTER TABLE [dbo].[Customer] ADD UNIQUE NONCLUSTERED 
(
	[IDCard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Paramete__737584F67E61460B]    Script Date: 6/25/2018 2:42:22 AM ******/
ALTER TABLE [dbo].[Parameter] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Staff__43A2A4E334CCD277]    Script Date: 6/25/2018 2:42:22 AM ******/
ALTER TABLE [dbo].[Staff] ADD UNIQUE NONCLUSTERED 
(
	[IDCard] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT (getdate()) FOR [DateOfCreate]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [RoomPrice]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [ServicePrice]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF__Bill__IDStatusBi__1DB06A4F]  DEFAULT ((1)) FOR [IDStatusBill]
GO
ALTER TABLE [dbo].[Bill] ADD  DEFAULT ((0)) FOR [Surcharge]
GO
ALTER TABLE [dbo].[BillDetails] ADD  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[Customer] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[CustomerType] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[Parameter] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[Parameter] ADD  DEFAULT (getdate()) FOR [DateModify]
GO
ALTER TABLE [dbo].[REPORT] ADD  DEFAULT ((0)) FOR [value]
GO
ALTER TABLE [dbo].[REPORT] ADD  DEFAULT ((0)) FOR [rate]
GO
ALTER TABLE [dbo].[REPORT] ADD  DEFAULT ((1)) FOR [Month]
GO
ALTER TABLE [dbo].[REPORT] ADD  DEFAULT ((1990)) FOR [Year]
GO
ALTER TABLE [dbo].[Room] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[RoomType] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[Service] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[ServiceType] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[Staff] ADD  DEFAULT (N'No Name') FOR [DisplayName]
GO
ALTER TABLE [dbo].[StaffType] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[StatusBill] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[StatusRoom] ADD  DEFAULT (N'No Name') FOR [Name]
GO
ALTER TABLE [dbo].[ACCESS]  WITH CHECK ADD FOREIGN KEY([IDJob])
REFERENCES [dbo].[JOB] ([ID])
GO
ALTER TABLE [dbo].[ACCESS]  WITH CHECK ADD FOREIGN KEY([IDStaffType])
REFERENCES [dbo].[StaffType] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IDReceiveRoom])
REFERENCES [dbo].[ReceiveRoom] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([IDStatusBill])
REFERENCES [dbo].[StatusBill] ([ID])
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD FOREIGN KEY([StaffSetUp])
REFERENCES [dbo].[Staff] ([UserName])
GO
ALTER TABLE [dbo].[BillDetails]  WITH CHECK ADD FOREIGN KEY([IDBill])
REFERENCES [dbo].[Bill] ([ID])
GO
ALTER TABLE [dbo].[BillDetails]  WITH CHECK ADD FOREIGN KEY([IDService])
REFERENCES [dbo].[Service] ([ID])
GO
ALTER TABLE [dbo].[BookRoom]  WITH CHECK ADD FOREIGN KEY([IDCustomer])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[BookRoom]  WITH CHECK ADD FOREIGN KEY([IDRoomType])
REFERENCES [dbo].[RoomType] ([ID])
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD FOREIGN KEY([IDCustomerType])
REFERENCES [dbo].[CustomerType] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoom]  WITH CHECK ADD FOREIGN KEY([IDBookRoom])
REFERENCES [dbo].[BookRoom] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoom]  WITH CHECK ADD FOREIGN KEY([IDRoom])
REFERENCES [dbo].[Room] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoomDetails]  WITH CHECK ADD FOREIGN KEY([IDCustomerOther])
REFERENCES [dbo].[Customer] ([ID])
GO
ALTER TABLE [dbo].[ReceiveRoomDetails]  WITH CHECK ADD FOREIGN KEY([IDReceiveRoom])
REFERENCES [dbo].[ReceiveRoom] ([ID])
GO
ALTER TABLE [dbo].[REPORT]  WITH CHECK ADD FOREIGN KEY([idRoomType])
REFERENCES [dbo].[RoomType] ([ID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([IDRoomType])
REFERENCES [dbo].[RoomType] ([ID])
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD FOREIGN KEY([IDStatusRoom])
REFERENCES [dbo].[StatusRoom] ([ID])
GO
ALTER TABLE [dbo].[Service]  WITH CHECK ADD FOREIGN KEY([IDServiceType])
REFERENCES [dbo].[ServiceType] ([ID])
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD FOREIGN KEY([IDStaffType])
REFERENCES [dbo].[StaffType] ([ID])
GO
/****** Object:  StoredProcedure [dbo].[GetIDReceiveRoomCurrent]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetIDReceiveRoomCurrent]
as
begin
	select MAX(id)
	from ReceiveRoom
end
GO
/****** Object:  StoredProcedure [dbo].[InsertReceiveRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[InsertReceiveRoom]
@idBookRoom int,@idRoom int
as
begin
	insert into ReceiveRoom(IDBookRoom,IDRoom)
	values(@idBookRoom,@idRoom)
	update Room
	set IDStatusRoom=2
	where ID=@idRoom
end
GO
/****** Object:  StoredProcedure [dbo].[InsertReceiveRoomDetails]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InsertReceiveRoomDetails]
@idReceiveRoom int,@idCustomer int
as
begin
	insert into ReceiveRoomDetails(IDReceiveRoom,IDCustomerOther)
	values(@idReceiveRoom,@idCustomer)
end
GO
/****** Object:  StoredProcedure [dbo].[ShowBookRoomInfo]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ShowBookRoomInfo]
@idBookRoom int
as
begin
	select B.Name[FullName],B.IDCard[IDCard],C.Name[RoomTypeName],A.DateCheckIn[DateCheckIn],A.DateCheckOut[DateCheckOut],C.LimitPerson[LimitPerson],C.Price[Price]
	from BookRoom A,Customer B,RoomType C
	where A.ID=@idBookRoom and A.IDCustomer=B.ID and A.IDRoomType=C.ID
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ChekcAccess]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_ChekcAccess] 
@username NVARCHAR(100), @formname NVARCHAR(100)
AS
BEGIN
	SELECT UserName FROM dbo.Staff INNER JOIN dbo.StaffType ON StaffType.ID = Staff.IDStaffType 
	INNER JOIN access ON access.Idstafftype = stafftype.ID INNER JOIN job ON job.id = access.idjob
	WHERE UserName = @username AND @formname LIKE NameForm
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteAccess]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteAccess]
@idJob INT, @idStaffType int
AS
BEGIN
	DELETE access WHERE @idJob = idjob AND @idStaffType = idStaffType
END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteBookRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_DeleteBookRoom]
@id int
as
begin
	delete from BookRoom
	where ID=@id
end
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteReceiveRoomDetails]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_DeleteReceiveRoomDetails]
@idReceiveRoom int,@idCustomer int
as
begin
	delete from ReceiveRoomDetails
	where IDCustomerOther=@idCustomer and IDReceiveRoom=@idReceiveRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_DeleteStaffType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_DeleteStaffType]
@id int
AS
begin
	DECLARE @count int = 0
	SELECT @count = COUNT(*) FROM staff WHERE @id = staff.IDStaffType
	IF(@count = 0)
	begin
		delete access where idstafftype = @id
		DELETE staffType WHERE @id = id
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetCustomerTypeNameByIdCard]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetCustomerTypeNameByIdCard]
@idCard nvarchar(100)
as
begin
	select B.Name
	from Customer A, CustomerType B
	where A.IDCustomerType=B.ID and A.IDCard=@idCard
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetIdBillFromIdRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetIdBillFromIdRoom]
@idRoom int
as
begin
	select B.*
	from ReceiveRoom A,Bill B
	where A.ID=B.IDReceiveRoom and B.IDStatusBill=1 and A.IDRoom=@idRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetIdBillMax]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetIdBillMax]
as
select MAX(id)
from Bill
GO
/****** Object:  StoredProcedure [dbo].[USP_GetIDCustomerFromBookRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetIDCustomerFromBookRoom]
@idReceiveRoom int
as
begin
	select B.IDCustomer
	from ReceiveRoom A,BookRoom B
	where A.ID=@idReceiveRoom and A.IDBookRoom=B.ID
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetIdReceiRoomFromIdRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_GetIdReceiRoomFromIdRoom]--IdRoom đưa vào có trạng thái "Có người"
@idRoom int
as
begin
select *
from ReceiveRoom
where IDRoom=@idRoom
order by ID desc
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetIDRoomFromReceiveRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetIDRoomFromReceiveRoom]
@idReceiveRoom int
as
begin
	select IDRoom
	from ReceiveRoom
	where ID=@idReceiveRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetMaxPersonByRoomType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetMaxPersonByRoomType]
@idRoomType int
as
begin
	if(@idRoomType=1)
	select *
	from Parameter
	where Name=N'QĐ1.1'

	if(@idRoomType=2)
	select *
	from Parameter
	where Name=N'QĐ1.2'

	if(@idRoomType=3)
	select *
	from Parameter
	where Name=N'QĐ1.3'

	if(@idRoomType=4)
	select *
	from Parameter
	where Name=N'QĐ1.4'
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNameStaffTypeByUserName]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetNameStaffTypeByUserName]
@username nvarchar(100)
as
begin
	select B.*
	from Staff A, StaffType B
	where a.IDStaffType=B.ID and A.UserName=@username
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetPeoples]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetPeoples]
@idBill int
as
begin
	select COUNT(B.IDReceiveRoom)
	from ReceiveRoom A,ReceiveRoomDetails B,Bill C
	where A.ID=C.IDReceiveRoom and A.ID=B.IDReceiveRoom and C.ID=@idBill
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetRoomTypeByIdBookRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetRoomTypeByIdBookRoom]
@idBookRoom int
as
begin
	select B.*
	from BookRoom A, RoomType B
	where A.ID=@idBookRoom and A.IDRoomType=B.ID
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetRoomTypeByIdRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetRoomTypeByIdRoom]
@idRoom int
as
begin
	select B.*
	from Room A,RoomType B
	where A.IDRoomType=B.ID and A.ID=@idRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GetStaffSetUp]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_GetStaffSetUp]
@idBill int
as
begin
	select B.*
	from Bill A, Staff B
	where A.ID=@idBill and A.StaffSetUp=B.UserName
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertAccess]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertAccess]
@idJob INT, @idStaffType int
AS
BEGIN
	INSERT INTO access(idjob, idstafftype) VALUES(@idJob, @idStaffType)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBill]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertBill]
@idReceiveRoom int,@staffSetUp nvarchar(100)
as
begin
	insert into Bill(IDReceiveRoom,StaffSetUp)
	values(@idReceiveRoom,@staffSetUp)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBillDetails]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_InsertBillDetails]
@idBill int,@idService int,@count int
as
begin
		declare @totalPrice int,@price int
		select @price=Price
		from Service
		where ID=@idService
		set @totalPrice=@price*@count
		insert into BillDetails(IDBill,IDService,Count,TotalPrice)
		values(@idBill,@idService,@count,@totalPrice)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertBookRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertBookRoom]
@idCustomer int,@idRoomType int,@datecheckin date,@datecheckout date,@datebookroom smalldatetime
as
begin
	insert into BookRoom (IDCustomer,IDRoomType,DateCheckIn,DateCheckOut,DateBookRoom)
	values(@idCustomer,@idRoomType,@datecheckin,@datecheckout,@datebookroom)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertCustomer]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertCustomer]
@customerName NVARCHAR(100), @idCustomerType int, @idCard NVARCHAR(100),
@address NVARCHAR(200), @dateOfBirth date, @phoneNumber int,
@sex NVARCHAR(100), @nationality NVARCHAR(100)
AS
BEGIN
DECLARE @count INT =0
SELECT @count = COUNT(*) FROM customer WHERE IDCard = @idCard
IF(@count=0)
INSERT INTO dbo.Customer(IDCard,IDCustomerType, Name, DateOfBirth, Address, PhoneNumber, Sex, Nationality)
	VALUES(@idCard, @idCustomerType, @customerName, @dateOfBirth, @address, @phoneNumber, @sex, @nationality)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertCustomer_]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_InsertCustomer_]
@idCard nvarchar(100),@name nvarchar(100),@idCustomerType int, @dateOfBirth Date,@address nvarchar(200),@phoneNumber int,@sex nvarchar(100),@nationality nvarchar(100)
as
begin
	insert into Customer(IDCard,Name,IDCustomerType,DateOfBirth,Address,PhoneNumber,Sex,Nationality)
	values(@idCard,@name,@idCustomerType,@dateOfBirth,@address,@phoneNumber,@sex,@nationality)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertReport]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[USP_InsertReport]
@idBill int
AS
BEGIN
	DECLARE @month INT = 0
	DECLARE @year INT = 0
	DECLARE @id INT = 0
	DECLARE @price INT = 0
	SELECT @id = dbo.ROOM.IDRoomType, @month = MONTH(bill.DateOfCreate), @year = YEAR(bill.DateOfCreate), @price = bill.TotalPrice
	FROM bill INNER JOIN dbo.RECEIVEROOM ON RECEIVEROOM.ID = bill.IDReceiveRoom 
		INNER JOIN dbo.ROOM ON ROOM.ID = RECEIVEROOM.IDRoom
	WHERE bill.ID = @idBill

	DECLARE @count INT = 0	
	SELECT @count = COUNT(*) FROM report WHERE month = @month AND year = @year and idRoomType = @id
	IF(@count=0) -- khong ton tai roomtype
    BEGIN
		
		INSERT INTO report(idRoomType, Month, Year) SELECT roomtype.ID, @month, @year FROM roomtype 
	END
    UPDATE dbo.REPORT SET value = value + @price WHERE Year = @year AND Month = @month AND idRoomType = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertRoom]
@nameRoom NVARCHAR(100), @idRoomType INT, @idStatusRoom INT
AS
INSERT INTO dbo.Room(Name, IDRoomType, IDStatusRoom)
VALUES(@nameRoom, @idRoomType, @idStatusRoom)
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertService]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertService]
@name NVARCHAR(200), @idServiceType INT, @price int
AS
BEGIN
	INSERT INTO dbo.Service(Name,IDServiceType,Price)
	VALUES(@name, @idServiceType, @price)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertServiceType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertServiceType]
@name NVARCHAR(100)
AS
BEGIN
	INSERT INTO dbo.ServiceType(name)
	VALUES(@name)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertStaff]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertStaff]
@user NVARCHAR(100), @name NVARCHAR(100), @pass NVARCHAR(100),
@idStaffType INT,@idCard NVARCHAR(100), @dateOfBirth DATE, @sex NVARCHAR(100),
@address NVARCHAR(200), @phoneNumber INT, @startDay date
AS
BEGIN
	DECLARE @count INT =0
	SELECT @count = COUNT(*) FROM dbo.Staff WHERE UserName = @user OR IDCard = @idCard
	IF(@count >0) RETURN
	INSERT INTO dbo.Staff(UserName, DisplayName, PassWord, IDStaffType, IDCard, DateOfBirth, Sex, Address, PhoneNumber, StartDay)
	VALUES (@user, @name, @pass, @idStaffType,@idCard, @dateOfBirth, @sex, @address, @phoneNumber, @startDay)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_InsertStaffType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_InsertStaffType] 
@name NVARCHAR(100)
AS
BEGIN
    INSERT INTO staffType(Name) VALUES(@name)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_IsExistBillDetailsOfRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[USP_IsExistBillDetailsOfRoom]--Kq > 0 :TH3, ngược lại TH2. Tuy nhiên, trước khi kt đk này phải chắc chắn tồn tại Bill
@idRoom int,@idservice int
as
begin
	select *
	from Bill A,BillDetails B,ReceiveRoom C
	where A.IDStatusBill=1 and A.ID=B.IDBill and C.ID=A.IDReceiveRoom and C.IDRoom=@idRoom and B.IDService=@idservice
end
GO
/****** Object:  StoredProcedure [dbo].[USP_IsExistBillOfRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_IsExistBillOfRoom]--Trả về count > 0: tức là đã tồn tại Bill
@idRoom int
as
begin
	select *
	from Bill A,ReceiveRoom B
	where A.IDStatusBill=1 and A.IDReceiveRoom=B.ID and B.IDRoom=@idRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_IsIDBookRoomExists]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_IsIDBookRoomExists]
@idBookRoom int,@dateNow date
as
begin
	select *
	from BookRoom 
	where ID=@idBookRoom and DateCheckIn>=@dateNow and ID not in
	(
		select IDBookRoom
		from ReceiveRoom
	)
end
GO
/****** Object:  StoredProcedure [dbo].[USP_IsIdCardExists]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_IsIdCardExists]
@idCard nvarchar(100)
as
begin
select *
from Customer
where IDCard=@idCard
end
GO
/****** Object:  StoredProcedure [dbo].[USP_IsIdCardExistsAcc]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_IsIdCardExistsAcc]
@idCard nvarchar(100)
as
begin
	select *
	from Staff
	where IDCard=@idCard
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadBookRoomsByDate]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_LoadBookRoomsByDate]
@date Date
as
begin
	select A.ID[Mã đặt phòng], b.Name[Họ và tên],b.IDCard[CMND],C.Name[Loại phòng],A.DateCheckIn[Ngày nhận],A.DateCheckOut[Ngày trả]
	from BookRoom A,Customer B, RoomType C
	where a.IDRoomType=c.ID and A.IDCustomer=B.ID and A.DateBookRoom>=@date
	order by A.DateBookRoom desc
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadEmptyRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_LoadEmptyRoom]
@idRoomType int
as
begin
	select *
	from Room
	where IDStatusRoom=1 and IDRoomType=@idRoomType
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullAccessNow]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullAccessNow]
@idStaffType INT
AS
BEGIN
	SELECT Job.Name, job.ID FROM job INNER JOIN access ON job.Id = Access.IDJob
	WHERE @idStaffType = dbo.Access.IDStaffType
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullAccessRest]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[USP_LoadFullAccessRest]
@idStaffType INT
AS
BEGIN
	SELECT j.Name, j.Id FROM job j
	WHERE NOT EXISTS 
	(
		SELECT * FROM job INNER JOIN access ON job.Id = access.IdJob
		WHERE j.Id = job.Id AND access.idStaffType = @idStaffType
	)
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFUllBill]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFUllBill] 
AS
BEGIN
	SELECT bill.id, room.Name AS [roomName], Customer.Name as [customerName], StaffSetUp, DateOfCreate, STATUSBILL.Name, TotalPrice, (cast(Discount as nvarchar(4)) + '%') [Discount], cast(TotalPrice*( (100-Discount)/100.0) as int) [FinalPrice]
    FROM dbo.BILL INNER JOIN dbo.RECEIVEROOM ON RECEIVEROOM.ID = BILL.IDReceiveRoom
					INNER JOIN dbo.STATUSBILL ON STATUSBILL.id = bill.IDStatusBill
					INNER JOIN dbo.ROOM ON ROOM.ID = RECEIVEROOM.IDRoom
					inner join bookroom on bookroom.id = RECEIVEROOM.IDBookRoom
					inner join Customer on Customer.ID = BookRoom.IDCustomer
	ORDER BY DateOfCreate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullCustomer]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullCustomer]
AS
SELECT CUSTOMER.ID, Customer.Name, IDCard, CustomerType.Name as [NameCustomerType], Sex, DateOfBirth, PhoneNumber, Address, Nationality, IDCustomerType 
FROM dbo.Customer INNER JOIN dbo.CustomerType ON CustomerType.ID = Customer.IDCustomerType
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullCustomerType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------
--Customer Type
--------------------------------------------------------------

CREATE PROC [dbo].[USP_LoadFullCustomerType]
AS
SELECT * FROM dbo.CustomerType
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullParameter]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullParameter]
AS
SELECT * FROM dbo.PARAMETER
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullReport]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullReport]
@month INT, @year int
AS
BEGIN
	SELECT name, value, rate FROM dbo.REPORT INNER JOIN dbo.ROOMTYPE ON ROOMTYPE.ID = REPORT.idRoomType
	WHERE Month = @month AND Year = @year
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullRoom]
AS
SELECT Room.ID, Room.Name,RoomType.Name AS [nameRoomType], Price, LimitPerson,
StatusRoom.Name AS [nameStatusRoom], IDRoomType, IDStatusRoom
FROM dbo.Room INNER JOIN dbo.RoomType 
ON roomtype.id = room.IDRoomType
INNER JOIN dbo.StatusRoom ON statusroom.id = room.IDStatusRoom
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullRoomType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullRoomType]
AS
SELECT * FROM dbo.RoomType
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullService]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullService]
AS
SELECT Service.ID, Service.Name, Price, ServiceType.Name AS [nameServiceType], IDServiceType
FROM dbo.Service INNER JOIN dbo.ServiceType ON ServiceType.ID = Service.IDServiceType
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullServiceType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullServiceType]
AS
SELECT * FROM ServiceType
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullStaff]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_LoadFullStaff]
AS
BEGIN
	SELECT UserName, DisplayName, Name, IDCard,
			DateOfBirth, Sex, PhoneNumber, StartDay, Address, IDStaffType
    FROM dbo.Staff INNER JOIN dbo.StaffType ON StaffType.ID = Staff.IDStaffType
END
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullStaffType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------
--Staff type
--------------------------------------------------------------

CREATE PROC [dbo].[USP_LoadFullStaffType]
AS
begin
SELECT * FROM dbo.StaffType
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadFullStatusRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

--Status Room
--------------------------------------------------------------
CREATE PROC [dbo].[USP_LoadFullStatusRoom]
AS
SELECT * FROM dbo.StatusRoom
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadListFullRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_LoadListFullRoom]
@getToday Date
as
begin
	select distinct A.*
	from Room A,ReceiveRoom B, BookRoom C
	where A.IDStatusRoom=2 and A.ID=B.IDRoom and B.IDBookRoom=C.ID and C.DateCheckOut>=@getToday
	order by A.ID asc
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadReceiveRoomsByDate]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_LoadReceiveRoomsByDate]
@date Date
as
begin
	select A.ID[Mã nhận phòng], b.Name[Họ và tên],b.IDCard[CMND],C.Name[Tên phòng],D.DateCheckIn[Ngày nhận],D.DateCheckOut[Ngày trả]
	from ReceiveRoom A,Customer B, Room C,BookRoom D
	where A.IDBookRoom=D.ID and D.IDCustomer=B.ID and A.IDRoom=C.ID and D.DateCheckIn>=@date
	order by A.ID desc
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadServiceByServiceType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_LoadServiceByServiceType]
@idServiceType int
as
begin
	select *
	from Service
	where IDServiceType=@idServiceType
end
GO
/****** Object:  StoredProcedure [dbo].[USP_LoadStaffInforByUserName]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_LoadStaffInforByUserName]
@username nvarchar(100)
as
begin
	select *
	from Staff
	where UserName=@username
end
GO
/****** Object:  StoredProcedure [dbo].[USP_Login]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_Login]
@userName nvarchar(100),@passWord nvarchar(100)
as
Select * from Staff where UserName=@userName and PassWord=@passWord
GO
/****** Object:  StoredProcedure [dbo].[USP_RoomTypeInfo]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_RoomTypeInfo]
@id int
as
begin
select * 
from RoomType
where ID=@id
end
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchBill]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SearchBill]
@string NVARCHAR(100), @mode int
AS
BEGIN
	SELECT @string = '%' + [dbo].[ConvertString](@string) + '%'
	DECLARE @table TABLE(id int)
	IF(@mode = 0)
		INSERT INTO @table SELECT bill.id FROM bill WHERE CAST(id AS NVARCHAR(100)) LIKE @string
	ELSE IF(@mode = 1)
		INSERT INTO @table SELECT bill.id  FROM bill INNER JOIN dbo.ReceiveRoom ON ReceiveRoom.ID = Bill.IDReceiveRoom
		INNER JOIN dbo.BookRoom ON BookRoom.ID = ReceiveRoom.IDBookRoom INNER JOIN dbo.Customer ON Customer.ID = BookRoom.IDCustomer 
		WHERE [dbo].ConvertString(Customer.Name) LIKE @string
	ELSE IF(@mode = 2)
		INSERT INTO @table SELECT bill.id  FROM bill INNER JOIN dbo.ReceiveRoom ON ReceiveRoom.ID = Bill.IDReceiveRoom
		INNER JOIN dbo.BookRoom ON BookRoom.ID = ReceiveRoom.IDBookRoom INNER JOIN dbo.Customer ON Customer.ID = BookRoom.IDCustomer
		WHERE [dbo].ConvertString(Customer.IDCard) LIKE @string
	ELSE IF(@mode = 3)
		INSERT INTO @table SELECT bill.id  FROM bill INNER JOIN dbo.ReceiveRoom ON ReceiveRoom.ID = Bill.IDReceiveRoom
		INNER JOIN dbo.BookRoom ON BookRoom.ID = ReceiveRoom.IDBookRoom INNER JOIN dbo.Customer ON Customer.ID = BookRoom.IDCustomer
		WHERE CAST(dbo.Customer.PhoneNumber AS NVARCHAR(100)) LIKE @string

	SELECT bill.id, room.Name AS [roomName], Customer.Name as [customerName], bill.StaffSetUp, bill.DateOfCreate, STATUSBILL.Name, bill.TotalPrice, (cast(bill.Discount as nvarchar(4)) + '%') [Discount], cast(bill.TotalPrice*( (100-bill.Discount)/100.0) as int) [FinalPrice]
    FROM dbo.BILL INNER JOIN dbo.RECEIVEROOM ON RECEIVEROOM.ID = BILL.IDReceiveRoom 
	INNER JOIN dbo.STATUSBILL ON STATUSBILL.id = bill.IDStatusBill 
	INNER JOIN dbo.ROOM ON ROOM.ID = RECEIVEROOM.IDRoom
	INNER JOIN @table ON bill.id = [@table].id
	inner join bookroom on bookroom.id = RECEIVEROOM.IDBookRoom
	inner join Customer on Customer.ID = BookRoom.IDCustomer
	ORDER BY DateOfCreate DESC
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchCustomer]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROC [dbo].[USP_SearchCustomer]
	@string NVARCHAR(100), @mode INT
	AS
	BEGIN
		SELECT @string = '%' + [dbo].[ConvertString](@string) + '%'
		DECLARE @table TABLE(id INT)

		IF(@mode = 0)
			INSERT INTO @table SELECT id FROM [dbo].customer WHERE CAST(id AS NVARCHAR(100)) LIKE @string;
		ELSE IF(@mode = 1)
			INSERT INTO @table SELECT id FROM [dbo].customer WHERE [dbo].[ConvertString](name) LIKE @string;
		ELSE IF(@mode = 2)
			INSERT INTO @table SELECT id FROM [dbo].customer WHERE [dbo].[ConvertString](IDCard) LIKE @string;
		ELSE IF(@mode = 3)
			INSERT INTO @table SELECT id FROM [dbo].customer WHERE CAST(PhoneNumber AS NVARCHAR(100)) LIKE @string;

	    SELECT CUSTOMER.ID, Customer.Name, IDCard, CustomerType.Name as [NameCustomerType], Sex, DateOfBirth, PhoneNumber, Address, Nationality, IDCustomerType
		FROM Customer INNER JOIN @table ON [@table].id = CUSTOMER.ID INNER JOIN dbo.CustomerType ON CustomerType.ID = Customer.IDCustomerType
	END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchParameter]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------
--parameter
--------------------------------------------------------------
CREATE PROC [dbo].[USP_SearchParameter]
@string NVARCHAR(200)
AS
BEGIN
	SELECT @string = '%' + [dbo].[convertstring](@string) + '%'
	SELECT * FROM dbo.PARAMETER
	WHERE [dbo].[convertstring](name) like @string
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

--Room
--------------------------------------------------------------
CREATE PROC [dbo].[USP_SearchRoom]
@string NVARCHAR(100), @int INT
AS
BEGIN
	SELECT @string = '%' + [dbo].[convertString](@string) + '%'
	SELECT Room.ID, Room.Name,RoomType.Name AS [nameRoomType], Price, LimitPerson,
	StatusRoom.Name AS [nameStatusRoom], IDRoomType, IDStatusRoom
	FROM dbo.Room INNER JOIN dbo.RoomType ON roomtype.id = room.IDRoomType INNER JOIN dbo.StatusRoom ON statusroom.id = room.IDStatusRoom
	WHERE dbo.ConvertString(dbo.Room.name) LIKE @string OR dbo.Room.id = @int
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchRoomType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

--Room Type
--------------------------------------------------------------
CREATE PROC [dbo].[USP_SearchRoomType]
@string NVARCHAR(100), @int INT
AS
BEGIN
	SELECT @string = '%' + [dbo].[convertstring](@string) + '%'
	SELECT * FROM dbo.ROOMTYPE
	WHERE [dbo].[convertstring](name) LIKE @string OR id = @int
end
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchService]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_SearchService]
@string NVARCHAR(100), @int int
AS
BEGIN
		DECLARE @table TABLE
		(
			id INT
		)
		SELECT @string = '%' + [dbo].[ConvertString](@string) + '%'
		INSERT INTO @table
			SELECT id FROM dbo.SERVICE WHERE [dbo].[ConvertString](name) like @string OR id = @int
		SELECT Service.ID, Service.Name, Price, ServiceType.Name AS [nameServiceType], IDServiceType
		FROM @table INNER JOIN dbo.SERVICE ON SERVICE.ID = [@table].id INNER JOIN dbo.ServiceType ON ServiceType.ID = Service.IDServiceType
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchServiceType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------

--------------------------------------------------------------

--Service Type
--------------------------------------------------------------
CREATE PROC [dbo].[USP_SearchServiceType]
@string NVARCHAR(100), @int INT
AS
BEGIN
	DECLARE @table table( id int)
	SELECT @string ='%' + [dbo].[ConvertString](@string) + '%'
	INSERT INTO @table SELECT id FROM ServiceType WHERE [dbo].[ConvertString](name) LIKE @string OR id = @int
	SELECT dbo.SERVICETYPE.ID, Name FROM @table INNER JOIN servicetype ON  SERVICETYPE.ID = [@table].id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_SearchStaff]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------

--Staff 
--------------------------------------------------------------
CREATE PROC [dbo].[USP_SearchStaff]
@string NVARCHAR(100), @int int
AS
BEGIN
	SELECT @string = '%' + [dbo].[ConvertString](@string) + '%'
	DECLARE @table TABLE( username NVARCHAR(100))
	IF(@int < 1)
	begin
		INSERT INTO @table SELECT username FROM staff 
		WHERE username LIKE @string OR [dbo].[ConvertString](DisplayName) LIKE @string
		OR  idcard LIKE @string
	END
	ELSE
    BEGIN
		INSERT INTO @table SELECT username FROM staff 
		WHERE username LIKE @string OR [dbo].[ConvertString](DisplayName) LIKE @string
		OR  idcard LIKE @string OR cast(PhoneNumber AS NVARCHAR(100)) LIKE @string
	END
	SELECT Staff.UserName, DisplayName, Name, IDCard, DateOfBirth, Sex, PhoneNumber, StartDay, Address, IDStaffType
    FROM dbo.Staff INNER JOIN  @table ON [@table].username = STAFF.UserName INNER JOIN dbo.StaffType ON StaffType.ID = Staff.IDStaffType
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowBill]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_ShowBill]
@idRoom int
as
begin
	select D.Name [Tên dịch vụ],D.Price[Đơn giá],B.Count[Số lượng],B.TotalPrice[Thành tiền]
	from Bill A, BillDetails B, ReceiveRoom C, Service D
	where A.IDStatusBill=1 and A.ID=b.IDBill and A.IDReceiveRoom=C.ID and C.IDRoom=@idRoom and B.IDService=D.ID
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowBillInfo]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_ShowBillInfo]
@idBill int
as
begin
select D.Name[HoTen],D.IDCard[CMND],D.PhoneNumber[SDT],E.Name[LoaiKH],D.Address[DiaChi],D.Nationality[QuocTich],F.Name[TenPhong],G.Name[LoaiPhong],G.Price[DonGia],C.DateCheckIn[NgayDen],C.DateCheckOut[NgayDi],A.RoomPrice[TienPhong],A.ServicePrice[TienDichVu],A.Surcharge[PhuThu],A.TotalPrice[ThanhTien],A.Discount[GiamGia]
from Bill A, ReceiveRoom B,BookRoom C, Customer D,CustomerType E,Room F,RoomType G
where A.IDReceiveRoom=B.ID and B.IDBookRoom=C.ID and C.IDCustomer=D.ID and D.IDCustomerType=E.ID and B.IDRoom=F.ID and F.IDRoomType=G.ID and A.ID=@idBill
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowBillPreView]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_ShowBillPreView]
@idBill int
as
begin
	select D.Name [Tên dịch vụ],D.Price[Đơn giá],B.Count[Số lượng],B.TotalPrice[Thành tiền]
	from Bill A, BillDetails B, Service D
	where A.IDStatusBill=2 and A.ID=b.IDBill and A.ID=@idBill and B.IDService=D.ID
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowBillRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_ShowBillRoom]--Muốn proc thực thi được thì phải thực thi USP_UpdateBill trước(nếu có thể)
@getToday Date,@idRoom int
as
begin

	select A.Name [Tên phòng],D.Price[Đơn giá] ,C.DateCheckIn [Ngày nhận],C.DateCheckOut[Ngày trả] ,E.RoomPrice[Tiền phòng],E.Surcharge[Phụ thu]
	from Room A,ReceiveRoom B, BookRoom C,RoomType D,Bill E
	where E.IDReceiveRoom=B.ID and IDStatusRoom=2 and A.ID=B.IDRoom and B.IDBookRoom=C.ID and A.IDRoomType=D.ID and C.DateCheckOut>=@getToday and B.IDRoom=@idRoom and E.IDStatusBill=1
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowCustomerFromReceiveRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_ShowCustomerFromReceiveRoom]
@idReceiveRoom int
as
begin
	select C.Name[Tên khách hàng],C.IDCard[CMND],C.Address[Địa chỉ],C.PhoneNumber[Số điện thoại],C.Nationality[Quốc tịch]
	from ReceiveRoom A, BookRoom B, Customer C
	where A.ID=@idReceiveRoom and A.IDBookRoom=B.ID and B.IDCustomer=C.ID
	union
	select C.Name[Tên khách hàng],C.IDCard[CMND],C.Address[Địa chỉ],C.PhoneNumber[Số điện thoại],C.Nationality[Quốc tịch]
	from ReceiveRoom A,ReceiveRoomDetails B,Customer C
	where A.ID=@idReceiveRoom and A.ID=B.IDReceiveRoom and B.IDCustomerOther=C.ID
end
GO
/****** Object:  StoredProcedure [dbo].[USP_ShowReceiveRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_ShowReceiveRoom]
@idReceiveRoom int
as
begin
	select A.ID[Mã nhận phòng], C.Name[Tên phòng],B.DateCheckIn[Ngày nhận],B.DateCheckOut[Ngày trả]
	from ReceiveRoom A,BookRoom B,Room C
	where A.IDBookRoom=B.ID and A.IDRoom=C.ID and A.ID=@idReceiveRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateAccount3]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateAccount3]
@username nvarchar(100),@address nvarchar(100),@phonenumber int
as
begin
	update Staff
	set Address=@address,PhoneNumber=@phonenumber
	where UserName=@username
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateBill_Other]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateBill_Other]
@idBill int,@discount int
as
begin
	declare @totalPrice int=0,@idRoom int
	select @totalPrice=RoomPrice+ServicePrice+ Surcharge
	from Bill
	where ID=@idBill

	update Bill
	set DateOfCreate=GETDATE(), TotalPrice=@totalPrice,Discount=@discount,IDStatusBill=2
	where ID=@idBill

	select @idRoom=B.IDRoom
	from Bill A, ReceiveRoom B
	where A.IDReceiveRoom=B.ID

	update Room
	set IDStatusRoom=1
	where ID=@idRoom
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateBill_RoomPrice]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateBill_RoomPrice]
@idBill int
as
begin
	declare @idReceiveRoom int,@roomPrice int =0,@price int,@days int,@countCustomer int,@limitPerson int,@check1 int,@check2 int,@surcharge int =0

	select @days=DATEDIFF(day,C.DateCheckIn,C.DateCheckOut),@price=D.Price,@limitPerson=D.LimitPerson,@idReceiveRoom=A.IDReceiveRoom
	from Bill A,ReceiveRoom B,BookRoom C,RoomType D,Room E
	where A.ID=@idBill and A.IDReceiveRoom=B.ID and B.IDRoom=E.ID and E.IDRoomType=D.ID and C.ID=B.IDBookRoom

	select @countCustomer=COUNT(B.IDReceiveRoom)
	from ReceiveRoom A,ReceiveRoomDetails B
	where A.ID=@idReceiveRoom and A.ID=B.IDReceiveRoom

	set @roomPrice=@price*@days;

	declare @QD3 float = 0 -- phu thu them
	select @QD3 = value from Parameter where Name = N'QĐ3'

	declare @QD4 float = 0 -- khach nuoc ngoai
	select @QD4 = value from Parameter where Name = N'QĐ4'

	if((@countCustomer+1-@limitPerson)>=0)
	set @surcharge=@roomPrice*@QD3*(@countCustomer+1-@limitPerson)

	select @check1=COUNT(*)
	from ReceiveRoom A,BookRoom B,Customer D
	where A.IDBookRoom=B.ID and B.IDCustomer=D.ID and D.Nationality!=N'Việt Nam' and A.ID=@idReceiveRoom
	select @check2=COUNT(*)
	from ReceiveRoom A,ReceiveRoomDetails C,Customer D
	where A.ID=C.IDReceiveRoom and D.ID=C.IDCustomerOther and D.Nationality!=N'Việt Nam' and A.ID=@idReceiveRoom

	if((@check1+@check2)>0) 
	set @surcharge=@surcharge + @roomPrice*(@QD4 - 1)

	update Bill
	set RoomPrice=@roomPrice, Surcharge=@surcharge
	where id=@idBill
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateBill_ServicePrice]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateBill_ServicePrice]
@idBill int
as
begin
	declare @totalServicePrice int=0
	select @totalServicePrice=SUM(TotalPrice)
	from BillDetails
	where IDBill=@idBill
	if(@totalServicePrice is null)
	set @totalServicePrice=0
	update Bill 
	set ServicePrice=@totalServicePrice
	where ID=@idBill
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateBillDetails]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateBillDetails]
@idBill int,@idService int,@_count int
as
begin
	declare @totalPrice int,@price int,@count int

	select @price=Price
	from Service
	where ID=@idService

	select @count=Count
	from Bill A,BillDetails B
	where A.ID=B.IDBill and A.ID=@idBill and A.IDStatusBill=1 and B.IDService=@idService

	set @count=@count+@_count
	if(@count>0)
	begin
		set @totalPrice=@count*@price
		update BillDetails
		set Count=@count,TotalPrice=@totalPrice
		where IDBill=@idBill and IDService=@idService
	end
	else
	begin
		delete from BillDetails
		where IDBill=@idBill and IDService=@idService
	end
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateBookRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateBookRoom]
@id int,@idRoomType int,@dateCheckIn date,@datecheckOut date
as
begin
	update BookRoom
	set IDRoomType=@idRoomType,DateCheckIn=@dateCheckIn,DateCheckOut=@datecheckOut
	where ID=@id
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateCustomer]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateCustomer]
@id INT, @customerName NVARCHAR(100), @idCustomerType int, @idCardNow NVARCHAR(100), @address NVARCHAR(200),
@dateOfBirth date, @phoneNumber int, @sex NVARCHAR(100), @nationality NVARCHAR(100), @idCardPre NVARCHAR(100)
AS
BEGIN
	IF(@idCardPre != @idCardNow)
	begin
		DECLARE @count INT=0
		SELECT @count=COUNT(*)
		FROM dbo.Customer
		WHERE IDCard = @idCardNow
		IF(@count=0)
		BEGIN
			UPDATE dbo.Customer 
			SET 
			Name =@customerName, IDCustomerType = @idCustomerType, IDCard =@idCardNow,
			Address = @address, DateOfBirth =@dateOfBirth, PhoneNumber =@phoneNumber,
			Nationality = @nationality, Sex = @sex
			WHERE ID = @id
		END
	END
	ELSE
	BEGIN
		UPDATE dbo.Customer 
			SET 
			Name =@customerName, IDCustomerType = @idCustomerType,Address = @address,
			DateOfBirth =@dateOfBirth, PhoneNumber =@phoneNumber,
			Nationality = @nationality, Sex = @sex
			WHERE ID = @id
	end
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateCustomer_]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateCustomer_]
@id int,@name nvarchar(50),@idCard nvarchar(50),@idCustomerType int,@phoneNumber int, @dateOfBirth date,@address nvarchar(100),@sex nvarchar(20),@nationality nvarchar(100)
as
begin
	update Customer
	set Name=@name,IDCard=@idCard,IDCustomerType=@idCustomerType,PhoneNumber=@phoneNumber,DateOfBirth=@dateOfBirth,Address=@address,Sex=@sex,Nationality=@nationality
	where ID=@id
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateDisplayName]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateDisplayName]
@username nvarchar(100),@displayname nvarchar(100)
as
begin
	update Staff
	set DisplayName=@displayname
	where UserName=@username
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateInfo]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateInfo]
@username nvarchar(100),@address nvarchar(100),@phonenumber int,@idcard nvarchar(100),@dateOfBirth date,@sex nvarchar(50)
as
begin
	update Staff
	set Address=@address,PhoneNumber=@phonenumber,IDCard=@idcard,Sex=@sex, DateOfBirth=@dateOfBirth
	where UserName=@username
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateParameter]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateParameter]
@name NVARCHAR(200), @value float, @describe NVARCHAR(200)
AS
BEGIN
UPDATE dbo.PARAMETER
	SET
	Value = @value,
	Describe = @describe,
	datemodify = GETDATE()
	WHERE name = @name
	SELECT @name = [dbo].[ConvertString](@name)
	IF(@name = 'QD2.1')
		UPDATE dbo.ROOMTYPE SET LimitPerson = @value WHERE ID = 1
	ELSE IF(@name = 'QD2.2')
		UPDATE dbo.ROOMTYPE SET LimitPerson = @value WHERE ID = 2
	ELSE IF(@name = 'QD2.3')
		UPDATE dbo.ROOMTYPE SET LimitPerson = @value WHERE ID = 3
	ELSE IF(@name = 'QD2.4')
		UPDATE dbo.ROOMTYPE SET LimitPerson = @value WHERE ID = 4
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdatePassword]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdatePassword]
@username nvarchar(100),@password nvarchar(100)
as
begin
	update Staff
	set PassWord=@password
	where UserName=@username
end
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateReceiveRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[USP_UpdateReceiveRoom]
@id int,@idRoom int
as
begin
	update ReceiveRoom
	set IDRoom=@idRoom
	where ID=@id

	update Room
	set IDStatusRoom=2
	where ID=@idRoom
end	

GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateRoom]
@id INT, @nameRoom NVARCHAR(100), @idRoomType INT, @idStatusRoom INT
AS
UPDATE dbo.Room
SET
	Name = @nameRoom, IDRoomType = @idRoomType, IDStatusRoom = @idStatusRoom
WHERE ID = @id
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateRoomType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateRoomType]
@id INT, @name NVARCHAR(100), @price int, @limitPerson int
AS
	UPDATE RoomType
	SET
    name = @name, Price = @price, LimitPerson = @limitPerson
	WHERE id =@id
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateService]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateService]
@id int, @name nvarchar(200), @idServiceType int, @price int
as
begin
	update service
	set
	name = @name,
	idservicetype = @idservicetype,
	price = @price
	where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateServiceType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateServiceType]
@id INT, @name NVARCHAR(100)
AS
BEGIN
	UPDATE dbo.ServiceType
	SET
    name = @name
	WHERE id =@id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateStaff]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateStaff]
@user NVARCHAR(100), @name NVARCHAR(100),@idStaffType INT,
@idCard NVARCHAR(100), @dateOfBirth DATE, @sex NVARCHAR(100),
@address NVARCHAR(200), @phoneNumber INT, @startDay DATE
AS
BEGIN
	DECLARE @count INT = 0
	SELECT @count=COUNT(*) FROM staff
	WHERE IDCard = @idCard AND UserName != @user
	IF(@count = 0)
	UPDATE dbo.STAFF
	SET
    displayname = @name, idstafftype = @idstafftype,
	idcard= @idCard, DateOfBirth = @dateOfBirth, sex = @sex,
	Address = @address, PhoneNumber = @phoneNumber, StartDay = @startDay
	WHERE UserName = @user
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateStaffType]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_UpdateStaffType] 
@id int, @name NVARCHAR(100)
AS
BEGIN
	UPDATE dbo.StaffType
	SET
    Name = @name
	WHERE ID = @id
END
GO
/****** Object:  StoredProcedure [dbo].[USP_UpdateStatusRoom]    Script Date: 6/25/2018 2:42:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[USP_UpdateStatusRoom]
@idRoom int
as
begin
	update Room
	set IDStatusRoom=1
	where ID=@idRoom
end
GO
CREATE PROCEDURE USP_DeleteStaff
    @username NVARCHAR(100)
AS
BEGIN
    DELETE FROM Staff WHERE UserName = @username
END

EXEC USP_DeleteStaff @username = 'ndc07'
