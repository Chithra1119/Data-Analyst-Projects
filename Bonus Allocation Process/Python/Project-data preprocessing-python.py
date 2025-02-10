import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data= pd.read_csv(r'C:/Users/Administrator/Downloads/Projects/Bonus Allocation Data - Master Data.csv.csv')
data.dtypes

################ Type casting #################
#convert customer_id int64 to str

data.customer_id= data.customer_id.astype('str')
data.dtypes


################ Identify duplicate records in the data ##########
duplicate= data.duplicated()
duplicate
sum(duplicate)  #output: duplicate rows not found


################ Missing values ###############
    
import pandas as pd

Missing_data = data.isna().sum()
Missing_data
Missing_data.dropna(inplace = True)
print(Missing_data)

Missing_data.info()  #############There is no missing value in this data


############## Outlier Treatment ###############

###### Finding outliers and replace it with upper and lower limit


# Loop through all numeric columns in the DataFrame
for column in data.select_dtypes(include='number').columns:
    Q1 = data[column].quantile(0.25)  # Calculate Q1 (25th percentile)
    Q3 = data[column].quantile(0.75)  # Calculate Q3 (75th percentile)
    IQR = Q3 - Q1                   # Calculate Interquartile Range (IQR)
    lower_bound = Q1 - 1.5 * IQR    # Calculate lower bound for outliers
    upper_bound = Q3 + 1.5 * IQR    # Calculate upper bound for outliers
    
   # Replace values below the lower bound with lower_bound and above upper bound with upper_bound
    data[column] = np.where(data[column] > upper_bound, upper_bound, 
                   np.where(data[column] < lower_bound, lower_bound, data[column]))

data
    
############# Discretization##################


data['Should_Receive_Bonus_Discretized'] = pd.cut(data['Should_Receive_Bonus'],
                                                bins=2, labels=['No', 'Yes'])

print(data)


############### zero variance and near zero variance ####

# Calculate variance for numeric columns only
numeric_columns = data.select_dtypes(include=np.number).columns
variances = data[numeric_columns].var()

# Columns with zero variance (variance equals 0)
zero_variance_columns = variances[variances == 0].index.tolist()

# Columns with non-zero variance (variance greater than 0)
non_zero_variance_columns = variances[variances > 0].index.tolist()

# Print columns with zero variance
if zero_variance_columns:
    print("Columns with zero variance:")
    print(zero_variance_columns)
else:
    print("No columns with zero variance found.")

## NO columns with zero variance found.

# Print columns with non-zero variance
if non_zero_variance_columns:
    print("Columns with non-zero variance:")
    print(non_zero_variance_columns)
else:
    print("No columns with non-zero variance found.")
    

################ Standarization ###############


data.info()
s= data.describe()

from sklearn.preprocessing import StandardScaler

# Initialise the Scaler
scaler = StandardScaler()

df= pd.DataFrame(scaler.fit_transform(numeric_columns))
df.describe()

# To scale data
data[['age','income_level', 'Winning_percentage', 'Days_Since_Last_Bet',	'Active_Days',
       'Total_Number_of_Bets','Total_Amount_Wagered','Average_Bet_Amount',
       'Number_of_Bonuses_Received','Amount_of_Bonuses_Received',
       'Revenue_from_Bonuses','Increase_in_Bets_After_Bonus',
       'Increase_in_wagering_after_Bonus','Should_Receive_Bonus']] = scaler.fit_transform(data[['age','income_level', 'Winning_percentage', 'Days_Since_Last_Bet',	'Active_Days',
              'Total_Number_of_Bets','Total_Amount_Wagered','Average_Bet_Amount',
              'Number_of_Bonuses_Received','Amount_of_Bonuses_Received',
              'Revenue_from_Bonuses','Increase_in_Bets_After_Bonus',
              'Increase_in_wagering_after_Bonus','Should_Receive_Bonus']])
# Convert the array back to a dataframe
dataset = pd.DataFrame(data)
res = dataset.describe()

# Save the preprocessed data to a new CSV file
data.to_csv('bonus_allocation_preprocessed_data.csv', index=False)

