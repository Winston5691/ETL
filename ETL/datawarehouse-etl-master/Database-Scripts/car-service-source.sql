USE [master]
GO
ALTER DATABASE [car_services] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [car_services] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [car_services] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [car_services] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [car_services] SET ARITHABORT OFF 
GO
ALTER DATABASE [car_services] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [car_services] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [car_services] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [car_services] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [car_services] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [car_services] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [car_services] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [car_services] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [car_services] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [car_services] SET  DISABLE_BROKER 
GO
ALTER DATABASE [car_services] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [car_services] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [car_services] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [car_services] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [car_services] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [car_services] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [car_services] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [car_services] SET RECOVERY FULL 
GO
ALTER DATABASE [car_services] SET  MULTI_USER 
GO
ALTER DATABASE [car_services] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [car_services] SET DB_CHAINING OFF 
GO
ALTER DATABASE [car_services] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [car_services] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [car_services] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'car_services', N'ON'
GO
ALTER DATABASE [car_services] SET QUERY_STORE = OFF
GO
USE [car_services]
GO
/****** Object:  Table [dbo].[Cars]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars](
	[license_number] [int] NOT NULL,
	[model_code] [int] NULL,
	[customer_id] [int] NULL,
	[current_mileage] [int] NULL,
	[other_car_detaitls] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[license_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[contact_id] [int] NOT NULL,
	[first_name] [varchar](18) NULL,
	[middle_name] [varchar](18) NULL,
	[last_name] [varchar](18) NULL,
	[email_address] [varchar](100) NULL,
	[phone_number] [char](11) NULL,
	[address_line_1] [varchar](50) NULL,
	[address_line_2] [varchar](50) NULL,
	[address_line_3] [varchar](50) NULL,
	[address_line_4] [varchar](50) NULL,
	[town_city] [varchar](20) NULL,
	[state_county_province] [varchar](20) NULL,
	[country] [varchar](20) NULL,
	[other_details] [varchar](100) NULL,
	[Gender] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Defects]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Defects](
	[defect_id] [int] NOT NULL,
	[license_number] [int] NULL,
	[defect_description] [varchar](200) NULL,
	[date_defect_recorded] [date] NULL,
	[other_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[defect_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[manufacturer_code] [int] NOT NULL,
	[manufacturer_name] [varchar](30) NULL,
	[manufacturer_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mechanics]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mechanics](
	[mechanic_id] [int] NOT NULL,
	[mechanic_name] [varchar](40) NULL,
	[mechanic_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[mechanic_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mechanics_on_Service]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mechanics_on_Service](
	[mechanic_id] [int] NOT NULL,
	[sv_booking_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[mechanic_id] ASC,
	[sv_booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Models]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Models](
	[model_code] [int] NOT NULL,
	[manufacturer_code] [int] NULL,
	[model_name] [varchar](30) NULL,
	[other_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[model_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Parts]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Parts](
	[part_id] [int] NOT NULL,
	[part_name] [varchar](30) NULL,
	[part_description] [varchar](100) NULL,
	[number_in_stock] [int] NULL,
	[other_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[part_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PartsOrderList]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PartsOrderList](
	[booking_id] [int] NOT NULL,
	[part_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC,
	[part_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceBooking]    Script Date: 03-Jul-20 17:16:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceBooking](
	[booking_id] [int] NOT NULL,
	[contact_id] [int] NULL,
	[license_number] [int] NULL,
	[date_of_booking] [date] NULL,
	[booking_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[Contacts] ([contact_id])
GO
ALTER TABLE [dbo].[Cars]  WITH CHECK ADD FOREIGN KEY([model_code])
REFERENCES [dbo].[Models] ([model_code])
GO
ALTER TABLE [dbo].[Defects]  WITH CHECK ADD FOREIGN KEY([license_number])
REFERENCES [dbo].[Cars] ([license_number])
GO
ALTER TABLE [dbo].[Mechanics_on_Service]  WITH CHECK ADD FOREIGN KEY([mechanic_id])
REFERENCES [dbo].[Mechanics] ([mechanic_id])
GO
ALTER TABLE [dbo].[Mechanics_on_Service]  WITH CHECK ADD FOREIGN KEY([sv_booking_id])
REFERENCES [dbo].[ServiceBooking] ([booking_id])
GO
ALTER TABLE [dbo].[Models]  WITH CHECK ADD FOREIGN KEY([manufacturer_code])
REFERENCES [dbo].[Manufacturers] ([manufacturer_code])
GO
ALTER TABLE [dbo].[PartsOrderList]  WITH CHECK ADD FOREIGN KEY([booking_id])
REFERENCES [dbo].[ServiceBooking] ([booking_id])
GO
ALTER TABLE [dbo].[PartsOrderList]  WITH CHECK ADD FOREIGN KEY([part_id])
REFERENCES [dbo].[Parts] ([part_id])
GO
ALTER TABLE [dbo].[ServiceBooking]  WITH CHECK ADD FOREIGN KEY([contact_id])
REFERENCES [dbo].[Contacts] ([contact_id])
GO
ALTER TABLE [dbo].[ServiceBooking]  WITH CHECK ADD FOREIGN KEY([license_number])
REFERENCES [dbo].[Cars] ([license_number])
GO
USE [master]
GO
ALTER DATABASE [car_services] SET  READ_WRITE 
GO
