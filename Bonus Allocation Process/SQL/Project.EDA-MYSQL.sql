create database betting;
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

describe bonuses;

select * from bonuses;

#Mean
Select avg(age) as Mean_age,
avg(income_level) as Mean_income_level,
avg(winning_Percentage) as Mean_winning_Percentage,
avg(Day_Since_Last_Bet) as Mean_Day_Since_Last_Bet,
avg(Active_Days) as Mean_Active_Days,
avg(Total_Number_of_Bets) as Mean_Total_Number_of_Bets,
avg(Total_Amount_Wagered) as Mean_Total_Amount_Wagered,
avg(Average_Bet_Amount) as Mean_Average_Bet_Amount,
avg(Number_of_Bonuses_Received) as Mean_Number_of_Bonuses_Received,
avg(Amount_of_Bonuses_Received) as Mean_Amount_of_Bonuses_Received,
avg(Revenue_from_Bonuses) as Mean_Revenue_from_Bonuses,
avg(Increase_in_Bets_After_Bonus) as Mean_Increase_in_Bets_After_Bonus,
avg(Increase_in_wagering_after_Bonus) as Mean_Increase_in_wagering_after_Bonus,
avg(Should_Receive_Bonus) as Mean_Should_Receive_Bonus
from bonuses;

#Median   
select age as median_age from(
select age, row_number() over (order by age) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select income_level as median_income_level from(
select income_level, row_number() over (order by income_level) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select winning_Percentage as median_winning_Percentage from(
select winning_Percentage, row_number() over (order by winning_Percentage) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Day_Since_Last_Bet as median_Day_Since_Last_Bet from(
select Day_Since_Last_Bet, row_number() over (order by Day_Since_Last_Bet) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Active_Days as median_Active_Days from(
select Active_Days, row_number() over (order by Active_Days) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Total_Number_of_Bets as median_Total_Number_of_Bets from(
select Total_Number_of_Bets, row_number() over (order by Total_Number_of_Bets) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Total_Amount_Wagered as median_Total_Amount_Wagered from(
select Total_Amount_Wagered, row_number() over (order by Total_Amount_Wagered) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Average_Bet_Amount as median_Average_Bet_Amount from(
select Average_Bet_Amount, row_number() over (order by Average_Bet_Amount) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Number_of_Bonuses_Received as median_Number_of_Bonuses_Received from(
select Number_of_Bonuses_Received, row_number() over (order by Number_of_Bonuses_Received) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Amount_of_Bonuses_Received as median_Amount_of_Bonuses_Received from(
select Amount_of_Bonuses_Received, row_number() over (order by Amount_of_Bonuses_Received) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Revenue_from_Bonuses as median_Revenue_from_Bonuses from(
select Revenue_from_Bonuses, row_number() over (order by Revenue_from_Bonuses) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Increase_in_Bets_After_Bonus as median_Increae_in_Bets_After_Bonus from(
select Increase_in_Bets_After_Bonus, row_number() over (order by Increase_in_Bets_After_Bonus) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Increase_in_wagering_after_Bonus as median_Increase_in_wagering_after_Bonuses from(
select Increase_in_wagering_after_Bonus, row_number() over (order by Increase_in_wagering_after_Bonus) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

select Should_Receive_Bonus as median_Should_Receive_Bonus from(
select Should_Receive_Bonus, row_number() over (order by Should_Receive_Bonus) as row_num,
count(*) over() as total_count from bonuses
) as subquery
where row_num IN (FLOOR((total_count + 1) / 2), CEIL((total_count + 1) / 2));

#Mode
select age as mode_age from(
select age, count(*) as frequency from bonuses
group by age order by frequency desc limit 1
) as subquery;

select income_level as mode_income_level from(
select income_level, count(*) as frequency from bonuses
group by income_level order by frequency desc limit 1
) as subquery;

select winning_Percentage as mode_winning_Percentage from(
select winning_Percentage, count(*) as frequency from bonuses
group by winning_Percentage order by frequency desc limit 1
) as subquery;

select Day_Since_Last_Bet as mode_Day_Since_Last_Bet from(
select Day_Since_Last_Bet, count(*) as frequency from bonuses
group by Day_Since_Last_Bet order by frequency desc limit 1
) as subquery;

select Active_Days as mode_Active_Days from(
select Active_Days, count(*) as frequency from bonuses
group by Active_Days order by frequency desc limit 1
) as subquery;

select Total_Number_of_Bets as mode_Total_Number_of_Bets from(
select Total_Number_of_Bets, count(*) as frequency from bonuses
group by Total_Number_of_Bets order by frequency desc limit 1
) as subquery;

select Total_Amount_Wagered as mode_Total_Amount_Wagered from(
select Total_Amount_Wagered, count(*) as frequency from bonuses
group by Total_Amount_Wagered order by frequency desc limit 1
) as subquery;

select Average_Bet_Amount as mode_Average_Bet_Amount from(
select Average_Bet_Amount, count(*) as frequency from bonuses
group by Average_Bet_Amount order by frequency desc limit 1
) as subquery;

select Number_of_Bonuses_Received as mode_Number_of_Bonuses_Received from(
select Number_of_Bonuses_Received, count(*) as frequency from bonuses
group by Number_of_Bonuses_Received order by frequency desc limit 1
) as subquery;

select Amount_of_Bonuses_Received as mode_Amount_of_Bonuses_Received from(
select Amount_of_Bonuses_Received, count(*) as frequency from bonuses
group by Amount_of_Bonuses_Received order by frequency desc limit 1
) as subquery;

select Revenue_from_Bonuses as mode_Revenue_from_Bonuses from(
select Revenue_from_Bonuses, count(*) as frequency from bonuses
group by Revenue_from_Bonuses order by frequency desc limit 1
) as subquery;

select Increase_in_Bets_After_Bonus as mode_Increase_in_Bets_After_Bonus from(
select Increase_in_Bets_After_Bonus, count(*) as frequency from bonuses
group by Increase_in_Bets_After_Bonus order by frequency desc limit 1
) as subquery;

select Increase_in_wagering_after_Bonus as mode_Increase_in_wagering_after_Bonus from(
select Increase_in_wagering_after_Bonus, count(*) as frequency from bonuses
group by Increase_in_wagering_after_Bonus order by frequency desc limit 1
) as subquery;

select Should_Receive_Bonus as mode_Should_Receive_Bonus from(
select Should_Receive_Bonus, count(*) as frequency from bonuses
group by Should_Receive_Bonus order by frequency desc limit 1
) as subquery;



#Standard Deviation
select 
stddev(age) as std_dev_age,
stddev(income_level) as std_dev_income_level,
stddev(winning_Percentage) as std_dev_winning_Percentage,
stddev(Day_Since_Last_Bet) as std_dev_Day_Since_Last_Bet,
stddev(Active_Days) as std_dev_Active_Days,
stddev(Total_Amount_Wagered) as std_dev_Total_Number_Wagered,
stddev(Total_Number_of_Bets) as std_dev_Total_Number_of_Bets,
stddev(Average_Bet_Amount) as std_dev_Average_Bet_Amount,
stddev(Number_of_Bonuses_Received) as std_dev_Number_of_Bonuses_Received,
stddev(Amount_of_Bonuses_Received) as std_dev_Amount_of_Bonuses_Received,
stddev(Revenue_from_Bonuses) as std_dev_Revenue_from_Bonuses,
stddev(Increase_in_Bets_After_Bonus) as std_dev_Increase_in_Bets_After_Bonus,
stddev(Increase_in_wagering_after_Bonus) as std_dev_Increase_in_wagering_after_Bonus,
stddev(Should_Receive_Bonus) as std_dev_Should_Receive_Bonus
from bonuses;

#Range
select
max(age) - min(age) as range_age,
max(income_level) - min(income_level) as range_income_level,
max(winning_Percentage) - min(winning_Percentage) as range_winning_Percentage,
max(Day_Since_Last_Bet) - min(Day_Since_Last_Bet) as range_Day_Since_Last_Bet,
max(Active_Days) - min(Active_Days) as range_Active_Days,
max(Total_Number_of_Bets) - min(Total_Number_of_Bets) as range_Total_Number_of_Bets,
max(Total_Amount_Wagered) - min(Total_Amount_Wagered) as range_Total_Amount_Wagered,
max(Average_Bet_Amount) - min(Average_Bet_Amount) as range_Average_Bet_Amount,
max(Number_of_Bonuses_Received) - min(Number_of_Bonuses_Received) as range_Number_of_Bonuses_Received,
max(Amount_of_Bonuses_Received) - min(Amount_of_Bonuses_Received) as range_Amount_of_Bonuses_Received,
max(Revenue_from_Bonuses) - min(Revenue_from_Bonuses) as range_Revenue_from_Bonuses,
max(Increase_in_Bets_After_Bonus) - min(Increase_in_Bets_After_Bonus) as range_Increase_in_Bets_After_Bonus,
max(Increase_in_wagering_after_Bonus) - min(Increase_in_wagering_after_Bonus) as range_Increase_in_wagering_after_Bonus,
max(Should_Receive_Bonus) - min(Should_Receive_Bonus) as range_Should_Receive_Bonus
from bonuses;

#variance
select
variance(age) as variance_age,
variance(income_level) as variance_income_level, 
variance(winning_Percentage) as variance_winning_Percentage,
variance(Day_Since_Last_Bet) as variance_Day_Since_Last_Bet,
variance(Active_Days) as variance_Active_Days,
variance(Total_Number_of_Bets) as variance_Total_Number_of_Bets,
variance(Total_Amount_Wagered) as variance_Total_Amount_Wagered,
variance(Average_Bet_Amount) as variance_Average_Bet_Amount,
variance(Number_of_Bonuses_Received) as variance_Number_of_Bonuses_Received,
variance(Amount_of_Bonuses_Received) as variance_Amount_of_Bonuses_Received,
variance(Revenue_from_Bonuses) as variance_Revenue_from_Bonuses,
variance(Increase_in_Bets_After_Bonus) as variance_Increase_in_Bets_After_Bonus,
variance(Increase_in_wagering_after_Bonus) as variance_Increase_in_wagering_after_Bonus,
variance(Should_Receive_Bonus) as variance_Should_Receive_Bonus
from bonuses;

#skewness
SELECT
(
SUM(POWER(age- (SELECT AVG(age) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(age) FROM bonuses), 3))
) AS skewness_age
FROM bonuses;

SELECT
(
SUM(POWER(income_level- (SELECT AVG(income_level) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(income_level) FROM bonuses), 3))
) AS skewness_income_level
FROM bonuses;

SELECT
(
SUM(POWER(winning_Percentage- (SELECT AVG(winning_Percentage) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(winning_Percentage) FROM bonuses), 3))
) AS skewness_winning_Percentage
FROM bonuses;



SELECT
(
SUM(POWER(Day_Since_Last_Bet- (SELECT AVG(Day_Since_Last_Bet) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Day_Since_Last_Bet) FROM bonuses), 3))
) AS skewness_Day_Since_Last_Bet
FROM bonuses;

SELECT
(
SUM(POWER(Active_Days- (SELECT AVG(Active_Days) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Active_Days) FROM bonuses), 3))
) AS skewness_Active_Days
FROM bonuses;

SELECT
(
SUM(POWER(Total_Number_of_Bets- (SELECT AVG(Total_Number_of_Bets) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Total_Number_of_Bets) FROM bonuses), 3))
) AS skewness_Total_Number_of_Bets
FROM bonuses;

SELECT
(
SUM(POWER(Total_Amount_Wagered- (SELECT AVG(Total_Amount_Wagered) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Total_Amount_Wagered) FROM bonuses), 3))
) AS skewness_Total_Amount_Wagered
FROM bonuses;

SELECT
(
SUM(POWER(Average_Bet_Amount- (SELECT AVG(Average_Bet_Amount) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Average_Bet_Amount) FROM bonuses), 3))
) AS skewness_Average_Bet_Amount
FROM bonuses;

SELECT
(
SUM(POWER(Number_of_Bonuses_Received- (SELECT AVG(Number_of_Bonuses_Received) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Number_of_Bonuses_Received) FROM bonuses), 3))
) AS skewness_Number_of_Bonuses_Received
FROM bonuses;

SELECT
(
SUM(POWER(- (SELECT AVG() FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 3))
) AS skewness_
FROM bonuses;

SELECT
(
SUM(POWER(Amount_of_Bonuses_Received- (SELECT AVG(Amount_of_Bonuses_Received) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Amount_of_Bonuses_Received) FROM bonuses), 3))
) AS skewness_Amount_of_Bonuses_Received
FROM bonuses;

SELECT
(
SUM(POWER(Revenue_from_Bonuses- (SELECT AVG(Revenue_from_Bonuses) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Revenue_from_Bonuses) FROM bonuses), 3))
) AS skewness_Revenue_from_Bonuses
FROM bonuses;

SELECT
(
SUM(POWER(- (SELECT AVG() FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 3))
) AS skewness_
FROM bonuses;

SELECT
(
SUM(POWER(Increase_in_Bets_After_Bonus- (SELECT AVG(Increase_in_Bets_After_Bonus) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Increase_in_Bets_After_Bonus) FROM bonuses), 3))
) AS skewness_Increase_in_Bets_After_Bonus
FROM bonuses;

SELECT
(
SUM(POWER(Increase_in_wagering_after_Bonus- (SELECT AVG(Increase_in_wagering_after_Bonus) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Increase_in_wagering_after_Bonus) FROM bonuses), 3))
) AS skewness_Increase_in_wagering_after_Bonus
FROM bonuses;

SELECT
(
SUM(POWER(Should_Receive_Bonus- (SELECT AVG(Should_Receive_Bonus) FROM bonuses), 3)) /
(COUNT(*) * POWER((SELECT STDDEV(Should_Receive_Bonus) FROM bonuses), 3))
) AS skewness_Should_Receive_Bonus
FROM bonuses;

#Kurtosis
SELECT
(
(SUM(POWER(age- (SELECT AVG(age) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(age) FROM bonuses), 4))) - 3
) AS kurtosis_age
FROM bonuses;

SELECT
(
(SUM(POWER(income_level- (SELECT AVG(income_level) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(income_level) FROM bonuses), 4))) - 3
) AS kurtosis_income_level
FROM bonuses;

SELECT
(
(SUM(POWER(winning_Percentage- (SELECT AVG(winning_Percentage) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(winning_Percentage) FROM bonuses), 4))) - 3
) AS kurtosis_winning_Percentage
FROM bonuses;

SELECT
(
(SUM(POWER(- (SELECT AVG() FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 4))) - 3
) AS kurtosis_
FROM bonuses;

SELECT
(
(SUM(POWER(Day_Since_Last_Bet- (SELECT AVG(Day_Since_Last_Bet) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Day_Since_Last_Bet) FROM bonuses), 4))) - 3
) AS kurtosis_Day_Since_Last_Bet
FROM bonuses;

SELECT
(
(SUM(POWER(- (SELECT AVG() FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 4))) - 3
) AS kurtosis_
FROM bonuses;

SELECT
(
(SUM(POWER(Active_Days- (SELECT AVG(Active_Days) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Active_Days) FROM bonuses), 4))) - 3
) AS kurtosis_Active_Days
FROM bonuses;

SELECT
(
(SUM(POWER(- (SELECT AVG() FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 4))) - 3
) AS kurtosis_
FROM bonuses;

SELECT
(
(SUM(POWER(Total_Number_of_Bets- (SELECT AVG(Total_Number_of_Bets) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Total_Number_of_Bets) FROM bonuses), 4))) - 3
) AS kurtosis_Total_Number_of_Bets
FROM bonuses;

SELECT
(
(SUM(POWER(Total_Amount_Wagered- (SELECT AVG(Total_Amount_Wagered) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Total_Amount_Wagered) FROM bonuses), 4))) - 3
) AS kurtosis_Total_Amount_Wagered
FROM bonuses;

SELECT
(
(SUM(POWER(Average_Bet_Amount- (SELECT AVG(Average_Bet_Amount) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Average_Bet_Amount) FROM bonuses), 4))) - 3
) AS kurtosis_Average_Bet_Amount
FROM bonuses;

SELECT
(
(SUM(POWER(Number_of_Bonuses_Received- (SELECT AVG(Number_of_Bonuses_Received) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Number_of_Bonuses_Received) FROM bonuses), 4))) - 3
) AS kurtosis_Number_of_Bonuses_Received
FROM bonuses;

SELECT
(
(SUM(POWER(Amount_of_Bonuses_Received- (SELECT AVG(Amount_of_Bonuses_Received) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Amount_of_Bonuses_Received) FROM bonuses), 4))) - 3
) AS kurtosis_Amount_of_Bonuses_Received
FROM bonuses;

SELECT
(
(SUM(POWER(- (SELECT AVG() FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 4))) - 3
) AS kurtosis_
FROM bonuses;

SELECT
(
(SUM(POWER(Revenue_from_Bonuses- (SELECT AVG(Revenue_from_Bonuses) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Revenue_from_Bonuses) FROM bonuses), 4))) - 3
) AS kurtosis_Revenue_from_Bonuses
FROM bonuses;

SELECT
(
(SUM(POWER(- (SELECT AVG() FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV() FROM bonuses), 4))) - 3
) AS kurtosis_
FROM bonuses;

SELECT
(
(SUM(POWER(Increase_in_Bets_After_Bonus- (SELECT AVG(Increase_in_Bets_After_Bonus) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Increase_in_Bets_After_Bonus) FROM bonuses), 4))) - 3
) AS kurtosis_Increase_in_Bets_After_Bonus
FROM bonuses;

SELECT
(
(SUM(POWER(Increase_in_wagering_after_Bonus- (SELECT AVG(Increase_in_wagering_after_Bonus) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Increase_in_wagering_after_Bonus) FROM bonuses), 4))) - 3
) AS kurtosis_Increase_in_wagering_after_Bonus
FROM bonuses;

SELECT
(
(SUM(POWER(Should_Receive_Bonus- (SELECT AVG(Should_Receive_Bonus) FROM bonuses), 4)) /
(COUNT(*) * POWER((SELECT STDDEV(Should_Receive_Bonus) FROM bonuses), 4))) - 3
) AS kurtosis_Should_Receive_Bonus
FROM bonuses;
