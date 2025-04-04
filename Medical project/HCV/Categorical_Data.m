%{
HELP SECTION:
Function Name: Categorical_Data

Purpose:
This function analyzes and visualizes categorical data from a specified column in a dataset. It handles missing values, calculates the frequency of each category, and generates visualizations to summarize the distribution of categories.

Inputs:
1. data_set (table) - The dataset containing the column to be analyzed.
2. colName (string/char) - The name of the column to be analyzed.

Outputs:
- No direct output is returned, but the function generates:
  1. Printed summary of missing values and category counts in the command window.
  2. Two types of plots for visual representation:
     - Bar graph showing the frequency of each category.
     - Pie chart showing the percentage distribution of each category.

Functionality:
1. **Missing Value Analysis**:
   - Identifies and counts missing values.
   - Prints the row indices of missing values, if any.

2. **Category Count and Frequency**:
   - Converts the column to categorical type if it is not already.
   - Computes the unique categories and their respective counts.
   - Prints the frequency of each category in the command window.

3. **Visualization**:
   - **Bar Graph**:
     - Displays the frequency of each category.
     - Labels each bar with the corresponding frequency value.
   - **Pie Chart**:
     - Displays the percentage distribution of each category.
     - Annotates each slice with the category name and its percentage.

Usage:
Call the function with the dataset and column name as arguments. For example:
Categorical_Data(data_set, 'Category');

Dependencies:
- The dataset must be in table format, and column names must be correctly specified.
- Ensure the column contains categorical or convertible data (e.g., strings or cell arrays of text).

Notes:
- If the column has no missing values, the function proceeds directly to frequency calculations.
- The pie chart displays percentage values rounded to two decimal places.

Example Output:
- Summary of missing values and category counts printed in the command window.
- A bar graph and a pie chart generated as separate figures.

Example:
If the column `Gender` has three categories: `Male`, `Female`, and `Other`, the function will:
1. Print the counts of each category.
2. Create a bar graph showing the frequency of each gender.
3. Create a pie chart showing the percentage distribution of genders.

%}


function Categorical_Data(data_set, colName)

column_data = data_set.(colName);

if ~iscategorical(column_data)                                              % First off, checking that our column of data is categorical just to make sure.
    column_data = categorical(column_data);
end

missing_Count = sum(ismissing(column_data));                                % Handling missing values.(we did not have any)

if missing_Count > 0

    fprintf('Column "%s" has %d missing values. \n\n' , colName , missing_Count);

    missing_rows = find(ismissing(column_data));
    fprintf('Missing values in column "%s" are located at rows: %s\n\n', colName, mat2str(missing_rows));

else

    fprintf('Column "%s" has no missing values.\n\n' , colName);

end

unique_categories = categories(column_data);                                % putting a variable for the categorical columns
category_counts = countcats(column_data);                                   % number of categories in each column.

fprintf('Category counts for "%s" :\n\n' , colName);

for i = 1:numel(unique_categories)                                          % traverse for finding different categories within a column
    fprintf(' %s: %d\n' , unique_categories{i}, category_counts(i));
end


figure('Position', [100,100,1000,700]);                                     % making a bar graph with the details coded below:
bar(category_counts);
set(gca , 'XTick' , 1:numel(unique_categories) , 'XTickLabel' , unique_categories)
xlabel(colName, 'FontSize', 14);
ylabel('Frequency', 'FontSize', 14);
title(sprintf('The Count for The %s of Persons with Liver Conditions (Bar Graph)', colName));
xtickangle(45);

for i = 1:numel(category_counts)                                            % adjustment for displaying the weight of bar on top of them.
    text(i , category_counts(i) + 0.5 , num2str(category_counts(i)) , 'VerticalAlignment','bottom' ,'HorizontalAlignment','center' ,  'FontSize',  12);
end


figure('Position', [100,100,1000,700]);                                     % pie chart, showing the percentage of each categorical variable within a column so we could see the majority, minorities.
percentage = (category_counts / sum(category_counts)) * 100;
labels = strcat(string(unique_categories), " (", string(round(percentage, 2)) , "%)");
pie(category_counts, labels);

title(sprintf('The Count for Each %s of Persons with Liver Conditions (Pie Chart)', colName));
end