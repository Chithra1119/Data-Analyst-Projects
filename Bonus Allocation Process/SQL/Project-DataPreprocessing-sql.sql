use betting;

create table bonuses(
Customer_id int,
first_name varchar(30),
last_name varchar(40),
country varchar(60),
age int,
gender enum('Male', 'Female'),
income_level int,
winning_Percentage int,
Day_Since_Last_Bet int,
Active_Days int,
Total_Number_of_Bets int,
Total_Amount_Wagered int,
Average_Bet_Amount int,
Number_of_Bonuses_Received int,
Amount_of_Bonuses_Received int,
Revenue_from_Bonuses int,
Increase_in_Bets_After_Bonus int,
Increase_in_wagering_after_Bonus int,
Should_Receive_Bonus int);

select * from bonuses;
desc bonuses;

#########  TYPECASTING #########

SELECT CAST(Customer_id AS char) AS Customer_id_str FROM bonuses;

########### dupilicate row identification ##############

select Customer_id,first_name,last_name,country,age,gender,income_level,winning_Percentage,Day_Since_Last_Bet,
Active_Days,Total_Number_of_Bets,Total_Amount_Wagered,Average_Bet_Amount,Number_of_Bonuses_Received,
Amount_of_Bonuses_Received,Revenue_from_Bonuses,Increase_in_Bets_After_Bonus,Increase_in_wagering_after_Bonus,
Should_Receive_Bonus, count(*) as duplicate_count 
from bonuses
group by Customer_id,first_name,last_name,country,age,gender,income_level,winning_Percentage,Day_Since_Last_Bet,
Active_Days,Total_Number_of_Bets,Total_Amount_Wagered,Average_Bet_Amount,Number_of_Bonuses_Received,
Amount_of_Bonuses_Received,Revenue_from_Bonuses,Increase_in_Bets_After_Bonus,Increase_in_wagering_after_Bonus,
Should_Receive_Bonus having count(*)>1;           ######### No duplicate rows found

########## identifying missing values ##############

SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN Customer_id IS NULL THEN 1 ELSE 0 END) AS column1_missing,
SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS column2_missing,
SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS column3_missing,
SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_missing,
SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_missing,
SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_missing,
SUM(CASE WHEN income_level IS NULL THEN 1 ELSE 0 END) AS income_level_missing,
SUM(CASE WHEN winning_Percentage IS NULL THEN 1 ELSE 0 END) AS winning_Percentage_missing,
SUM(CASE WHEN Day_Since_Last_Bet IS NULL THEN 1 ELSE 0 END) AS Day_Since_Last_Bet_missing,
SUM(CASE WHEN Active_Days IS NULL THEN 1 ELSE 0 END) AS Active_Days_missing,
SUM(CASE WHEN Total_Number_of_Bets IS NULL THEN 1 ELSE 0 END) AS Total_Number_of_Bets_missing,
SUM(CASE WHEN Total_Amount_Wagered IS NULL THEN 1 ELSE 0 END) AS Total_Amount_Wagered_missing,
SUM(CASE WHEN Average_Bet_Amount IS NULL THEN 1 ELSE 0 END) AS Average_Bet_Amount_missing,
SUM(CASE WHEN Number_of_Bonuses_Received IS NULL THEN 1 ELSE 0 END) AS Number_of_Bonuses_Received_missing,
SUM(CASE WHEN Amount_of_Bonuses_Received IS NULL THEN 1 ELSE 0 END) AS Amount_of_Bonuses_Received_missing,
SUM(CASE WHEN Revenue_from_Bonuses IS NULL THEN 1 ELSE 0 END) AS Revenue_from_Bonuses_missing,
SUM(CASE WHEN Increase_in_Bets_After_Bonus IS NULL THEN 1 ELSE 0 END) AS Increase_in_Bets_After_Bonus_missing,
SUM(CASE WHEN Increase_in_wagering_after_Bonus IS NULL THEN 1 ELSE 0 END) AS Increase_in_wagering_after_Bonus_missing,
SUM(CASE WHEN Should_Receive_Bonus IS NULL THEN 1 ELSE 0 END) AS Should_Receive_Bonus_missing
FROM bonuses;                         
                                           ######There is no missing value found
    
###########Zero or near zero variance features ##############
    
 SELECT 
    'Customer_id' AS Column_Name, 
    COUNT(DISTINCT Customer_id) AS Unique_Values,
    (COUNT(Customer_id) - COUNT(DISTINCT Customer_id)) / COUNT(Customer_id) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'first_name' AS Column_Name, 
    COUNT(DISTINCT first_name) AS Unique_Values,
    (COUNT(first_name) - COUNT(DISTINCT first_name)) / COUNT(first_name) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'last_name' AS Column_Name, 
    COUNT(DISTINCT last_name) AS Unique_Values,
    (COUNT(last_name) - COUNT(DISTINCT last_name)) / COUNT(last_name) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'country' AS Column_Name, 
    COUNT(DISTINCT country) AS Unique_Values,
    (COUNT(country) - COUNT(DISTINCT country)) / COUNT(country) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'age' AS Column_Name, 
    COUNT(DISTINCT age) AS Unique_Values,
    (COUNT(age) - COUNT(DISTINCT age)) / COUNT(age) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'gender' AS Column_Name, 
    COUNT(DISTINCT gender) AS Unique_Values,
    (COUNT(gender) - COUNT(DISTINCT gender)) / COUNT(gender) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'income_level' AS Column_Name, 
    COUNT(DISTINCT income_level) AS Unique_Values,
    (COUNT(income_level) - COUNT(DISTINCT income_level)) / COUNT(income_level) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'winning_Percentage' AS Column_Name, 
    COUNT(DISTINCT winning_Percentage) AS Unique_Values,
    (COUNT(winning_Percentage) - COUNT(DISTINCT winning_Percentage)) / COUNT(winning_Percentage) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Day_Since_Last_Bet' AS Column_Name, 
    COUNT(DISTINCT Day_Since_Last_Bet) AS Unique_Values,
    (COUNT(Day_Since_Last_Bet) - COUNT(DISTINCT Day_Since_Last_Bet)) / COUNT(Day_Since_Last_Bet) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Active_Days' AS Column_Name, 
    COUNT(DISTINCT Active_Days) AS Unique_Values,
    (COUNT(Active_Days) - COUNT(DISTINCT Active_Days)) / COUNT(Active_Days) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Total_Number_of_Bets' AS Column_Name, 
    COUNT(DISTINCT Total_Number_of_Bets) AS Unique_Values,
    (COUNT(Total_Number_of_Bets) - COUNT(DISTINCT Total_Number_of_Bets)) / COUNT(Total_Number_of_Bets) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Total_Amount_Wagered' AS Column_Name, 
    COUNT(DISTINCT Total_Amount_Wagered) AS Unique_Values,
    (COUNT(Total_Amount_Wagered) - COUNT(DISTINCT Total_Amount_Wagered)) / COUNT(Total_Amount_Wagered) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Average_Bet_Amount' AS Column_Name, 
    COUNT(DISTINCT Average_Bet_Amount) AS Unique_Values,
    (COUNT(Average_Bet_Amount) - COUNT(DISTINCT Average_Bet_Amount)) / COUNT(Average_Bet_Amount) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Number_of_Bonuses_Received' AS Column_Name, 
    COUNT(DISTINCT Number_of_Bonuses_Received) AS Unique_Values,
    (COUNT(Number_of_Bonuses_Received) - COUNT(DISTINCT Number_of_Bonuses_Received)) / COUNT(Number_of_Bonuses_Received) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Amount_of_Bonuses_Received' AS Column_Name, 
    COUNT(DISTINCT Amount_of_Bonuses_Received) AS Unique_Values,
    (COUNT(Amount_of_Bonuses_Received) - COUNT(DISTINCT Amount_of_Bonuses_Received)) / COUNT(Amount_of_Bonuses_Received) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Revenue_from_Bonuses' AS Column_Name, 
    COUNT(DISTINCT Revenue_from_Bonuses) AS Unique_Values,
    (COUNT(Revenue_from_Bonuses) - COUNT(DISTINCT Revenue_from_Bonuses)) / COUNT(Revenue_from_Bonuses) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Increase_in_Bets_After_Bonus' AS Column_Name, 
    COUNT(DISTINCT Increase_in_Bets_After_Bonus) AS Unique_Values,
    (COUNT(Increase_in_Bets_After_Bonus) - COUNT(DISTINCT Increase_in_Bets_After_Bonus)) / COUNT(Increase_in_Bets_After_Bonus) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Increase_in_wagering_after_Bonus' AS Column_Name, 
    COUNT(DISTINCT Increase_in_wagering_after_Bonus) AS Unique_Values,
    (COUNT(Increase_in_wagering_after_Bonus) - COUNT(DISTINCT Increase_in_wagering_after_Bonus)) / COUNT(Increase_in_wagering_after_Bonus) * 100 AS Variance_Percentage
FROM bonuses
UNION ALL
SELECT 
    'Should_Receive_Bonus' AS Column_Name, 
    COUNT(DISTINCT Should_Receive_Bonus) AS Unique_Values,
    (COUNT(Should_Receive_Bonus) - COUNT(DISTINCT Should_Receive_Bonus)) / COUNT(Should_Receive_Bonus) * 100 AS Variance_Percentage
FROM bonuses;
        
############ Discretization #########

 SELECT 
    Customer_id, first_name, last_name,
    Should_Receive_Bonus,
    CASE 
        WHEN Should_Receive_Bonus = 0 THEN 'No'
        WHEN Should_Receive_Bonus = 1 THEN 'Yes'
    END AS Should_Receive_Bonus_Discretized
FROM bonuses;
           
############ Outliers Treatment ###############
#create a new table:

create table bonuses_outlier as select * from bonuses;

select * from bonuses_outlier;

WITH Ordered AS (
    SELECT  income_level, ROW_NUMBER() OVER (ORDER BY income_level) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT income_level, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN income_level ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN income_level ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE income_level < (Q1 - 1.5 * IQR) OR income_level > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET income_level = CASE 
    WHEN income_level < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN income_level > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE income_level
END;

--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  winning_Percentage, ROW_NUMBER() OVER (ORDER BY winning_Percentage) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT winning_Percentage, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN winning_Percentage ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN winning_Percentage ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE winning_Percentage < (Q1 - 1.5 * IQR) OR winning_Percentage > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET winning_Percentage = CASE 
    WHEN winning_Percentage < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN winning_Percentage > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE winning_Percentage
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Day_Since_Last_Bet, ROW_NUMBER() OVER (ORDER BY Day_Since_Last_Bet) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Day_Since_Last_Bet, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Day_Since_Last_Bet ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Day_Since_Last_Bet ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Day_Since_Last_Bet < (Q1 - 1.5 * IQR) OR Day_Since_Last_Bet > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Day_Since_Last_Bet = CASE 
    WHEN Day_Since_Last_Bet < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Day_Since_Last_Bet > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Day_Since_Last_Bet
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Active_Days, ROW_NUMBER() OVER (ORDER BY Active_Days) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Active_Days, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Active_Days ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Active_Days ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Active_Days < (Q1 - 1.5 * IQR) OR Active_Days > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Active_Days = CASE 
    WHEN Active_Days < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Active_Days > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Active_Days
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Total_Number_of_Bets, ROW_NUMBER() OVER (ORDER BY Total_Number_of_Bets) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Total_Number_of_Bets, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Total_Number_of_Bets ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Total_Number_of_Bets ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Total_Number_of_Bets < (Q1 - 1.5 * IQR) OR winning_Percentage > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Total_Number_of_Bets = CASE 
    WHEN Total_Number_of_Bets < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Total_Number_of_Bets > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Total_Number_of_Bets
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Total_Amount_Wagered, ROW_NUMBER() OVER (ORDER BY Total_Amount_Wagered) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Total_Amount_Wagered, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Total_Amount_Wagered ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Total_Amount_Wagered ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Total_Amount_Wagered < (Q1 - 1.5 * IQR) OR Total_Amount_Wagered > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Total_Amount_Wagered = CASE 
    WHEN Total_Amount_Wagered < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Total_Amount_Wagered > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Total_Amount_Wagered
END;

--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Average_Bet_Amount, ROW_NUMBER() OVER (ORDER BY Average_Bet_Amount) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Average_Bet_Amount, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Average_Bet_Amount ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Average_Bet_Amount ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Average_Bet_Amount < (Q1 - 1.5 * IQR) OR Average_Bet_Amount > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Average_Bet_Amount = CASE 
    WHEN Average_Bet_Amount < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Average_Bet_Amount > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Average_Bet_Amount
END;
--------------------------------------------------------------
WITH Ordered AS (
    SELECT  Number_of_Bonuses_Received, ROW_NUMBER() OVER (ORDER BY Average_Bet_Amount) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Number_of_Bonuses_Received, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Number_of_Bonuses_Received ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Number_of_Bonuses_Received ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Number_of_Bonuses_Received < (Q1 - 1.5 * IQR) OR Number_of_Bonuses_Received > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Number_of_Bonuses_Received = CASE 
    WHEN Number_of_Bonuses_Received < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Number_of_Bonuses_Received > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Number_of_Bonuses_Received
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Amount_of_Bonuses_Received, ROW_NUMBER() OVER (ORDER BY Amount_of_Bonuses_Received) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Amount_of_Bonuses_Received, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Amount_of_Bonuses_Received ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Amount_of_Bonuses_Received ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Amount_of_Bonuses_Received < (Q1 - 1.5 * IQR) OR Amount_of_Bonuses_Received > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Amount_of_Bonuses_Received = CASE 
    WHEN Amount_of_Bonuses_Received < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Amount_of_Bonuses_Received > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Amount_of_Bonuses_Received
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Revenue_from_Bonuses, ROW_NUMBER() OVER (ORDER BY Revenue_from_Bonuses) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Revenue_from_Bonuses, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Revenue_from_Bonuses ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Revenue_from_Bonuses ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Revenue_from_Bonuses < (Q1 - 1.5 * IQR) OR Revenue_from_Bonuses > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Revenue_from_Bonuses = CASE 
    WHEN Revenue_from_Bonuses < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Revenue_from_Bonuses > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Revenue_from_Bonuses
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Increase_in_Bets_After_Bonus, ROW_NUMBER() OVER (ORDER BY Increase_in_Bets_After_Bonus) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Increase_in_Bets_After_Bonus, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Increase_in_Bets_After_Bonus ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Increase_in_Bets_After_Bonus ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Increase_in_Bets_After_Bonus < (Q1 - 1.5 * IQR) OR Increase_in_Bets_After_Bonus > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Increase_in_Bets_After_Bonus = CASE 
    WHEN Increase_in_Bets_After_Bonus < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Increase_in_Bets_After_Bonus > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Increase_in_Bets_After_Bonus
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Increase_in_wagering_after_Bonus, ROW_NUMBER() OVER (ORDER BY Increase_in_wagering_after_Bonus) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Increase_in_wagering_after_Bonus, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Increase_in_wagering_after_Bonus ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Increase_in_wagering_after_Bonus ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Increase_in_wagering_after_Bonus < (Q1 - 1.5 * IQR) OR Increase_in_wagering_after_Bonus > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Increase_in_wagering_after_Bonus = CASE 
    WHEN Increase_in_wagering_after_Bonus < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Increase_in_wagering_after_Bonus > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Increase_in_wagering_after_Bonus
END;
--------------------------------------------------------------------------------------
WITH Ordered AS (
    SELECT  Should_Receive_Bonus, ROW_NUMBER() OVER (ORDER BY Should_Receive_Bonus) AS row_num, COUNT(*) OVER () AS total_rows
    FROM bonuses_outlier),
Quartiles AS (
    SELECT Should_Receive_Bonus, total_rows, row_num,
        CASE WHEN row_num = FLOOR(total_rows * 0.25) THEN Should_Receive_Bonus ELSE NULL END AS Q1,
        CASE WHEN row_num = FLOOR(total_rows * 0.75) THEN Should_Receive_Bonus ELSE NULL END AS Q3
    FROM Ordered ),
Q1_Q3 AS (
    SELECT MAX(Q1) AS Q1, MAX(Q3) AS Q3
    FROM Quartiles ),
IQR_Calculation AS (
    SELECT  Q1, Q3, (Q3 - Q1) AS IQR
    FROM Q1_Q3 ),
Outliers as (
SELECT *
FROM bonuses_outlier CROSS JOIN IQR_Calculation
WHERE Should_Receive_Bonus < (Q1 - 1.5 * IQR) OR Should_Receive_Bonus > (Q3 + 1.5 * IQR)
)
UPDATE bonuses_outlier
SET Should_Receive_Bonus = CASE 
    WHEN Should_Receive_Bonus < (SELECT Q1 FROM IQR_Calculation) - 1.5 * (SELECT IQR FROM IQR_Calculation) 
         THEN (SELECT Q1 FROM IQR_Calculation)
    WHEN Should_Receive_Bonus > (SELECT Q3 FROM IQR_Calculation) + 1.5 * (SELECT IQR FROM IQR_Calculation)
         THEN (SELECT Q3 FROM IQR_Calculation)
    ELSE Should_Receive_Bonus
END;
--------------------------------------------------------------------------------------
 ############### Normalization ############### 
  
SELECT 
    Customer_id,
    first_name,
    last_name,
    country,
    gender,
	(age - MIN(age) OVER ()) / (MAX(age) OVER () - MIN(age) OVER ()) AS age_normalized,
	(income_level - MIN(income_level) OVER ()) / (MAX(income_level) OVER () - MIN(income_level) OVER ()) AS income_level_normalized,
	(winning_Percentage - MIN(winning_Percentage) OVER ()) / (MAX(winning_Percentage) OVER () - MIN(winning_Percentage) OVER ()) AS winning_Percentage_normalized,
	(Day_Since_Last_Bet - MIN(Day_Since_Last_Bet) OVER ()) / (MAX(Day_Since_Last_Bet) OVER () - MIN(Day_Since_Last_Bet) OVER ()) AS Day_Since_Last_Bet_normalized,
    (Active_Days - MIN(Active_Days) OVER ()) / (MAX(Active_Days) OVER () - MIN(Active_Days) OVER ()) AS Active_Days_normalized,
    (Total_Number_of_Bets - MIN(Total_Number_of_Bets) OVER ()) / (MAX(Total_Number_of_Bets) OVER () - MIN(Total_Number_of_Bets) OVER ()) AS Total_Number_of_Bets_normalized,
    (Total_Amount_Wagered - MIN(Total_Amount_Wagered) OVER ()) / (MAX(Total_Amount_Wagered) OVER () - MIN(Total_Amount_Wagered) OVER ()) AS Total_Amount_Wagered_normalized,
    (Average_Bet_Amount - MIN(Average_Bet_Amount) OVER ()) / (MAX(Average_Bet_Amount) OVER () - MIN(Average_Bet_Amount) OVER ()) AS Average_Bet_Amount_normalized,
    (Number_of_Bonuses_Received - MIN(Number_of_Bonuses_Received) OVER ()) / (MAX(Number_of_Bonuses_Received) OVER () - MIN(Number_of_Bonuses_Received) OVER ()) AS Number_of_Bonuses_Received_normalized,
    (Amount_of_Bonuses_Received - MIN(Amount_of_Bonuses_Received) OVER ()) / (MAX(Amount_of_Bonuses_Received) OVER () - MIN(Amount_of_Bonuses_Received) OVER ()) AS Amount_of_Bonuses_Received_normalized,
    (Revenue_from_Bonuses - MIN(Revenue_from_Bonuses) OVER ()) / (MAX(Revenue_from_Bonuses) OVER () - MIN(Revenue_from_Bonuses) OVER ()) AS Revenue_from_Bonuses_normalized,
    (Increase_in_Bets_After_Bonus - MIN(Increase_in_Bets_After_Bonus) OVER ()) / (MAX(Increase_in_Bets_After_Bonus) OVER () - MIN(Increase_in_Bets_After_Bonus) OVER ()) AS Increase_in_Bets_After_Bonus_normalized,
    (Increase_in_wagering_after_Bonus - MIN(Increase_in_wagering_after_Bonus) OVER ()) / (MAX(Increase_in_wagering_after_Bonus) OVER () - MIN(Increase_in_wagering_after_Bonus) OVER ()) AS Increase_in_wagering_after_Bonus_normalized
FROM bonuses;

