declare @dbname varchar(300);
set @dbname=null;
---------------
select @dbname=name from sys.databases
where name='Car_Parts_DM'

print @dbname

if(@dbname is not null)
begin
use master
drop database Car_Parts_DM;
Create database Car_Parts_DM;
end
else
begin
Create database Car_Parts_DM;
end
go
use Car_Parts_DM
go


CREATE TABLE PartsSupplier
( 
    SupplierID int   identity(1,1) ,
	Supplier_SourceID           int   ,
	SupplierDetails      char(18)   ,
	CONSTRAINT XPKPartsSupplier PRIMARY KEY (SupplierID ASC)
)
go



CREATE TABLE PartsSupplier_Aggregate_Fact_Table
( 
	SupplierID           int  ,
	Count_of_Parts       int   ,
	AverageMileage       float ,
	AverageCondition     float ,
	CONSTRAINT XPKPartsSupplier_Aggregate_Fact_Table PRIMARY KEY (SupplierID ASC),
	CONSTRAINT R_16 FOREIGN KEY (SupplierID) REFERENCES PartsSupplier(SupplierID)
)
go



CREATE TABLE PartsManufacturer
( 
	ManufacturerID       int  identity(1,1)  ,
        Manufacturer_SourceID int,
	ManufacturerName     char(18)   ,
	CONSTRAINT XPKPartsManufacturer PRIMARY KEY (ManufacturerID ASC)
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



CREATE TABLE CarManufacturer
( 
	ManufacturerID       int identity(1,1)   ,
	Manufacturer_SourceID int ,
	ManufacturerName     char(18)   ,
	CONSTRAINT XPKCarManufacturer PRIMARY KEY (ManufacturerID ASC)
)
go



CREATE TABLE CarManufacturer_Aggregate_Fact_Table
( 
	ManufacturerID       int   ,
	Count_of_Parts       int   ,
	AverageMileage       float ,
	AverageCondition     float ,
	CONSTRAINT XPKCarManufacturer_Aggregate_Fact_Table PRIMARY KEY (ManufacturerID ASC),
	CONSTRAINT R_9 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID)
)
go



CREATE TABLE CarPartsDimension
( 
	PartID               int  identity(1,1)  ,
	Part_SourceID        int ,
	PartName             char(18)   ,
	TypeID               int   ,
	TypeName             char(18)   ,
	ManufacturerID       int   ,
	PartLevelID          int   ,
	PartLevelDesc        char(18)   ,
	ParentPartID         int   ,
	SupplierID           int   ,
	CONSTRAINT XPKCarPartsDimension PRIMARY KEY (PartID ASC),
	CONSTRAINT R_13 FOREIGN KEY (ManufacturerID) REFERENCES PartsManufacturer(ManufacturerID),
CONSTRAINT R_14 FOREIGN KEY (SupplierID) REFERENCES PartsSupplier(SupplierID)
)
go



CREATE TABLE CarModel
( 
	ModelID              int identity(1,1)   ,
	ModelName            varchar(50)   ,
	ManufacturerID       int   ,
	CONSTRAINT XPKCarModel PRIMARY KEY (ModelID ASC),
	CONSTRAINT R_11 FOREIGN KEY (ManufacturerID) REFERENCES CarManufacturer(ManufacturerID)
)
go



CREATE TABLE CarDimension
( 
	CarID                int identity(1,1)   ,
	Car_SourceID         int,
	CarName              char(18)   ,
	ModelYear            int,
	ModelID              int   ,
	CONSTRAINT XPKCarDimension PRIMARY KEY (CarID ASC),
	CONSTRAINT R_10 FOREIGN KEY (ModelID) REFERENCES CarModel(ModelID)
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
CONSTRAINT R_12 FOREIGN KEY (CarID) REFERENCES CarDimension(CarID)
)
go

