create database project221;

use project221;

create table WMS_Report(
DATE_TIME datetime,
GII int,
MODULE_TEMP_1 DECIMAL(10,6),
RAIN DECIMAL(10,2),
AMBIENT_TEMPRETURE DECIMAL(10,6)
);

show variables like'secure_file_priv';

LOAD DATA INFILE 'C://Program Files//MySQL//MySQL Server 8.0//Uploads//Dataset_221//WMS Report.xlsx'
INTO TABLE WMS_Report
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

set sql_safe_updates= 0;

SELECT * FROM WMS_Report;

select count(*) from WMS_Report;

create table inverter_data(
DATE_TIME datetime,
unit1_inv1_power DECIMAL(10, 2),     
unit1_inv2_power DECIMAL(10, 2),    
unit2_inv1_power DECIMAL(10, 2),      
unit2_inv2_power DECIMAL(10, 2)
)

select * from inverter_data;

select count(*) from inverter_data;

show variables like'secure_file_priv';

LOAD DATA INFILE 'C://Program Files//MySQL//MySQL Server 8.0//Uploads//Dataset_221//Dataset_221//Inverter dataset.csv'
INTO TABLE inverter_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 3 ROWS;

set sql_safe_updates= 0;

################################# First Moment Business Decision ##############################
# mean 
SELECT AVG(GII) AS mean_GII FROM WMS_Report;

# median
SELECT GII AS median_GII
FROM (
SELECT GII, ROW_NUMBER() OVER (ORDER BY GII) AS row_num,
COUNT(*) OVER () AS total_count
FROM WMS_Report
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

############################### Second Moment Business Decision ################################
# Standard Deviation of Column4
SELECT STDDEV(GII) AS  GII_stddev FROM  WMS_Report;

# range
SELECT MAX(GII) - MIN(GII) AS GII_range FROM WMS_Report;

#variance
SELECT VARIANCE(GII) AS GII_variance FROM WMS_Report ;

################################ Third Moment Business Decision ##################################
#skewness
SELECT (
SUM(POWER(GII- (SELECT AVG(GII) FROM WMS_Report), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(GII) FROM WMS_Report), 3))
) AS skewness
FROM WMS_Report;

################################## Fourth Moment Business Decision #################################
#kurtosis
SELECT (
(SUM(POWER(GII- (SELECT AVG(GII) FROM WMS_Report ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(GII) FROM WMS_Report), 4))) - 3
) AS kurtosis
FROM WMS_Report;    


################################# First Moment Business Decision ##############################
# mean 
SELECT AVG(MODULE_TEMP_1) AS mean_MODULE_TEMP_1 FROM  WMS_Report;

# median
SELECT MODULE_TEMP_1 AS median_MODULE_TEMP_1 
FROM (
SELECT MODULE_TEMP_1, ROW_NUMBER() OVER (ORDER BY MODULE_TEMP_1) AS row_num,
COUNT(*) OVER () AS total_count
FROM  WMS_Report
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

############################### Second Moment Business Decision ################################
# Standard Deviation of Column4
SELECT STDDEV(MODULE_TEMP_1) AS MODULE_TEMP_1_stddev
FROM  WMS_Report;

# range
SELECT MAX(MODULE_TEMP_1) - MIN(MODULE_TEMP_1) AS MODULE_TEMP_1_range
FROM  WMS_Report;

#variance
SELECT VARIANCE(MODULE_TEMP_1) AS MODULE_TEMP_1_variance
FROM  WMS_Report ;

################################ Third Moment Business Decision ##################################
#skewness
SELECT (
SUM(POWER(MODULE_TEMP_1- (SELECT AVG(MODULE_TEMP_1) FROM  WMS_Report), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(MODULE_TEMP_1) FROM  WMS_Report), 3))
) AS skewness
FROM  WMS_Report;

################################ Fourth Moment Business Decision ##################################
#kurtosis
SELECT (
(SUM(POWER(MODULE_TEMP_1- (SELECT AVG(MODULE_TEMP_1) FROM  WMS_Report ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(MODULE_TEMP_1) FROM  WMS_Report), 4))) - 3
) AS kurtosis
FROM  WMS_Report;    

################################ First Moment Business Decision ##################################
# mean 
SELECT AVG(RAIN) AS mean_RAIN
FROM  WMS_Report;

# median
SELECT RAIN AS median_RAIN
FROM (
SELECT RAIN, ROW_NUMBER() OVER (ORDER BY RAIN) AS row_num,
COUNT(*) OVER () AS total_count
FROM  WMS_Report
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

################################ Second Moment Business Decision ##################################
# Standard Deviation of Column4
SELECT STDDEV(RAIN) AS RAIN_stddev
FROM  WMS_Report;

# range
SELECT MAX(RAIN) - MIN(RAIN) AS RAIN_range
FROM  WMS_Report;

#variance
SELECT VARIANCE(RAIN) AS RAIN_variance
FROM  WMS_Report ;

################################ Third Moment Business Decision ##################################
#skewness
SELECT(
SUM(POWER(RAIN- (SELECT AVG(RAIN) FROM  WMS_Report), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(RAIN) FROM  WMS_Report), 3))
) AS skewness
FROM  WMS_Report;

################################ Fourth Moment Business Decision ##################################
#kurtosis
SELECT(
(SUM(POWER(RAIN- (SELECT AVG(RAIN) FROM  WMS_Report), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(RAIN) FROM  WMS_Report), 4))) - 3
) AS kurtosis
FROM  WMS_Report;    

################################ First Moment Business Decision ##################################
# mean 
SELECT AVG(AMBIENT_TEMPRETURE) AS mean_AMBIENT_TEMPRETURE FROM  WMS_Report;

# median
SELECT AMBIENT_TEMPRETURE AS median_AMBIENT_TEMPRETURE 
FROM (
SELECT AMBIENT_TEMPRETURE, ROW_NUMBER() OVER (ORDER BY AMBIENT_TEMPRETURE) AS row_num,
COUNT(*) OVER () AS total_count
FROM  WMS_Report
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

################################ Second Moment Business Decision ##################################
# Standard Deviation of Column4
SELECT STDDEV(AMBIENT_TEMPRETURE) AS AMBIENT_TEMPRETURE_stddev
FROM  WMS_Report;

# range
SELECT MAX(AMBIENT_TEMPRETURE) - MIN(AMBIENT_TEMPRETURE) AS AMBIENT_TEMPRETURE_range
FROM  WMS_Report;

#variance
SELECT VARIANCE(AMBIENT_TEMPRETURE) AS AMBIENT_TEMPRETURE_variance
FROM  WMS_Report ;

################################ Third Moment Business Decision ##################################
#skewness
SELECT(
SUM(POWER(AMBIENT_TEMPRETURE- (SELECT AVG(AMBIENT_TEMPRETURE) FROM  WMS_Report), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(AMBIENT_TEMPRETURE) FROM  WMS_Report), 3))
) AS skewness
FROM  WMS_Report;

################################ Fourth Moment Business Decision ##################################
#kurtosis
SELECT(
(SUM(POWER(AMBIENT_TEMPRETURE- (SELECT AVG(AMBIENT_TEMPRETURE) FROM  WMS_Report ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(AMBIENT_TEMPRETURE) FROM  WMS_Report), 4))) - 3
) AS kurtosis
FROM  WMS_Report;    


################################ First Moment Business Decision ##################################
# mean 
SELECT AVG(unit1_inv1_power) AS mean_unit1_inv1_power
FROM  inverter_data;

# median
SELECT unit1_inv1_power AS median_unit1_inv1_power 
FROM (
SELECT unit1_inv1_power, ROW_NUMBER() OVER (ORDER BY unit1_inv1_power) AS row_num,
COUNT(*) OVER () AS total_count
FROM  inverter_data
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

################################ Second Moment Business Decision ##################################
# Standard Deviation of Column4
SELECT STDDEV(unit1_inv1_power) AS unit1_inv1_power_stddev
FROM  inverter_data;

# range
SELECT MAX(unit1_inv1_power) - MIN(unit1_inv1_power) AS unit1_inv1_power_range
FROM  inverter_data;

#variance
SELECT VARIANCE(unit1_inv1_power) AS unit1_inv1_power_variance
FROM  inverter_data ;

################################ Third Moment Business Decision ##################################
#skewness
SELECT
(
SUM(POWER(unit1_inv1_power- (SELECT AVG(unit1_inv1_power) FROM  inverter_data), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(unit1_inv1_power) FROM  inverter_data), 3))
) AS skewness
FROM  inverter_data;

################################ Fourth Moment Business Decision ##################################
#kurtosis
SELECT(
(SUM(POWER(unit1_inv1_power- (SELECT AVG(unit1_inv1_power) FROM  inverter_data ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(unit1_inv1_power) FROM  inverter_data), 4))) - 3
) AS kurtosis
FROM  inverter_data;    


################################ First Moment Business Decision ##################################
# mean 
SELECT AVG(unit1_inv2_power) AS mean_unit1_inv2_power
FROM inverter_data;

# median
SELECT unit1_inv2_power AS median_unit1_inv2_power
FROM (
SELECT unit1_inv2_power, ROW_NUMBER() OVER (ORDER BY unit1_inv2_power) AS row_num,
COUNT(*) OVER () AS total_count
FROM inverter_data
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;


################################ 2nd Moment Business Decision ##################################
# Standard Deviation of Column4
SELECT STDDEV(unit1_inv2_power) AS unit1_inv2_power_stddev
FROM inverter_data;

# range
SELECT MAX(unit1_inv2_power) - MIN(unit1_inv2_power) AS unit1_inv2_power_range
FROM inverter_data;

#variance
SELECT VARIANCE(unit1_inv2_power) AS unit1_inv2_power_variance
FROM inverter_data ;

################################ Third Moment Business Decision ##################################
#skewness
SELECT
(
SUM(POWER(unit1_inv2_power- (SELECT AVG(unit1_inv2_power) FROM inverter_data), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(unit1_inv2_power) FROM inverter_data), 3))
) AS skewness

FROM inverter_data;

################################ Fourth Moment Business Decision ##################################
#kurtosis
SELECT
(
(SUM(POWER(unit1_inv2_power- (SELECT AVG(unit1_inv2_power) FROM inverter_data ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(unit1_inv2_power) FROM inverter_data), 4))) - 3
) AS kurtosis
FROM inverter_data;    

################################ First Moment Business Decision ##################################
# mean 
SELECT AVG(unit2_inv1_power ) AS mean_unit2_inv1_power 
FROM inverter_data;

# median
SELECT unit2_inv1_power AS median_unit2_inv1_power  
FROM (
SELECT unit2_inv1_power , ROW_NUMBER() OVER (ORDER BY unit2_inv1_power ) AS row_num,
COUNT(*) OVER () AS total_count
FROM inverter_data
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

################################ Second Moment Business Decision ##################################
# Standard Deviation of Column4
SELECT STDDEV(unit2_inv1_power ) AS unit2_inv1_power_stddev
FROM inverter_data;

# range
SELECT MAX(unit2_inv1_power ) - MIN(unit2_inv1_power ) AS unit2_inv1_power_range
FROM inverter_data;

#variance
SELECT VARIANCE(unit2_inv1_power ) AS unit2_inv1_power_variance
FROM inverter_data;

################################ Third Moment Business Decision ##################################
#skewness
SELECT(
SUM(POWER(unit2_inv1_power - (SELECT AVG(unit2_inv1_power ) FROM inverter_data), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(unit2_inv1_power ) FROM inverter_data), 3))
) AS skewness

FROM inverter_data;

################################ Fourth Moment Business Decision ##################################
#kurtosis
SELECT(
(SUM(POWER(unit2_inv1_power - (SELECT AVG(unit2_inv1_power ) FROM inverter_data ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(unit2_inv1_power ) FROM inverter_data), 4))) - 3
) AS kurtosis
FROM inverter_data;    


################################ First Moment Business Decision ##################################
# mean 
SELECT AVG(unit2_inv2_power) AS mean_unit2_inv2_power
FROM inverter_data;

# median
SELECT unit2_inv2_power AS median_unit2_inv2_power 
FROM (
SELECT unit2_inv2_power, ROW_NUMBER() OVER (ORDER BY unit2_inv2_power) AS row_num,
COUNT(*) OVER () AS total_count
FROM inverter_data
) AS subquery
WHERE row_num = (total_count + 1) / 2 OR row_num = (total_count + 2) / 2;

################################ Second Moment Business Decision ##################################
# Standard Deviation of Column4
SELECT STDDEV(unit2_inv2_power) AS unit2_inv2_power_stddev
FROM inverter_data;

# range
SELECT MAX(unit2_inv2_power) - MIN(unit2_inv2_power) AS unit2_inv2_power_range
FROM inverter_data;

#variance
SELECT VARIANCE(unit2_inv2_power) AS unit2_inv2_power_variance
FROM inverter_data;

################################ Third Moment Business Decision ##################################
#skewness
SELECT(
SUM(POWER(unit2_inv2_power- (SELECT AVG(unit2_inv2_power) FROM inverter_data), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(unit2_inv2_power) FROM inverter_data), 3))
) AS skewness

FROM inverter_data;

################################ Foruth Moment Business Decision ##################################
#kurtosis
SELECT(
(SUM(POWER(unit2_inv2_power- (SELECT AVG(unit2_inv2_power) FROM inverter_data ), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(unit2_inv2_power) FROM inverter_data), 4))) - 3
) AS kurtosis
FROM inverter_data;    
