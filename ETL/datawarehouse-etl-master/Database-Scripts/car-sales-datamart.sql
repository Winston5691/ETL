declare @dbname varchar(300);
set @dbname=null;

select @dbname=name from sys.databases
where name='Car_Sales_DM'

print @dbname

if(@dbname is not null)
begin
use master
drop database Car_Sales_DM;
Create database Car_Sales_DM;
end
else
begin
Create database Car_Sales_DM;
end
go
use Car_Sales_DM
go


CREATE TABLE FeatureGroupDimension
( 
	FeatureGroupDimensionId int identity(1,1),
	FeatureGroupPath varchar(300),
	CONSTRAINT XPKFeatureGroupDimension PRIMARY KEY (FeatureGroupDimensionId ASC)
)

CREATE TABLE FeatureDimension
( 
	FeatureID            int  identity(1,1) ,
	FeatureSourceID		int,
	FeatureDescription   varchar(200)   ,
	CONSTRAINT XPKFeatureDimension PRIMARY KEY (FeatureID ASC)
)

CREATE TABLE FeatureGroupDimensionBridge
( 
	FeatureGroupDimensionId int ,
	FeatureID            int   ,
	CONSTRAINT XPKFeatureGroupDimensionBridge PRIMARY KEY (FeatureGroupDimensionId ASC,FeatureID ASC),
	CONSTRAINT R_45 FOREIGN KEY (FeatureGroupDimensionId) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId),
CONSTRAINT R_47 FOREIGN KEY (FeatureID) REFERENCES FeatureDimension(FeatureID)
)



CREATE TABLE CarCategory
( 
	CategoryCode int identity(1,1),
    Category_SouceCode int,
	CategoryDescription  varchar(30)   ,
	PRIMARY KEY (CategoryCode)
)

CREATE TABLE Year
( 
	YearID               int   identity(1,1),
	YearName            int,
	CONSTRAINT XPKYear PRIMARY KEY (YearID ASC)
)




CREATE TABLE Quarter
( 
	QuarterID            int   identity(1,1),
	QuarterName          int,
	YearID               int   ,
	CONSTRAINT XPKQuarter PRIMARY KEY (QuarterID ASC),
	CONSTRAINT R_65 FOREIGN KEY (YearID) REFERENCES Year(YearID)
)




CREATE TABLE Month
( 
	MonthID              int   identity(1,1),
	MonthName            int ,
	QuarterID            int   ,
	CONSTRAINT XPKMonth PRIMARY KEY (MonthID ASC),
	CONSTRAINT R_64 FOREIGN KEY (QuarterID) REFERENCES Quarter(QuarterID)
)




CREATE TABLE TimeDimension
( 
	TimeID               int   identity(1,1),
	DayName              int,
	MonthID              int   ,
	CONSTRAINT XPKTimeDimension PRIMARY KEY (TimeID ASC),
	CONSTRAINT R_63 FOREIGN KEY (MonthID) REFERENCES Month(MonthID)
)



CREATE TABLE Customer
( 
	CustomerID           int   identity(1,1),
    Customer_SouceID     int,
	CustomerMobilePhone  char(11)   ,
	CustomerEmailAddress varchar(100)   ,
	CustomerOtherDetails varchar(200)   ,
	FeatureGroupDimensionId int   ,
	CONSTRAINT XPKCustomer PRIMARY KEY (CustomerID ASC),
	CONSTRAINT R_57 FOREIGN KEY (FeatureGroupDimensionId) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId)
)




CREATE TABLE Category_Aggregate_Fact_Table
( 
	CategoryCode         int  ,
	MonthID               int   ,
    TotalCount            int  ,
	AverageAskingPrice   float   ,
	AverageAgreePrice    float   ,
	CONSTRAINT XPKCategory_Aggregate_Fact_Table PRIMARY KEY (CategoryCode ASC,MonthID ASC),
	CONSTRAINT R_72 FOREIGN KEY (CategoryCode) REFERENCES CarCategory(CategoryCode),
CONSTRAINT R_73 FOREIGN KEY (MonthID) REFERENCES Month(MonthID),

)




CREATE TABLE Feature_Aggregate_Fact_Table
( 
	FeatureID            int   ,
	TotalCount           int   ,
	CONSTRAINT XPKFeature_Aggregate_Fact_Table PRIMARY KEY (FeatureID ASC),
	CONSTRAINT R_71 FOREIGN KEY (FeatureID) REFERENCES FeatureDimension(FeatureID)
)




CREATE TABLE CarManufacturer
( 
	ManufacturerID       int   identity(1,1),
    Manufacturer_SourceID int,
	ManufacturerShortName varchar(30)   ,
	ManufacturerFullName varchar(30),
	ManufacturerOtherDetails varchar(200)   ,
	CONSTRAINT XPKCarManufacturer PRIMARY KEY (ManufacturerID ASC)
)



CREATE TABLE CarModel
( 
	ModelCode            int identity(1,1),
    Model_SouceCode      int,
	ModelName            varchar(30)   ,
	ManufacturerID       varchar(30)   ,
	CONSTRAINT XPKCarModel PRIMARY KEY (ModelCode ASC),
	--REFERENCE REMOVED
)




CREATE TABLE CarDimension
( 
	CarID                int  identity(1,1) ,
	Car_SourceID	     int,	
	CategoryCode         int,
	ModelYear            int,
	ModelCode            int   ,
	CONSTRAINT XPKCarDimension PRIMARY KEY (CarID ASC),
	CONSTRAINT R_60 FOREIGN KEY (ModelCode) REFERENCES CarModel(ModelCode),
CONSTRAINT R_62 FOREIGN KEY (CategoryCode) REFERENCES CarCategory(CategoryCode)
)



CREATE TABLE Car_Aggregate_Fact_Table
( 
	CarID                int   ,
	TotalCustomer        int   ,
	CONSTRAINT XPKCar_Aggregate_Fact_Table PRIMARY KEY (CarID ASC),
	CONSTRAINT R_70 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID)
)




CREATE TABLE Manufacturer_Aggregate_Fact_Table
( 
	ManufacturerID       int   ,
	MonthID               int   ,
	TotalCount             int   ,
	AverageAskingPrice   float   ,
	AverageAgreePrice    float   ,
	CONSTRAINT XPKManufacturer_Aggregate_Fact_Table PRIMARY KEY (ManufacturerID ASC,MonthID ASC),
CONSTRAINT R_67 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID),
CONSTRAINT R_68 FOREIGN KEY (MonthID) REFERENCES Month(MonthID),

)




CREATE TABLE CarsAcquiredFactTable
( 
	CarID                int   ,
	DateAcquired         int   ,
	FeatureGroupDimensionId int   ,
	DateSold             int   ,
	AskingPrice          int   ,
	CurrentMileage       float   ,
	OtherDetails         varchar(100)   ,
	CONSTRAINT XPKCarsAcquiredFactTable PRIMARY KEY (CarID ASC,DateAcquired ASC,FeatureGroupDimensionId ASC),
	CONSTRAINT R_11 FOREIGN KEY (DateAcquired) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_12 FOREIGN KEY (DateSold) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_13 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID),
CONSTRAINT R_49 FOREIGN KEY (FeatureGroupDimensionId) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId)
)




CREATE TABLE CarSaleBaseFactTable
( 
	CustomerID           int   ,
	CarID                int   ,
	DateSold             int   ,
	CarFeaturesGroup     int   ,
	AskingPrice          int   ,
	AgreePrice           int   ,
	OtherDetails         varchar(100)   ,
	CurrentMileage       float   ,
	DateAcquired         int   ,
	CONSTRAINT XPKCarSaleBaseFactTable PRIMARY KEY (CustomerID ASC,CarID ASC,DateSold ASC,CarFeaturesGroup ASC),
	CONSTRAINT R_1 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID),
CONSTRAINT R_4 FOREIGN KEY (DateSold) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_5 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
CONSTRAINT R_48 FOREIGN KEY (CarFeaturesGroup) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId),
CONSTRAINT R_58 FOREIGN KEY (DateAcquired) REFERENCES TimeDimension(TimeID)
)


CREATE TABLE Country
(
 CountryID int Primary Key identity(1,1),
 Country_SourceID int,
 CountryName varchar(50)
)


CREATE TABLE StateCountryProvince
(
 StateCountryProvinceID  int Primary Key identity(1,1),
 StateCountryProvince_SourceID int,
 StateCountryProvinceName varchar(50),
 CountryID int,
 CONSTRAINT SCP_1 FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
)

CREATE TABLE TownCity
(
 TownCityID int Primary Key identity(1,1),
 TownCity_SourceID int,
 TownCityName varchar(50),
 StateCountryProvinceID  int,
 CONSTRAINT TC_1 FOREIGN KEY (StateCountryProvinceID) REFERENCES StateCountryProvince(StateCountryProvinceID)
)


CREATE TABLE CustomerAddresses
( 
	AddressID            int   identity(1,1),
	Address_SourceID     int,
	CustomerID           int   ,
	Town_City            varchar(20)   ,
	ZipCode              varchar(20)   ,
	AddressOtherDetails  varchar(200)   ,
	AddressLine1         varchar(50)   ,
	AddressLine2         varchar(50)   ,
	AddressLine3         varchar(50)   ,
	AddressLine4         varchar(50)   ,
	TownCityID           int           ,
	CONSTRAINT XPKCustomerAddresses PRIMARY KEY (AddressID ASC,CustomerID ASC),
	CONSTRAINT R_55 FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT CA_1 FOREIGN KEY (TownCityID) REFERENCES TownCity(TownCityID)
)

CREATE TABLE City_Aggregate
(
 TownCityID int Primary Key,
 TotalCount int,
 CONSTRAINT CA_2 FOREIGN KEY (TownCityID) REFERENCES TownCity(TownCityID)
)

