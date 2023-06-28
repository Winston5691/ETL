declare @dbname varchar(300);
set @dbname=null;

select @dbname=name from sys.databases
where name='Car_Service_DM'

print @dbname

if(@dbname is not null)
begin
use master
drop database Car_Service_DM;
Create database Car_Service_DM;
end
else
begin
Create database Car_Service_DM;
end
go
use Car_Service_DM;
go

CREATE TABLE MechanicGroupDimension
( 
    MechanicGroup        int identity(1,1)  ,
    MechanicGroupPath    varchar(100),
    CONSTRAINT XPKMechanicGroupDimension PRIMARY KEY (MechanicGroup ASC)
)
go



CREATE TABLE MechanicDimension
( 
    MechanicId           int  identity(1,1) ,
    MechanicSourceId     int,
    MechanicName         varchar(30)   ,
    MechanicDetails      varchar(100)   ,
    CONSTRAINT XPKMechanicDimension PRIMARY KEY (MechanicId ASC)
)
go



CREATE TABLE MechanicGroupBridge
( 
    MechanicGroup        int   ,
    MechanicId           int   ,
    CONSTRAINT XPKMechanicGroupBridge PRIMARY KEY (MechanicGroup ASC,MechanicId ASC),
    CONSTRAINT R_17 FOREIGN KEY (MechanicGroup) REFERENCES MechanicGroupDimension(MechanicGroup),
CONSTRAINT R_19 FOREIGN KEY (MechanicId) REFERENCES MechanicDimension(MechanicId)
)
go



CREATE TABLE PartsGroupDimension
( 
    PartsGroupId         int  identity(1,1) ,
    PartsGroupPath       varchar(100),
    CONSTRAINT XPKPartsGroupDimension PRIMARY KEY (PartsGroupId ASC)
)
go



CREATE TABLE PartsDimension
( 
    PartId               int   identity(1,1),
    PartSourceID         int,
    PartName             varchar(30)   ,
    PartDescription      varchar(100)   ,
    OtherDetails         varchar(200)   ,
    CONSTRAINT XPKPartsDimension PRIMARY KEY (PartId ASC)
)
go



CREATE TABLE PartsGroupBridgeTable
( 
    PartsGroupId         int   ,
    PartId               int   ,
    CONSTRAINT XPKPartsGroupBridgeTable PRIMARY KEY (PartsGroupId ASC,PartId ASC),
    CONSTRAINT R_13 FOREIGN KEY (PartsGroupId) REFERENCES PartsGroupDimension(PartsGroupId),
CONSTRAINT R_15 FOREIGN KEY (PartId) REFERENCES PartsDimension(PartId)
)
go



CREATE TABLE DefectsGroupDimension
( 
    DefectsGroupId       int identity(1,1)  ,
    DefectsGroupPath     varchar(100),
    CONSTRAINT XPKDefectsGroupDimension PRIMARY KEY (DefectsGroupId ASC)
)
go



CREATE TABLE DefectsDimension
( 
    DefectId             int  identity(1,1) ,
    DefectSourceId       int,
    DefectDescription    varchar(200)   ,
    CONSTRAINT XPKDefectsDimension PRIMARY KEY (DefectId ASC)
)
go



CREATE TABLE DefectsGroupDimensionBridge
( 
    DefectsGroupId       int   ,
    DefectId             int   ,
    CONSTRAINT XPKDefectsGroupDimensionBridge PRIMARY KEY (DefectsGroupId ASC,DefectId ASC),
    CONSTRAINT R_9 FOREIGN KEY (DefectsGroupId) REFERENCES DefectsGroupDimension(DefectsGroupId),
CONSTRAINT R_11 FOREIGN KEY (DefectId) REFERENCES DefectsDimension(DefectId)
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



CREATE TABLE Defects_Aggregate_Fact_table
( 
    DefectId             int   ,
    TotalCount           int   ,
    CONSTRAINT XPKDefects_Aggregate_Fact_table PRIMARY KEY (DefectId ASC),
    CONSTRAINT R_31 FOREIGN KEY (DefectId) REFERENCES DefectsDimension(DefectId)
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



CREATE TABLE CarManufacturer
( 
    ManufacturerCode     int  identity(1,1) ,
    ManufacturerName     varchar(30)   ,
    ManufacturerDetails  varchar(200)   ,
    CONSTRAINT XPKCarManufacturer PRIMARY KEY (ManufacturerCode ASC)
)
go



CREATE TABLE CarModel
( 
    ModelCode            int   identity(1,1),
    ModelName            varchar(30)   ,
    OtherModelDetails    varchar(200)   ,
    ManufacturerCode     int   ,
    CONSTRAINT XPKCarModel PRIMARY KEY (ModelCode ASC),
    CONSTRAINT R_23 FOREIGN KEY (ManufacturerCode) REFERENCES CarManufacturer(ManufacturerCode)
         
         
)
go



CREATE TABLE CarDimension
( 
    CarID                int   identity(1,1),
    CarName              varchar(30)   ,
    ModelCode            int   ,
    CONSTRAINT XPKCarDimension PRIMARY KEY (CarID ASC),
    CONSTRAINT R_22 FOREIGN KEY (ModelCode) REFERENCES CarModel(ModelCode)
         
         
)
go



CREATE TABLE CarServiceAggregateFact
( 
    CarID                int   ,
    TotalCount           int   ,
    CONSTRAINT XPKCarServiceAggregateFact PRIMARY KEY (CarID ASC),
    CONSTRAINT R_29 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID)
)
go



CREATE TABLE Parts_Aggregate_Fact_Table
( 
    PartId               int   ,
    TotalCount           int   ,
    CONSTRAINT XPKParts_Aggregate_Fact_Table PRIMARY KEY (PartId ASC),
    CONSTRAINT R_28 FOREIGN KEY (PartId) REFERENCES PartsDimension(PartId)
)
go



CREATE TABLE ManufacturerServiceAggregateFact
( 
    ManufacturerCode     int   ,
    TotalCount           int   ,
    CONSTRAINT XPKManufacturerServiceAggregateFact PRIMARY KEY (ManufacturerCode ASC),
    CONSTRAINT R_27 FOREIGN KEY (ManufacturerCode) REFERENCES CarManufacturer(ManufacturerCode)
)
go



CREATE TABLE Year
( 
    YearID               int  identity(1,1)  ,
    YearName             int  ,
    CONSTRAINT XPKYear PRIMARY KEY (YearID ASC)
)
go



CREATE TABLE Quarter
( 
    QuarterID            int identity(1,1)  ,
    QuarterName          int  ,
    YearID               int   ,
    CONSTRAINT XPKQuarter PRIMARY KEY (QuarterID ASC),
    CONSTRAINT R_26 FOREIGN KEY (YearID) REFERENCES Year(YearID)
         
         
)
go



CREATE TABLE Month
( 
    MonthID              int identity(1,1)  ,
    MonthName            int  ,
    QuarterID            int   ,
    CONSTRAINT XPKMonth PRIMARY KEY (MonthID ASC),
    CONSTRAINT R_25 FOREIGN KEY (QuarterID) REFERENCES Quarter(QuarterID)
         
         
)
go



CREATE TABLE TimeDimension
( 
    TimeID               int identity(1,1)  ,
    DayName              int   ,
    MonthID              int   ,
    CONSTRAINT XPKTimeDimension PRIMARY KEY (TimeID ASC),
    CONSTRAINT R_24 FOREIGN KEY (MonthID) REFERENCES Month(MonthID)
         
         
)
go



CREATE TABLE Parts_AvailabilitySnapshotTable
( 
    TimeID               int   ,
    PartId               int   ,
    NumberInStock        int  ,
    CONSTRAINT XPKParts_AvailabilitySnapshotTable PRIMARY KEY (TimeID ASC,PartId ASC),
    CONSTRAINT R_6 FOREIGN KEY (TimeID) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_21 FOREIGN KEY (PartId) REFERENCES PartsDimension(PartId)
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
 StateCountryProvinceID  int Primary Key identity(1,1),
 StateCountryProvinceName varchar(50),
 CountryID int,
 CONSTRAINT SCP_1 FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
)
go
CREATE TABLE TownCity
(
 TownCityID int Primary Key identity(1,1),
 TownCityName varchar(50),
 StateCountryProvinceID  int,
 CONSTRAINT TC_1 FOREIGN KEY (StateCountryProvinceID) REFERENCES StateCountryProvince(StateCountryProvinceID)
)
go

CREATE TABLE CustomerDimension
( 
    CustomerID           int  identity(1,1) ,
    Customer_sourceID    int,
    FirstName            varchar(18)   ,
    MiddleName           varchar(18)   ,
    LastName             varchar(18)   ,
    Gender               varchar(6)   ,
    EmailAddress         varchar(100)   ,
    PhoneNumber          char(11)   ,
    AddressLine1         varchar(50)   ,
    AddressLine2         varchar(50)   ,
    AddressLine3         varchar(50)   ,
    AddressLine4         varchar(50)   ,
    OtherDetails         varchar(200)   ,
    TownCityID           int            ,
    CONSTRAINT CD_1 FOREIGN KEY (TownCityID) REFERENCES TownCity(TownCityID),
    CONSTRAINT XPKCustomerDimension PRIMARY KEY (CustomerID ASC)
)
go


CREATE TABLE City_Aggregate
(
 TownCityID int Primary Key,
 TotalNumberOfServices int,
 CONSTRAINT CA_2 FOREIGN KEY (TownCityID) REFERENCES TownCity(TownCityID)
)

go

CREATE TABLE Service_Fact_Table
( 
    CarID                int   ,
    CustomerID           int   ,
    Date                 int   ,
    DefectsGroupId       int   ,
    PartsGroupId         int   ,
    MechanicGroup        int   ,
    EngineSize           int   ,
    CurrentMileage       int   ,
    OtherDetails         varchar(200)   ,
    CONSTRAINT XPKService_Fact_Table PRIMARY KEY (CarID ASC,CustomerID ASC,Date ASC,DefectsGroupId ASC,PartsGroupId ASC,MechanicGroup ASC),
    CONSTRAINT R_2 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID),
CONSTRAINT R_3 FOREIGN KEY (Date) REFERENCES TimeDimension(TimeID),
CONSTRAINT R_8 FOREIGN KEY (CustomerID) REFERENCES CustomerDimension(CustomerID),
CONSTRAINT R_12 FOREIGN KEY (DefectsGroupId) REFERENCES DefectsGroupDimension(DefectsGroupId),
CONSTRAINT R_16 FOREIGN KEY (PartsGroupId) REFERENCES PartsGroupDimension(PartsGroupId),
CONSTRAINT R_20 FOREIGN KEY (MechanicGroup) REFERENCES MechanicGroupDimension(MechanicGroup)
)
go

