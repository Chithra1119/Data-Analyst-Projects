import pandas as pd
import numpy as np
from scipy.stats import mode, skew, kurtosis


# Load the WMS Report data (from Excel file)
wms_df = pd.read_excel(r"C:/Users/Administrator/Downloads/project/Dataset_221/WMS Report.xlsx")
wms_df.dtypes
# Load the Inverter Dataset data (from CSV file)
inverter_df = pd.read_csv('C:/Users/Administrator/Downloads/project/Dataset_221/Inverter dataset.csv',skiprows=2)
inverter_df.dtypes

#  Rename 'DATE/TIME' in inverter_df to match 'DATA & TIME' in wms_df
inverter_df.rename(columns={'DATE/TIME': 'DATE & TIME'}, inplace=True)

# Convert 'DATE & TIME' with specified format and timezone handling
inverter_df['DATE & TIME'] = pd.to_datetime(inverter_df['DATE & TIME'], format='%Y-%m-%d %H:%M:%S', utc=True, errors='coerce')

# Convert 'DATE & TIME' in the other dataframe similarly
wms_df['DATE & TIME'] = pd.to_datetime(wms_df['DATE & TIME'], format='%Y-%m-%d %H:%M:%S', utc=True, errors='coerce')

# Merge the two dataframes
merged_df = pd.merge(inverter_df, wms_df, how='left', on='DATE & TIME')

# Display the merged DataFrame
print(merged_df)


# Calculate statistics for numeric columns only
statistics = {
    'Mean': merged_df.select_dtypes(include=np.number).mean(),
    'Median':merged_df.select_dtypes(include=np.number).median(),
    'Mode': merged_df.select_dtypes(include=np.number).mode().iloc[0],  # Using iloc[0] to get the first mode value
    'Variance':merged_df.select_dtypes(include=np.number).var(),
    'Std Deviation': merged_df.select_dtypes(include=np.number).std(),
    'Range': merged_df.select_dtypes(include=np.number).apply(lambda x: x.max() - x.min()),
    'Skewness': merged_df.select_dtypes(include=np.number).apply(skew),
    'Kurtosis': merged_df.select_dtypes(include=np.number).apply(kurtosis)
}

# Create a DataFrame from the statistics dictionary
statistics_data = pd.DataFrame(statistics)

# Save statistics to an Excel file
output_file = 'statistics_data_solar1.xlsx'  # Name of the output Excel file
statistics_data.to_excel(output_file, index=True)

print(f"Statistics saved to {output_file}")

merged_df.info()

########### droping column where mean =0

# Select only numeric columns
numeric_data = merged_df.select_dtypes(include='number')

# Drop columns where the mean is 0
numeric_data = numeric_data.loc[:, numeric_data.mean() != 0]

# Combine with non-numeric columns
merged_df = pd.concat([numeric_data, merged_df.select_dtypes(exclude='number')], axis=1)

# Display the DataFrame after dropping columns
print("\nDataFrame after dropping columns with mean 0:")
print(merged_df)

merged_df.info()

#################### Missing valves #####################

#Find missing values
missing_values = merged_df.isnull().sum()

# Display missing values
print("\nMissing values in each column:")
print(missing_values)

# Handling missing values (example: fill with a specific value) used median
data_filled = merged_df.fillna('median')

#find missing value in LAB_REP_TIME AND PREV_TAP_TIME

# Display the DataFrame after filling missing values
print("\nDataFrame after filling missing values:")
print(data_filled)

# Replaced with median


#########################-DUPLICATE VALUES-#####################

# Check for duplicate rows in the DataFrame
duplicate_rows =merged_df[merged_df.duplicated()]

# Display the duplicate rows, if any
if not duplicate_rows.empty:
    print("Duplicate rows found:")
    print(duplicate_rows)
else:
    print("No duplicate rows found.")

####### No duplicate rows found


#####################-OUTLIER TREATMENT-#################

#              Outlier treatment using IQR method
def replace_outliers_with_median(dataframe):
    for column in dataframe.select_dtypes(include='number').columns:
        Q1 = dataframe[column].quantile(0.25)
        Q3 = dataframe[column].quantile(0.75)
        IQR = Q3 - Q1
        lower_bound = Q1 - 1.5 * IQR
        upper_bound = Q3 + 1.5 * IQR
        
        median = dataframe[column].median()
        
        dataframe[column] = np.where(
            (dataframe[column] < lower_bound) | (dataframe[column] > upper_bound),
            median,
            dataframe[column]
        )
    return dataframe

# Apply outlier treatment
data_no_outliers = replace_outliers_with_median(duplicate_rows)

# Display the DataFrame after outlier treatment
print("\nDataFrame after outlier treatment:")
print(data_no_outliers)


###############-ZERO VARIANCE AND NON ZERO VARIANCE-################
# Calculate variance for numeric columns only
numeric_columns = merged_df.select_dtypes(include=np.number).columns
variances = merged_df[numeric_columns].var()

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
    
    

# Calculate statistics for numeric columns only after data preprocessing
statistics_1 = {
    'Mean': merged_df.select_dtypes(include=np.number).mean(),
    'Median': merged_df.select_dtypes(include=np.number).median(),
    'Mode': merged_df.select_dtypes(include=np.number).mode().iloc[0],  # Using iloc[0] to get the first mode value
    'Variance': merged_df.select_dtypes(include=np.number).var(),
    'Std Deviation':merged_df.select_dtypes(include=np.number).std(),
    'Range': merged_df.select_dtypes(include=np.number).apply(lambda x: x.max() - x.min()),
    'Skewness': merged_df.select_dtypes(include=np.number).apply(skew),
    'Kurtosis': merged_df.select_dtypes(include=np.number).apply(kurtosis)
}

# Create a DataFrame from the statistics dictionary
statistics_data_1 = pd.DataFrame(statistics_1)

# Save statistics to an Excel file
output_file = 'statistics_data_solar2.xlsx'  # Name of the output Excel file
statistics_data_1.to_excel(output_file, index=True)

print(f"Statistics saved to {output_file}")


#Save the final processed DataFrame to an Excel file
final_output_file = 'processed_data_solar.xlsx'  # Name of the output Excel file
merged_df.to_excel(final_output_file, index=False)

print(f"Processed data saved to {final_output_file}")




############## CODE FOR AUTO EDA LIBRARIRES #################

import pandas as pd
import sweetviz
from autoviz.AutoViz_Class import AutoViz_Class
import dtale

# 1. Sweetviz
sweetviz_report = sweetviz.analyze(merged_df)
sweetviz_report.show_html("sweetviz_report.html")

## 2. AUTO VIZ

from autoviz.AutoViz_Class import AutoViz_Class
AV = AutoViz_Class()
AV.AutoViz(merged_df)
autoviz_report = AV.AutoViz(filename="AutoViz_Report.html", dfte=merged_df, depVar='', verbose=2, lowess=False, chart_format='html')


# 3.D-Tale
d = dtale.show(merged_df)
d.open_browser()


import shutil

# Specify the source path
source = r'C:/Users/Administrator/sweetviz_report.html'

# Specify the destination path (change to where you want to copy the file)
destination = r'C:/path/to/destination/sweetviz_report.html'

# Copy the file
shutil.copy(source, destination)

print("File copied successfully!")


######################  GRAPHICAL REPRESENTATION  ######################

import matplotlib.pyplot as plt
import seaborn as sns

# Set the style of seaborn
sns.set(style="whitegrid")

# Plot histograms for all columns
for column in merged_df.columns:
    plt.figure(figsize=(10, 6))
    sns.histplot(merged_df[column], kde=True, bins=30)
    plt.title(f'Histogram of {column}')
    plt.xlabel(column)
    plt.ylabel('Frequency')
    plt.show()

# Plot boxplots for all columns
for column in merged_df.columns:
    plt.figure(figsize=(10, 6))
    sns.boxplot(x=merged_df[column])
    plt.title(f'Boxplot of {column}')
    plt.xlabel(column)
    plt.show()


# Plot scatter plots for all pairs of columns
# This is only meaningful for numerical columns
numerical_cols = merged_df.select_dtypes(include=['float64', 'int64']).columns

for i in range(len(numerical_cols)):
    for j in range(i+1, len(numerical_cols)):
        plt.figure(figsize=(10, 6))
        sns.scatterplot(x=merged_df[numerical_cols[i]], y=merged_df[numerical_cols[j]])
        plt.title(f'Scatter plot of {numerical_cols[i]} vs {numerical_cols[j]}')
        plt.xlabel(numerical_cols[i])
        plt.ylabel(numerical_cols[j])
        plt.show()
        
# Calculate correlation matrix
corr_matrix = merged_df.corr()

# Plotting the correlation matrix using seaborn
plt.figure(figsize=(30, 24))  # Adjust the figure size (width, height) as necessary
sns.heatmap(corr_matrix, annot=True, cmap='coolwarm', fmt='.2f', linewidths=0.5)
plt.title('Correlation Matrix of Numeric Columns', fontsize=20)
plt.xticks(rotation=45)
plt.yticks(rotation=0)
plt.tight_layout()
plt.show()


import pandas as pd
import numpy as np

# Multivariate plot using seaborn pairplot
sns.pairplot(merged_df)
plt.show()
