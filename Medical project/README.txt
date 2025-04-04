		 _   _  ______     __  ____  _____ ____   ___  ____ _____ 
		| | | |/ ___\ \   / / |  _ \| ____|  _ \ / _ \|  _ \_   _|
		| |_| | |    \ \ / /  | |_) |  _| | |_) | | | | |_) || |  
		|  _  | |___  \ V /   |  _ <| |___|  __/| |_| |  _ < | |  
		|_| |_|\____|  \_/    |_| \_\_____|_|    \___/|_| \_\|_|  		
							
README


DATA ANALYSIS PROJECT: HCV Report Analysis

--------------------------------
TABLE OF CONTENTS
--------------------------------
A. Project Overview
B. Dataset Description
C. Objectives
D. Key Statistical Measures and Visualizations
E. Execution Instructions
F. Important Notes
G. Known Issues
H. Contact Information
I. Help Section

--------------------------------
A. PROJECT OVERVIEW
--------------------------------
This project analyzes an HCV report dataset to uncover trends and relationships within blood sample data. The analysis includes data cleaning, statistical exploration, and visualization using MATLAB.

--------------------------------
B. DATASET DESCRIPTION
--------------------------------
- Source: [HCV Dataset](https://archive.ics.uci.edu/ml/datasets/HCV+data)
- Description: The dataset contains blood sample data from individuals, including potential patients and regular individuals.
- Format: CSV file
- Key Attributes: Blood enzyme levels, patient status, demographic information

--------------------------------
C. OBJECTIVES
--------------------------------
1. Use MATLAB to analyze the dataset via statistical measures and identify trends.
2. Handle missing data to ensure consistency in computations.
3. Visualize data using figures such as bar graphs, scatter plots, and histograms.
4. Differentiate between categorical and numeric data for analysis.
5. Implement a user interface for summary statistics and trends.

--------------------------------
D. KEY STATISTICAL MEASURES AND VISUALIZATIONS
--------------------------------
- *Statistical Measures*:
  - Mean, Median, Mode
  - Max & Min
  - Standard Deviation & Variance
  - Correlation Coefficient
  - Covariance
- *Visualizations*:
  - Categorical Data: Bar Graph, Pie Chart
  - Numeric Data: Scatter Plot, Histogram, Box Plot, Density Curve

--------------------------------
E. EXECUTION INSTRUCTIONS
--------------------------------
1. Download the dataset from the link provided above.
2. Place the dataset and MATLAB scripts ('main script', 'Categorical_Data', 'Quantitative_Data') in the same folder.
3. Run the 'main script':
   - For each column:
     - View visualizations (e.g., scatter plots, pie charts).
     - Respond 'yes' or 'no' when prompted to continue analysis.
4. If 'no' is selected, the program will halt; otherwise, it will proceed to the next column.

--------------------------------
F. IMPORTANT NOTES
--------------------------------
1. Missing values are replaced with the column's mean.
2. Interactive figure details can only be accessed after program execution halts.
3. Data traversal skips the first column (index column).

--------------------------------
G. KNOWN ISSUES
--------------------------------
- *Array Size Error*: Occurs if missing values are not handled correctly.
- **Lining Problems*: Debugging needed for covariance alignment.
- *Categorical Data Identification*: Additional checks required to ensure proper handling.

--------------------------------
H. CONTACT INFORMATION
--------------------------------

- Mohammad Shahnaei: shahnaei@my.yorku.ca

--------------------------------
I. HELP SECTION
--------------------------------
The project provides detailed functions for:
- Quantitative Data: Computes statistical measures and visualizes numeric columns.
- Categorical Data: Analyzes frequencies and visualizes categorical columns.
- Refer to the script comments for additional usage instructions.
