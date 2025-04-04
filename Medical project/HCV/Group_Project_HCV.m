%{
HELP SECTION:
This script is designed to analyze a dataset containing information about various enzymes in the liver or kidneys, which are essential indicators for assessing the condition of these organs. The script processes the data column by column and performs different operations depending on the type of data in each column.

Key Features:
1. The script uses a table format for the dataset to handle both numeric and categorical data efficiently.
2. It automatically determines whether a column contains categorical or numeric data:
   - Categorical data is processed using the `Categorical_Data` function.
   - Numeric data is processed using the `Quantitative_Data` function.
3. It prompts the user for input to decide whether to proceed to the next column or stop the analysis.

Requirements:
- The dataset must be in a CSV file named "hcvdat0.csv" located in the working directory.
- Functions `Categorical_Data` and `Quantitative_Data` must be defined and available in the working directory.


How to Use:
1. Ensure the dataset and required functions are available in the working directory.
2. Run the script. It will:
   - Read the dataset.
   - Identify and process each column in sequence.
   - Prompt you to proceed or stop after each column.
3. Respond to the prompt:
   - Type `yes` to proceed to the next column.
   - Type `no` to stop the column processing.

Notes:
- If a column contains data that is neither numeric nor categorical, the script will issue an appropriate notification.
- This script is highly interactive and user-driven, making it ideal for exploring datasets column by column.
- (IMPORTANT): 
  If you want to put the cursor on the figures to see the pop up details,
  please be informed that you have to make sure that the programm is not
  running, meaning that it should always finish the run process, waiting for
  a input is an indication that the programm is still running.

Output:
- Detailed information is printed about the type of processing applied to each column.
- A final message confirms the completion of column processing.

%}



data_set = readtable("hcvdat0.csv");                                            %readtable is often the most versatile as it automatically handles both text and numeric data

column_names = data_set.Properties.VariableNames;

for name = column_names(2:end)                                                  % traversing through the columns of data
    colName = name{1};
    column_data = data_set.(colName);

    if iscell(column_data) || ischar(column_data) || iscategorical(column_data) % check if the cells and also the column itself are categorical using the iscategorical function
        fprintf('processing categorical column: %s\n\n' , colName)
        Categorical_Data(data_set, colName);                                    % evoking the function for categorical data
    
    elseif isnumeric(column_data)                                               % Check for the data being numeric if not categorical
        fprintf('processing Quantitative(numeric) column: %s\n\n' , colName);
        Quantitative_Data(data_set, colName);                                   % evoking the function for Quantitative (numeric) data
    end

    k = input('Proceed to the next column? (yes/no):' , 's');                   % asking to check for the next column, we do this for avoiding getting +50 figures at once which would crush our computer
    
    if strcmpi(k , 'no')                                                        % if answer is equal to no, program stops from running
        fprintf('Stopping the processing of columns. \n');
        break;
    elseif ~strcmpi(k , 'yes')                                                  % if answer is equal to yes, program has another traverse and gives us the specifications on the next column of data
        fprintf('Proceeding to the next column. \n')
        break;
    end
end

fprintf('Column processing complete.\n');                                       % when done with the loops, we now have all what we need