use project221;

create table WMS_Report(
DATE_TIME datetime,
GII int,
MODULE_TEMP_1 DECIMAL(10,6),
RAIN DECIMAL(10,2),
AMBIENT_TEMPRETURE DECIMAL(10,6)
);

SELECT * FROM WMS_Report;

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C://Program Files//MySQL//MySQL Server 8.0//Uploads//Dataset_221//WMS Report.xlsx'
INTO TABLE WMS_Report
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select count(*) from WMS_Report;

create table inverter_data(
DATE_TIME datetime,
unit1_inv1_power DECIMAL(10, 2),     
unit1_inv2_power DECIMAL(10, 2),    
unit2_inv1_power DECIMAL(10, 2),      
unit2_inv2_power DECIMAL(10, 2)
)

select * from inverter_data;

LOAD DATA INFILE '‪C://Program Files//MySQL//MySQL Server 8.0//Uploads//Dataset_221//Dataset_221//Inverter dataset.csv'
INTO TABLE inverter_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 3 ROWS;

select count(*) from inverter_data;

set sql_safe_updates= 0;

describe WMS_Report;

describe inverter_data;

##################################### Type casting

SELECT CAST(AMBIENT_TEMPRETURE AS float ) AS AMBIENT_TEMPRETURE_float FROM WMS_Report;


##################################### Duplicate row identification WMS_ report data

select DATE_TIME,GII,MODULE_TEMP_1,RAIN,AMBIENT_TEMPRETURE, count(*) as duplicate_count
from WMS_Report
group by  DATE_TIME,GII,MODULE_TEMP_1,RAIN,AMBIENT_TEMPRETURE
HAVING COUNT(*)>1;                                        # 5000 rows found duplicate

### Drop duplicates
CREATE TABLE temp_data AS
SELECT DISTINCT *
FROM WMS_Report;

TRUNCATE TABLE WMS_Report ;

INSERT INTO WMS_Report
SELECT * FROM temp_data;

DROP TABLE temp_data;

select count(*) from  WMS_Report;
#### Number of rows return 45600

############################## Duplicate row identification inverter_data

select DATE_TIME,unit1_inv1_power,unit1_inv2_power,unit2_inv1_power,unit2_inv2_power, count(*) as duplicate_count
from inverter_data
group by DATE_TIME,unit1_inv1_power,unit1_inv2_power,unit2_inv1_power,unit2_inv2_power
HAVING COUNT(*)>1; # no duplicate row found

################################# DROPING COLUMN WITH 0 VALUES

create table WMS_temp_data as select * from WMS_Report;

select * from WMS_temp_data;

alter table  WMS_temp_data
drop column RAIN;

describe  WMS_temp_data;


############################## Missing Values Wms_Report
SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN DATE_TIME IS NULL THEN 1 ELSE 0 END) AS DATE_TIME_missing,
SUM(CASE WHEN GII IS NULL THEN 1 ELSE 0 END) AS GII_missing,
SUM(CASE WHEN MODULE_TEMP_1 IS NULL THEN 1 ELSE 0 END) AS  MODULE_TEMP_1_missing,
SUM(CASE WHEN AMBIENT_TEMPRETURE IS NULL THEN 1 ELSE 0 END) AS AMBIENT_TEMPRETURE_missing 
from  WMS_temp_data; # no missing values

##############################Missing Values inverter data
SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN unit1_inv1_power IS NULL THEN 1 ELSE 0 END) AS unit1_inv1_power_missing,
SUM(CASE WHEN unit1_inv2_power IS NULL THEN 1 ELSE 0 END) AS unit1_inv2_power_missing,
SUM(CASE WHEN unit2_inv1_power IS NULL THEN 1 ELSE 0 END) AS unit2_inv1_power_1_missing,
SUM(CASE WHEN unit2_inv2_power IS NULL THEN 1 ELSE 0 END) AS unit2_inv2_power_missing 
from inverter_data; # No missing values


###################################Outliers Treatment WMS_data

WITH Ordered AS (
    SELECT   GII, ROW_NUMBER() OVER (ORDER BY GII) AS row_num, COUNT(*) OVER () AS total_rows
    FROM  WMS_temp_data ),
Quartiles AS (
    SELECT GII, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN GII ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN GII ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM  WMS_temp_data CROSS JOIN IQR_Calculation
WHERE GII < (Q1 - 1.5 * IQR) OR  GII > (Q3 + 1.5 * IQR)
)
UPDATE  WMS_temp_data
CROSS JOIN IQR_Calculation
SET GII = (Q1 + Q3) / 2  -- Replacing with median
WHERE GII < (Q1 - 1.5 * IQR) OR  GII > (Q3 + 1.5 * IQR);


WITH Ordered AS (
    SELECT  MODULE_TEMP_1, ROW_NUMBER() OVER (ORDER BY MODULE_TEMP_1) AS row_num, COUNT(*) OVER () AS total_rows
    FROM WMS_temp_data ),
Quartiles AS (
    SELECT  MODULE_TEMP_1, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN MODULE_TEMP_1 ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN MODULE_TEMP_1 ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM WMS_temp_data CROSS JOIN IQR_Calculation
WHERE MODULE_TEMP_1 < (Q1 - 1.5 * IQR) OR MODULE_TEMP_1 > (Q3 + 1.5 * IQR)
)
UPDATE WMS_temp_data
CROSS JOIN IQR_Calculation
SET MODULE_TEMP_1 = (Q1 + Q3) / 2  -- Replacing with median
WHERE MODULE_TEMP_1 < (Q1 - 1.5 * IQR) OR MODULE_TEMP_1 > (Q3 + 1.5 * IQR); ## 677 rows changed with median values


WITH Ordered AS (
    SELECT  AMBIENT_TEMPRETURE, ROW_NUMBER() OVER (ORDER BY AMBIENT_TEMPRETURE) AS row_num, COUNT(*) OVER () AS total_rows
    FROM WMS_temp_data ),
Quartiles AS (
    SELECT AMBIENT_TEMPRETURE, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN AMBIENT_TEMPRETURE ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN AMBIENT_TEMPRETURE ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM WMS_temp_data CROSS JOIN IQR_Calculation
WHERE AMBIENT_TEMPRETURE < (Q1 - 1.5 * IQR) OR AMBIENT_TEMPRETURE > (Q3 + 1.5 * IQR)
)
UPDATE WMS_temp_data
CROSS JOIN IQR_Calculation
SET AMBIENT_TEMPRETURE = (Q1 + Q3) / 2  -- Replacing with median
WHERE AMBIENT_TEMPRETURE < (Q1 - 1.5 * IQR) OR AMBIENT_TEMPRETURE > (Q3 + 1.5 * IQR);



################################# Outliers Treatment inverter data
WITH Ordered AS (
    SELECT  unit1_inv1_power, ROW_NUMBER() OVER (ORDER BY unit1_inv1_power) AS row_num, COUNT(*) OVER () AS total_rows
    FROM inverter_data),
Quartiles AS (
    SELECT unit1_inv1_power, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN unit1_inv1_power ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN unit1_inv1_power ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM inverter_data CROSS JOIN IQR_Calculation
WHERE unit1_inv1_power < (Q1 - 1.5 * IQR) OR unit1_inv1_power > (Q3 + 1.5 * IQR)
)
UPDATE inverter_data
CROSS JOIN IQR_Calculation
SET unit1_inv1_power = (Q1 + Q3) / 2  -- Replacing with median
WHERE unit1_inv1_power < (Q1 - 1.5 * IQR) OR unit1_inv1_power > (Q3 + 1.5 * IQR); ## no outliers


WITH Ordered AS (
    SELECT  unit1_inv2_power, ROW_NUMBER() OVER (ORDER BY unit1_inv2_power) AS row_num, COUNT(*) OVER () AS total_rows
    FROM inverter_data ),
Quartiles AS (
    SELECT unit1_inv2_power, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN unit1_inv2_power ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN unit1_inv2_power ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM inverter_data CROSS JOIN IQR_Calculation
WHERE unit1_inv2_power < (Q1 - 1.5 * IQR) OR unit1_inv2_power > (Q3 + 1.5 * IQR)
)
UPDATE inverter_data
CROSS JOIN IQR_Calculation
SET unit1_inv2_power = (Q1 + Q3) / 2  -- Replacing with median
WHERE unit1_inv2_power < (Q1 - 1.5 * IQR) OR unit1_inv2_power > (Q3 + 1.5 * IQR); # no outliers



WITH Ordered AS (
    SELECT  unit2_inv1_power, ROW_NUMBER() OVER (ORDER BY unit2_inv1_power) AS row_num, COUNT(*) OVER () AS total_rows
    FROM inverter_data ),
Quartiles AS (
    SELECT unit2_inv1_power, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN unit2_inv1_power ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN unit2_inv1_power ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM inverter_data CROSS JOIN IQR_Calculation
WHERE unit2_inv1_power < (Q1 - 1.5 * IQR) OR unit2_inv1_power> (Q3 + 1.5 * IQR)
)
UPDATE inverter_data
CROSS JOIN IQR_Calculation
SET unit2_inv1_power= (Q1 + Q3) / 2  -- Replacing with median
WHERE unit2_inv1_power < (Q1 - 1.5 * IQR) OR unit2_inv1_power > (Q3 + 1.5 * IQR); # no outliers


WITH Ordered AS (
    SELECT  unit2_inv2_power, ROW_NUMBER() OVER (ORDER BY unit2_inv2_power) AS row_num, COUNT(*) OVER () AS total_rows
    FROM inverter_data ),
Quartiles AS (
    SELECT unit2_inv2_power, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN unit2_inv2_power ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN unit2_inv2_power ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM inverter_data CROSS JOIN IQR_Calculation
WHERE unit2_inv2_power < (Q1 - 1.5 * IQR) OR unit2_inv2_power > (Q3 + 1.5 * IQR)
)
UPDATE inverter_data
CROSS JOIN IQR_Calculation
SET unit2_inv2_power = (Q1 + Q3) / 2  -- Replacing with median
WHERE unit2_inv2_power < (Q1 - 1.5 * IQR) OR unit2_inv2_power> (Q3 + 1.5 * IQR); # No outliers 
