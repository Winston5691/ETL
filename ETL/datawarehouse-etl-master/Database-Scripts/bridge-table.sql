use testdb
go
WITH CTE AS (
SELECT SaleID
, PersonID
, STUFF(
 (SELECT '.' + PersonID
 FROM Test a
 WHERE a.saleID = b.SaleID
 ORDER BY PersonID
 FOR XML PATH('')
 ),1,1,'') as TeamPath
FROM Test b)
SELECT DISTINCT
   DENSE_RANK() OVER (ORDER BY TeamPath ) AS SalesTeamID
, PersonID
FROM CTE
ORDER BY SalesTeamID

select * from test


use car_sales
go
WITH CTE AS (
SELECT car_for_sale_ID
, car_feature_ID
, STUFF(
 (SELECT '.' + CONVERT(varchar(10), car_feature_ID)
 FROM feature_on_cars_for_sale a
 WHERE a.car_for_sale_ID = b.car_for_sale_ID
 ORDER BY car_feature_ID
 FOR XML PATH('')
 ),1,1,'') as TeamPath
FROM feature_on_cars_for_sale b)
SELECT DISTINCT
   DENSE_RANK() OVER (ORDER BY TeamPath ) AS FeatureGroupId
,TeamPath
FROM CTE
ORDER BY FeatureGroupId


SELECT DISTINCT STUFF(
 (SELECT '.' + CONVERT(varchar(10), car_feature_ID)
 FROM feature_on_cars_for_sale a
 WHERE a.car_for_sale_ID = b.car_for_sale_ID
 ORDER BY car_feature_ID
 FOR XML PATH('')
 ),1,1,'') as FeaturePath
FROM feature_on_cars_for_sale b
union
SELECT DISTINCT STUFF(
 (SELECT '.' + CONVERT(varchar(10), car_feature_ID)
 FROM customer_preferences a
 WHERE a.customer_id = b.customer_id
 ORDER BY car_feature_ID
 FOR XML PATH('')
 ),1,1,'') as FeaturePath
FROM customer_preferences b

select * from feature_on_cars_for_sale

use car_sales
go
SELECT DISTINCT STUFF(
 (SELECT '.' + CONVERT(varchar(10), car_feature_ID)
 FROM feature_on_cars_for_sale a
 WHERE a.car_for_sale_ID = b.car_for_sale_ID
 ORDER BY car_feature_ID
 FOR XML PATH('')
 ),1,1,'') as FeaturePath
FROM feature_on_cars_for_sale b

use car_sales_dm
select * from featuregroupdimension
use car_sales_dm

SELECT convert(int, FeatureGroupDimensionId) as FeatureGroupDimensionId, convert(int, value) as FeatureGroupPath
FROM featuregroupdimension
CROSS APPLY STRING_SPLIT(FeatureGroupPath, '.');