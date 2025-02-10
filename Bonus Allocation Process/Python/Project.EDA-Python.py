import pandas as pd
import numpy as np

data = pd.read_csv(r"C:/Users/Administrator/Downloads/Projects/Bonus Allocation Data - Master Data.csv.csv")
data

data.dtypes
data.info()
data.describe()

data.customer_id= data.customer_id.astype('str')
data.dtypes

# Calculate statistics for numeric columns only
statistics = {
    'Mean': data.select_dtypes(include=np.number).mean(),
    'Median': data.select_dtypes(include=np.number).median(),
    'Mode': data.select_dtypes(include=np.number).mode().iloc[0],  # Using iloc[0] to get the first mode value
    'Variance': data.select_dtypes(include=np.number).var(),
    'Std Deviation': data.select_dtypes(include=np.number).std(),
    'Range': data.select_dtypes(include=np.number).apply(lambda x: x.max() - x.min()),
    'Skewness': data.select_dtypes(include=np.number).skew(),
    'Kurtosis': data.select_dtypes(include=np.number).kurtosis()
}

# Create a DataFrame from the statistics dictionary
statistics_data = pd.DataFrame(statistics)

output_file = 'statistics_summary_1.xlsx'  # Name of the output Excel file
statistics_data.to_excel(output_file, index=True)

####################    GRAPHICAL REPRESENTATION

import matplotlib.pyplot as plt
import seaborn as sns

###Univariate

# Set the style of seaborn
sns.set(style="whitegrid")

# Plot histograms for all columns
for column in data.columns:
    plt.figure(figsize=(10, 6))
    sns.histplot(data[column], kde=True, bins=30)
    plt.title(f'Histogram of {column}')
    plt.xlabel(column)
    plt.ylabel('Frequency')
    plt.show()

# Plot boxplots for all columns
for column in data.select_dtypes(include=['number']).columns:
    plt.figure(figsize=(10, 6))
    sns.boxplot(x=data[column])
    plt.title(f'Boxplot of {column}')
    plt.xlabel(column)
    plt.show()

##Bivariate

# Plot scatter plots for all pairs of columns
# This is only meaningful for numerical columns
numerical_cols = data.select_dtypes(include=['float64', 'int64']).columns

for i in range(len(numerical_cols)):
    for j in range(i+1, len(numerical_cols)):
        plt.figure(figsize=(10, 6))
        sns.scatterplot(x=data[numerical_cols[i]], y=data[numerical_cols[j]])
        plt.title(f'Scatter plot of {numerical_cols[i]} vs {numerical_cols[j]}')
        plt.xlabel(numerical_cols[i])
        plt.ylabel(numerical_cols[j])
        plt.show()
        
##Multivariate        


from itertools import combinations

def interaction_plots(data, categorical_column=None):
    num_cols = data.select_dtypes(include='number').columns
    comb = list(combinations(num_cols, 2))

    plt.figure(figsize=(10, 6))
    for i, (x, y) in enumerate(comb, start=1):
        plt.subplot(len(comb) // 2 + len(comb) % 2, 2, i)
        if categorical_column:
            sns.scatterplot(data=data, x=x, y=y, hue=categorical_column)
        else:
            sns.scatterplot(data=data, x=x, y=y)
        plt.title(f'Interaction between {x} and {y}')
    plt.tight_layout()
    plt.show()

# Optional: specify a categorical column if needed
categorical_column = 'your_categorical_column'  # or None
interaction_plots(data, categorical_column)


