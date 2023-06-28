USE [master]
GO
CREATE DATABASE [car_parts]
GO
ALTER DATABASE [car_parts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [car_parts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [car_parts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [car_parts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [car_parts] SET ARITHABORT OFF 
GO
ALTER DATABASE [car_parts] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [car_parts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [car_parts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [car_parts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [car_parts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [car_parts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [car_parts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [car_parts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [car_parts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [car_parts] SET  DISABLE_BROKER 
GO
ALTER DATABASE [car_parts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [car_parts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [car_parts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [car_parts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [car_parts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [car_parts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [car_parts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [car_parts] SET RECOVERY FULL 
GO
ALTER DATABASE [car_parts] SET  MULTI_USER 
GO
ALTER DATABASE [car_parts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [car_parts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [car_parts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [car_parts] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [car_parts] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'car_parts', N'ON'
GO
ALTER DATABASE [car_parts] SET QUERY_STORE = OFF
GO
USE [car_parts]
GO
/****** Object:  Table [dbo].[cars]    Script Date: 03-Jul-20 17:08:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cars](
	[car_id] [int] NOT NULL,
	[car_manufacturer_code] [int] NULL,
	[car_year_of_manufacturer] [datetime] NULL,
	[model] [varchar](50) NULL,
	[other_details] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[car_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parts]    Script Date: 03-Jul-20 17:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parts](
	[part_id] [int] NOT NULL,
	[car_id] [int] NULL,
	[parent_part_id] [int] NULL,
	[part_level_code] [int] NULL,
	[part_manufacturer_code] [int] NULL,
	[part_type_code] [int] NULL,
	[supplier_id] [int] NULL,
	[part_name] [varchar](200) NULL,
	[weight] [float] NULL,
	[conditon] [varchar](200) NULL,
	[mileage_donor_vehicle] [float] NULL,
	[other_part_details] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[part_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_car_manufacturers]    Script Date: 03-Jul-20 17:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ref_car_manufacturers](
	[car_manufacturer_code] [int] NOT NULL,
	[car_manufacturer_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[car_manufacturer_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_part_levels]    Script Date: 03-Jul-20 17:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ref_part_levels](
	[part_level_code] [int] NOT NULL,
	[part_level_description] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[part_level_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_part_manufacturer]    Script Date: 03-Jul-20 17:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ref_part_manufacturer](
	[part_manufacturer_code] [int] NOT NULL,
	[part_manufacturer_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[part_manufacturer_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ref_part_types]    Script Date: 03-Jul-20 17:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ref_part_types](
	[part_type_code] [int] NOT NULL,
	[part_type_description] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[part_type_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supplier]    Script Date: 03-Jul-20 17:08:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supplier](
	[supplier_id] [int] NOT NULL,
	[supplier_name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cars]  WITH CHECK ADD FOREIGN KEY([car_manufacturer_code])
REFERENCES [dbo].[ref_car_manufacturers] ([car_manufacturer_code])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([car_id])
REFERENCES [dbo].[cars] ([car_id])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([car_id])
REFERENCES [dbo].[cars] ([car_id])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([parent_part_id])
REFERENCES [dbo].[parts] ([part_id])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([part_level_code])
REFERENCES [dbo].[ref_part_levels] ([part_level_code])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([part_manufacturer_code])
REFERENCES [dbo].[ref_part_manufacturer] ([part_manufacturer_code])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([part_type_code])
REFERENCES [dbo].[ref_part_types] ([part_type_code])
GO
ALTER TABLE [dbo].[parts]  WITH CHECK ADD FOREIGN KEY([supplier_id])
REFERENCES [dbo].[supplier] ([supplier_id])
GO
USE [master]
GO
ALTER DATABASE [car_parts] SET  READ_WRITE 
GO
