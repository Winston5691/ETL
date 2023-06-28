USE [master]
GO
ALTER DATABASE [car_sales] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [car_sales] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [car_sales] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [car_sales] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [car_sales] SET ARITHABORT OFF 
GO
ALTER DATABASE [car_sales] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [car_sales] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [car_sales] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [car_sales] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [car_sales] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [car_sales] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [car_sales] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [car_sales] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [car_sales] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [car_sales] SET  DISABLE_BROKER 
GO
ALTER DATABASE [car_sales] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [car_sales] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [car_sales] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [car_sales] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [car_sales] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [car_sales] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [car_sales] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [car_sales] SET RECOVERY FULL 
GO
ALTER DATABASE [car_sales] SET  MULTI_USER 
GO
ALTER DATABASE [car_sales] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [car_sales] SET DB_CHAINING OFF 
GO
ALTER DATABASE [car_sales] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [car_sales] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [car_sales] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'car_sales', N'ON'
GO
ALTER DATABASE [car_sales] SET QUERY_STORE = OFF
GO
USE [car_sales]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 03-Jul-20 17:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[address_ID] [int] NOT NULL,
	[customer_ID] [int] NULL,
	[address_Line_1] [varchar](100) NULL,
	[address_Line_2] [varchar](100) NULL,
	[address_Line_3] [varchar](100) NULL,
	[address_Line_4] [varchar](100) NULL,
	[town_city] [varchar](30) NULL,
	[state_Country_Province] [varchar](30) NULL,
	[Country] [varchar](30) NULL,
	[post_zip_code] [char](5) NULL,
	[other_address_Details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[address_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Car_Features]    Script Date: 03-Jul-20 17:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car_Features](
	[Car_Feature_ID] [int] NOT NULL,
	[Car_Feature_Description] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Car_Feature_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Car_Manufacturers]    Script Date: 03-Jul-20 17:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car_Manufacturers](
	[manufacturer_shortName] [char](10) NOT NULL,
	[manufacturer_fullName] [char](20) NULL,
	[manufacturer_other_details] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[manufacturer_shortName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Car_Models]    Script Date: 03-Jul-20 17:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car_Models](
	[model_code] [int] NOT NULL,
	[manufacturer_code] [char](10) NULL,
	[model_name] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[model_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Car_sold]    Script Date: 03-Jul-20 17:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car_sold](
	[car_sold_ID] [int] NOT NULL,
	[car_for_sale_ID] [int] NULL,
	[customer_ID] [int] NULL,
	[agreed_Price] [int] NULL,
	[date_sold] [date] NULL,
	[other_Details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[car_sold_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cars_for_sales]    Script Date: 03-Jul-20 17:17:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cars_for_sales](
	[car_for_sale_ID] [int] NOT NULL,
	[manufacturer_shortname] [char](10) NULL,
	[model_code] [int] NULL,
	[vehicle_Category_code] [int] NULL,
	[asking_Price] [int] NULL,
	[curent_Mileage] [int] NULL,
	[date_Acquired] [date] NULL,
	[registration_Year] [int] NULL,
	[other_Car_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[car_for_sale_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 03-Jul-20 17:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[customer_ID] [int] NOT NULL,
	[cell_Mobile_phone] [char](11) NULL,
	[email_Address] [varchar](100) NULL,
	[other_Customer_Details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Preferences]    Script Date: 03-Jul-20 17:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Preferences](
	[customer_Perference_ID] [int] NOT NULL,
	[car_feature_ID] [int] NULL,
	[customer_ID] [int] NULL,
	[customer_preference_Details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_Perference_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feature_on_Cars_for_sale]    Script Date: 03-Jul-20 17:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feature_on_Cars_for_sale](
	[car_for_sale_ID] [int] NOT NULL,
	[car_feature_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[car_for_sale_ID] ASC,
	[car_feature_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle_category]    Script Date: 03-Jul-20 17:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle_category](
	[vehicle_category_code] [int] NOT NULL,
	[vehicle_category_Description] [char](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[vehicle_category_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([customer_ID])
REFERENCES [dbo].[Customer] ([customer_ID])
GO
ALTER TABLE [dbo].[Car_sold]  WITH CHECK ADD FOREIGN KEY([car_for_sale_ID])
REFERENCES [dbo].[Cars_for_sales] ([car_for_sale_ID])
GO
ALTER TABLE [dbo].[Car_sold]  WITH CHECK ADD FOREIGN KEY([customer_ID])
REFERENCES [dbo].[Customer] ([customer_ID])
GO
ALTER TABLE [dbo].[Cars_for_sales]  WITH CHECK ADD FOREIGN KEY([manufacturer_shortname])
REFERENCES [dbo].[Car_Manufacturers] ([manufacturer_shortName])
GO
ALTER TABLE [dbo].[Cars_for_sales]  WITH CHECK ADD FOREIGN KEY([model_code])
REFERENCES [dbo].[Car_Models] ([model_code])
GO
ALTER TABLE [dbo].[Cars_for_sales]  WITH CHECK ADD FOREIGN KEY([vehicle_Category_code])
REFERENCES [dbo].[Vehicle_category] ([vehicle_category_code])
GO
ALTER TABLE [dbo].[Customer_Preferences]  WITH CHECK ADD FOREIGN KEY([car_feature_ID])
REFERENCES [dbo].[Car_Features] ([Car_Feature_ID])
GO
ALTER TABLE [dbo].[Customer_Preferences]  WITH CHECK ADD FOREIGN KEY([customer_ID])
REFERENCES [dbo].[Customer] ([customer_ID])
GO
ALTER TABLE [dbo].[feature_on_Cars_for_sale]  WITH CHECK ADD FOREIGN KEY([car_for_sale_ID])
REFERENCES [dbo].[Cars_for_sales] ([car_for_sale_ID])
GO
ALTER TABLE [dbo].[feature_on_Cars_for_sale]  WITH CHECK ADD FOREIGN KEY([car_feature_ID])
REFERENCES [dbo].[Car_Features] ([Car_Feature_ID])
GO
USE [master]
GO
ALTER DATABASE [car_sales] SET  READ_WRITE 
GO
