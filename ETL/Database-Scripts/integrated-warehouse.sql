



alter database Integrated_Warehouse set single_user with rollback immediate
alter database Integrated_Warehouse set MULTI_USER
go

declare @dbname varchar(300);
set @dbname=null;

select @dbname=name from sys.databases
where name='Integrated_Warehouse'

print @dbname

if(@dbname is not null)
begin
use master
drop database Integrated_Warehouse;
Create database Integrated_Warehouse;
end
else
begin
Create database Integrated_Warehouse;
end
go
use Integrated_Warehouse;
go


CREATE TABLE DefectsDimension
( 
	DefectId             int   ,
	DefectDescription    varchar(200)   ,
	CONSTRAINT XPKDefectsDimension PRIMARY KEY (DefectId ASC)
)
go



CREATE TABLE Defects_Aggregate_Fact_table
( 
	DefectId             int   ,
	TotalCount           int   ,
	CONSTRAINT XPKDefects_Aggregate_Fact_table PRIMARY KEY (DefectId ASC),
	CONSTRAINT R_31 FOREIGN KEY (DefectId) REFERENCES DefectsDimension(DefectId)
)
go


CREATE TABLE PartsGroupDimension
( 
	PartsGroupId         int ,
	GroupPath varchar(300),
	CONSTRAINT XPKPartsGroupDimension PRIMARY KEY (PartsGroupId ASC)
)
go



CREATE TABLE PartsManufacturer
( 
    ManufacturerID       int   ,
	ManufacturerSourceID	int,
	ManufacturerName     char(18)   ,
	CONSTRAINT XPKPartsManufacturer PRIMARY KEY (ManufacturerID ASC)
)
go



CREATE TABLE PartsSupplier
( 
	SupplierID           int   ,
	SupplierSourceID	int, 
	SupplierDetails      char(18)   ,
	CONSTRAINT XPKPartsSupplier PRIMARY KEY (SupplierID ASC)
)

CREATE TABLE CarPartsDimension
( 
	PartID               int   identity(1,1),
	PartName             char(18)   ,
	TypeID               int   ,
	TypeName             char(18)   ,
	ManufacturerID       int   ,
	PartLevelID          int   ,
	PartLevelDesc        char(18)   ,
	ParentPartID         int   ,
	SupplierID           int   ,
	OtherDetails         varchar(200)   ,
	PartDescription      varchar(200)   ,
	CONSTRAINT XPKCarPartsDimension PRIMARY KEY (PartID ASC),
	CONSTRAINT R_1311 FOREIGN KEY (ManufacturerID) REFERENCES PartsManufacturer(ManufacturerID),
CONSTRAINT R_14 FOREIGN KEY (SupplierID) REFERENCES PartsSupplier(SupplierID)
)
go



CREATE TABLE PartsGroupDimensionBridge
( 
	PartsGroupId         int   ,
	PartID               int   ,
	CONSTRAINT XPKPartsGroupDimensionBridge PRIMARY KEY (PartsGroupId ASC,PartID ASC),
	CONSTRAINT R_1654 FOREIGN KEY (PartsGroupId) REFERENCES PartsGroupDimension(PartsGroupId),
CONSTRAINT R_270 FOREIGN KEY (PartID) REFERENCES CarPartsDimension(PartID)
)
go



CREATE TABLE MechanicDimension
( 
	MechanicId           int   ,
	MechanicName         varchar(30)   ,
	MechanicDetails      varchar(100)   ,
	CONSTRAINT XPKMechanicDimension PRIMARY KEY (MechanicId ASC)
)
go



CREATE TABLE Mechanic_Aggregate_Fact_Table
( 
	MechanicId           int   ,
	TotalCount           int   ,
	CONSTRAINT XPKMechanic_Aggregate_Fact_Table PRIMARY KEY (MechanicId ASC),
	CONSTRAINT R_30 FOREIGN KEY (MechanicId) REFERENCES MechanicDimension(MechanicId)
)
go



CREATE TABLE PartsManufacturer_Aggergate_Fact_Table
( 
	ManufacturerID       int   ,
	Count_of_Parts       int   ,
	AverageMileage       float ,
	AverageCondition     float ,
	CONSTRAINT XPKPartsManufacturer_Aggergate_Fact_Table PRIMARY KEY (ManufacturerID ASC),
	CONSTRAINT R_15 FOREIGN KEY (ManufacturerID) REFERENCES PartsManufacturer(ManufacturerID)
)
go



CREATE TABLE PartsSupplier_Aggregate_Fact_Table
( 
	SupplierID           int   ,
	Count_of_Parts       int   ,
	AverageMileage       float ,
	AverageCondition     float ,
	CONSTRAINT XPKPartsSupplier_Aggregate_Fact_Table PRIMARY KEY (SupplierID ASC),
	CONSTRAINT R_16 FOREIGN KEY (SupplierID) REFERENCES PartsSupplier(SupplierID)
)
go



CREATE TABLE Defects_Mechanic_Aggregate_Fact_Table
( 
	DefectId             int  ,
	MechanicId           int   ,
	TotalCount           int   ,
	CONSTRAINT XPKDefects_Mechanic_Aggregate_Fact_Table PRIMARY KEY (DefectId ASC,MechanicId ASC),
	CONSTRAINT R_32 FOREIGN KEY (DefectId) REFERENCES DefectsDimension(DefectId),
CONSTRAINT R_33 FOREIGN KEY (MechanicId) REFERENCES MechanicDimension(MechanicId)
)
go



CREATE TABLE Country
( 
	CountryID int Primary Key identity(1,1),
    CountryName varchar(50)
)
go



CREATE TABLE StateCountryProvince
( 
	StateCountryProvinceID  int identity(1,1),
    StateCountryProvinceName varchar(50),
    CountryID int,
	CONSTRAINT XPKStateCountryProvince PRIMARY KEY (StateCountryProvinceID ASC),
	CONSTRAINT R_271 FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
)
go

CREATE TABLE CityTown
( 
	CityTownID           int identity(1,1),
	CityTownName         varchar(50)   ,
	StateCountryProvinceID int ,
	CONSTRAINT XPKCityTown PRIMARY KEY (CityTownID ASC),
	CONSTRAINT R_272 FOREIGN KEY (StateCountryProvinceID) REFERENCES StateCountryProvince(StateCountryProvinceID)
)
go





CREATE TABLE CitySalesAggregate
( 
	CityTownID           int ,
	TotalCount           int ,
	CONSTRAINT XPKCitySalesAggregate PRIMARY KEY (CityTownID ASC),
	CONSTRAINT R_275 FOREIGN KEY (CityTownID) REFERENCES CityTown(CityTownID)
)
go



CREATE TABLE FeatureDimension
( 
	FeatureID            int ,
	FeatureSourceID		 int, 
	FeatureDescription   varchar(200)  ,
	CONSTRAINT XPKFeatureDimension PRIMARY KEY (FeatureID ASC)
)
go



CREATE TABLE Feature_Aggregate_Fact_Table
( 
	FeatureID            int   ,
	TotalCount           int   ,
	CONSTRAINT XPKFeature_Aggregate_Fact_Table PRIMARY KEY (FeatureID ASC),
	CONSTRAINT R_71 FOREIGN KEY (FeatureID) REFERENCES FeatureDimension(FeatureID)
)
go



CREATE TABLE PartsUsageAggregateFact
( 
	PartID               int ,
	TotalCount           int ,
	CONSTRAINT XPKPartsUsageAggregateFact PRIMARY KEY (PartID ASC),
	CONSTRAINT R_28 FOREIGN KEY (PartID) REFERENCES CarPartsDimension(PartID)
)
go



CREATE TABLE FeatureGroupDimension
( 
	FeatureGroupDimensionId int ,
	FeatureGroupPath varchar(300),
	CONSTRAINT XPKFeatureGroupDimension PRIMARY KEY (FeatureGroupDimensionId ASC)
)
go



CREATE TABLE FeatureGroupDimensionBridge
( 
	FeatureGroupDimensionId int ,
	FeatureID            int  ,
	CONSTRAINT XPKFeatureGroupDimensionBridge PRIMARY KEY (FeatureGroupDimensionId ASC,FeatureID ASC),
	CONSTRAINT R_45 FOREIGN KEY (FeatureGroupDimensionId) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId),
CONSTRAINT R_72 FOREIGN KEY (FeatureID) REFERENCES FeatureDimension(FeatureID)
)
go



CREATE TABLE MechanicGroupDimension
( 
	MechanicGroup        int ,
	GroupPath varchar(300),
	CONSTRAINT XPKMechanicGroupDimension PRIMARY KEY (MechanicGroup ASC)
)
go



CREATE TABLE MechanicGroupDimensionBridge
( 
	MechanicGroup        int ,
	MechanicId           int ,
	CONSTRAINT XPKMechanicGroupDimensionBridge PRIMARY KEY (MechanicGroup ASC,MechanicId ASC),
	CONSTRAINT R_17 FOREIGN KEY (MechanicGroup) REFERENCES MechanicGroupDimension(MechanicGroup),
CONSTRAINT R_23 FOREIGN KEY (MechanicId) REFERENCES MechanicDimension(MechanicId)
)
go



CREATE TABLE DefectsGroupDimension
( 
	DefectsGroupId       int ,
	GroupPath varchar(300),
	CONSTRAINT XPKDefectsGroupDimension PRIMARY KEY (DefectsGroupId ASC)
)
go



CREATE TABLE DefectsGroupDimensionBridge
( 
	DefectsGroupId       int ,
	DefectId             int ,
	CONSTRAINT XPKDefectsGroupDimensionBridge PRIMARY KEY (DefectsGroupId ASC,DefectId ASC),
	CONSTRAINT R_9 FOREIGN KEY (DefectsGroupId) REFERENCES DefectsGroupDimension(DefectsGroupId),
CONSTRAINT R_21 FOREIGN KEY (DefectId) REFERENCES DefectsDimension(DefectId)
)
go



CREATE TABLE CarManufacturer
( 
	ManufacturerID       int   identity(1,1),
	ManufacturerName	varchar(30),
	ManufacturerShortName varchar(30),
	ManufacturerOtherDetails varchar(200)   ,
	CONSTRAINT XPKCarManufacturer PRIMARY KEY (ManufacturerID ASC)
)
go



CREATE TABLE CarModel
( 
	ModelCode           int   identity(1,1),
	ModelName            varchar(30)   ,
	ManufacturerID       int   ,
	OtherModelDetails    varchar(200)   ,
	CONSTRAINT XPKCarModel PRIMARY KEY (ModelCode ASC),
	CONSTRAINT R_61 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID)
)
go



CREATE TABLE CarDimension
( 
	CarID                int identity(1,1),
	CarName              varchar(50) ,
	ModelCode            int ,
	ModelYear            int,
	CONSTRAINT XPKCarDimension PRIMARY KEY (CarID ASC),
	CONSTRAINT R_10 FOREIGN KEY (ModelCode) REFERENCES CarModel(ModelCode)
)
go



CREATE TABLE Year
( 
	YearID               int   identity(1,1),
	YearName            int  ,
	CONSTRAINT XPKYear PRIMARY KEY (YearID ASC)
)
go



CREATE TABLE Quarter
( 
	QuarterID            int   identity(1,1),
	QuarterName          int  ,
	YearID               int   ,
	CONSTRAINT XPKQuarter PRIMARY KEY (QuarterID ASC),
	CONSTRAINT R_26 FOREIGN KEY (YearID) REFERENCES Year(YearID)
)
go



CREATE TABLE Month
( 
    MonthID              int  identity(1,1) ,
	MonthName            int  ,
	QuarterID            int   ,
	CONSTRAINT XPKMonth PRIMARY KEY (MonthID ASC),
	CONSTRAINT R_25 FOREIGN KEY (QuarterID) REFERENCES Quarter(QuarterID)
)
go



CREATE TABLE TimeDimension
( 
	TimeID               int   identity(1,1),
	DayName              int,
	MonthID              int   ,
	CONSTRAINT XPKTimeDimension PRIMARY KEY (TimeID ASC),
	CONSTRAINT R_24 FOREIGN KEY (MonthID) REFERENCES Month(MonthID)
)
go



CREATE TABLE CustomerDimension
( 
	CustomerID           int  identity(1,1) ,
	CustomerMobilePhone  char(11)   ,
	CustomerEmailAddress varchar(100)   ,
	FeatureGroupDimensionId  int   ,
	FirstName            varchar(18)  ,
	Gender               varchar(6) ,
	LastName             varchar(18) ,
	MiddleName           varchar(18) ,
	OtherDetails        varchar(200) ,
	CONSTRAINT XPKCustomerDimension PRIMARY KEY (CustomerID ASC),
	CONSTRAINT R_57 FOREIGN KEY (FeatureGroupDimensionId) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId)
)
go



CREATE TABLE ServiceBaseFactTable
( 
	CarID                int ,
	CustomerID           int ,
	Date                 int ,
	DefectsGroupId       int ,
	PartsGroupId         int ,
	MechanicGroup        int ,
	EngineSize           int  ,
	CurrentMileage       float ,
	OtherDetails         varchar(200)  ,
	CONSTRAINT XPKServiceBaseFactTable PRIMARY KEY (CarID ASC,CustomerID ASC,Date ASC,DefectsGroupId ASC,PartsGroupId ASC,MechanicGroup ASC),
	CONSTRAINT R_2222 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID),
CONSTRAINT R_3 FOREIGN KEY (Date) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_8 FOREIGN KEY (CustomerID) REFERENCES CustomerDimension(CustomerID),
CONSTRAINT R_1221 FOREIGN KEY (DefectsGroupId) REFERENCES DefectsGroupDimension(DefectsGroupId),
CONSTRAINT R_1667 FOREIGN KEY (PartsGroupId) REFERENCES PartsGroupDimension(PartsGroupId),
CONSTRAINT R_20 FOREIGN KEY (MechanicGroup) REFERENCES MechanicGroupDimension(MechanicGroup)
)
go



CREATE TABLE CityServiceAggregate
( 
	CityTownID           int,
	TotalCount           int ,
	CONSTRAINT XPKCityServiceAggregate PRIMARY KEY (CityTownID ASC),
	CONSTRAINT R_274 FOREIGN KEY (CityTownID) REFERENCES CityTown(CityTownID)
)
go



CREATE TABLE ManufacturerServiceAggregateFact
( 
	ManufacturerID       int,
	TotalCount           int  NULL ,
	CONSTRAINT XPKManufacturerServiceAggregateFact PRIMARY KEY (ManufacturerID ASC),
	CONSTRAINT R_27 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID)
)
go



CREATE TABLE Parts_AvailabilitySnapshotTable
( 
	TimeID               int   ,
	PartID               int   ,
	NumberInStock        int  ,
	CONSTRAINT XPKParts_AvailabilitySnapshotTable PRIMARY KEY (TimeID ASC,PartID ASC),
	CONSTRAINT R_6 FOREIGN KEY (TimeID) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_2121 FOREIGN KEY (PartID) REFERENCES CarPartsDimension(PartID)
)
go



CREATE TABLE CarManufacturerPartsAggregateFact
( 
	ManufacturerID       int ,
	Count_of_Parts       int ,
	AverageCondition     float ,
	AverageMileage       float ,
	CONSTRAINT XPKCarManufacturerPartsAggregateFact PRIMARY KEY (ManufacturerID ASC),
	CONSTRAINT R_999 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID)
)
go



CREATE TABLE CarPartsBaseFact
( 
	PartID               int   ,
	CarID                int   ,
	Weight               char(18)   ,
	Condition            char(18)   ,
	MileageOfDoner       char(18)   ,
	OtherDescription     char(18)   ,
	CONSTRAINT XPKCarPartsBaseFact PRIMARY KEY (PartID ASC,CarID ASC),
	CONSTRAINT R_2 FOREIGN KEY (PartID) REFERENCES CarPartsDimension(PartID),
CONSTRAINT R_1233 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID)
)
go



CREATE TABLE CarServiceAggregateFact
( 
	CarID                int ,
	TotalCount           int ,
	CONSTRAINT XPKCarServiceAggregateFact PRIMARY KEY (CarID ASC),
	CONSTRAINT R_29 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID)
)
go



CREATE TABLE Manufacturer_Aggregate_Fact_Table
( 
	ManufacturerID       int ,
	MonthId              int,
	AverageAskingPrice   float,
	AverageAgreePrice    float ,
	TotalCount           int,
	CONSTRAINT XPKManufacturer_Aggregate_Fact_Table PRIMARY KEY (ManufacturerID ASC,MonthId ASC),
	CONSTRAINT R_67 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID),
CONSTRAINT R_68 FOREIGN KEY (MonthiD) REFERENCES  Month(MonthID)
)
go



CREATE TABLE Car_Aggregate_Fact_Table
( 
	CarID                int ,
	TotalCustomer        int ,
	CONSTRAINT XPKCar_Aggregate_Fact_Table PRIMARY KEY (CarID ASC),
	CONSTRAINT R_70 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID)
)
go



CREATE TABLE CarCategory
( 
	CategoryCode int   ,
	CategoryDescription  varchar(30)   ,
	PRIMARY KEY (CategoryCode)
)
go



CREATE TABLE Category_Aggregate_Fact_Table
( 
	CategoryCode         int ,
	MonthID            int,
	AverageAskingPrice   float ,
	AverageAgreePrice    float ,
	TotalCount           int ,
	CONSTRAINT XPKCategory_Aggregate_Fact_Table PRIMARY KEY (CategoryCode ASC,MonthID ASC),
	CONSTRAINT R_727 FOREIGN KEY (CategoryCode) REFERENCES CarCategory(CategoryCode),
CONSTRAINT R_73 FOREIGN KEY (MonthID) REFERENCES Month(MonthID)
)
go



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
go



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
CONSTRAINT R_5 FOREIGN KEY (CustomerID) REFERENCES CustomerDimension(CustomerID),
CONSTRAINT R_48 FOREIGN KEY (CarFeaturesGroup) REFERENCES FeatureGroupDimension(FeatureGroupDimensionId),
CONSTRAINT R_58 FOREIGN KEY (DateAcquired) REFERENCES TimeDimension(TimeID)
)
go



CREATE TABLE CustomerAddresses
( 
	AddressID            int identity(1,1),
	CustomerID           int,
	ZipCode              varchar(20)   ,
	AddressOtherDetails  varchar(200)   ,
	AddressLine1         varchar(50)   ,
	AddressLine2         varchar(50)   ,
	AddressLine3         varchar(50)   ,
	AddressLine4         varchar(50)   , 
	CityTownID           int,
	CONSTRAINT XPKCustomerAddresses PRIMARY KEY (AddressID ASC,CustomerID ASC),
	CONSTRAINT R_55 FOREIGN KEY (CustomerID) REFERENCES CustomerDimension(CustomerID),
CONSTRAINT R_273 FOREIGN KEY (CityTownID) REFERENCES CityTown(CityTownID)
)
go



