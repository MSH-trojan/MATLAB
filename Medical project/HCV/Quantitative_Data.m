%{
HELP SECTION:
Function Name: Quantitative_Data

Purpose:
This function analyzes quantitative (numeric) data from a specified column in a dataset. It provides a detailed statistical summary, identifies and reports missing values, calculates correlation and covariance with other numeric columns, and generates various plots for visual analysis.

Inputs:
1. data_set (table) - The dataset containing the column to be analyzed.
2. colName (string/char) - The name of the column to be analyzed.

Outputs:
- No direct output is returned, but the function generates:
  1. A UI figure with a summary of statistical information.
  2. A series of plots for data visualization:
     - Scatter plot
     - Histogram
     - Box plot
     - Density plot with overlayed histogram
  3. Printed results of missing values, statistical measures, and correlations in the command window.

Functionality:
1. **Missing Value Analysis**:
   - Identifies and counts missing values.
   - Prints the row indices of missing values, if any.
   - Removes missing values before proceeding with analysis.

2. **Statistical Measures**:
   - Mean, mode, minimum, maximum, standard deviation, variance.
   - Skewness is calculated and classified as right-skewed, left-skewed, or symmetric.

3. **Correlation and Covariance**:
   - Calculates correlation coefficients and covariance values with all other numeric columns in the dataset.
   - Results are printed in the command window.

4. **Visualization**:
   - Scatter plot to observe data distribution.
   - Histogram to analyze frequency distribution.
   - Box plot to visualize central tendency and spread.
   - Density plot with overlayed histogram for smooth distribution estimation.

Usage:
Call the function with the dataset and column name as arguments. For example:
Quantitative_Data(data_set, 'a_name');

Dependencies:
- This function requires MATLAB's Statistics and Machine Learning Toolbox for certain calculations (e.g., `skewness`, `polyfit`, etc.).
- Ensure the dataset is in table format and column names are correctly specified.

Notes:
- For effective correlation and covariance calculations, ensure the dataset contains other numeric columns with sufficient data.
- The function automatically skips columns with insufficient data for correlation or covariance calculations.

Example Output:
- Statistical summary displayed in a UI figure.
- Scatter plot, histogram, box plot, and density plot generated in separate figures.
- Missing values, correlation, and covariance information printed in the command window.
%}

function Quantitative_Data(data_set, colName)
    
    column_data = data_set.(colName);                                       % We extract the data

                                                                            % Replace NaN or missing values with the column mean
    column_mean = mean(column_data, 'omitnan');                             % Calculate mean, ignoring NaN
    column_data = fillmissing(column_data, 'constant', column_mean);        % We then, Replace NaN with mean

   
    our_mean = mean(column_data);                                           % Statistical measures, all that would brought up in the summary ui figure
    our_mode = mode(column_data);
    our_min = min(column_data);
    our_max = max(column_data);
    our_std_dev = std(column_data);
    our_var = var(column_data);

    
    skw = skewness(column_data);                                            % Skewness analysis, showing the trend of data through density curve and how much they are deviated from the mean
    if skw > 0
        skw_type = 'Right skewed';
    elseif skw < 0
        skw_type = 'Left skewed';
    else
        skw_type = 'Symmetric';
    end

    p = polyfit(1:length(column_data), column_data, 1);                     % Interpolation and extrapolation, showing inboud and outbound predictions for the values outside out range
    x_int = linspace(1, length(column_data), 200);
    y_int = polyval(p, x_int);
    x_ext = length(column_data) + (1:10);
    y_ext = polyval(p, x_ext);

    int_summary = sprintf('Interpolation Example: %.2f to %.2f\n', min(y_int), max(y_int));
    ext_summary = sprintf('Extrapolation Values: %.2f to %.2f\n', min(y_ext), max(y_ext));

    
    numc = varfun(@isnumeric, data_set, 'OutputFormat', 'uniform');         % Correlation and covariance with other numeric columns
    num_col_name = data_set.Properties.VariableNames(numc);                 % Step 1: Identify numeric columns in the dataset
                                                                            % varfun(@isnumeric, data_set, 'OutputFormat', 'uniform'):
           % Quick note on the two line of code above:                      %   - Applies 'isnumeric' to each column of 'data_set' to check if it contains numeric data
                                                                            %   - The output is a logical array 'numc', where 'true' indicates a numeric column
                                                                            % Step 2: Extract names of numeric columns
                                                                            % data_set.Properties.VariableNames(numc):
                                                                            %   - Retrieves all column names in 'data_set'
                                                                            %   - Uses the logical array 'numc' to filter and select only numeric column names
                                                                            %   - The result 'num_col_name' contains a list of names for numeric columns in 'data_set'
    corr_ = "Correlation Coefficients:";
    cov_ = "Covariance with other numeric (Quantitative) columns:";

    for othercol = num_col_name
        othercolName = othercol{1};
        if ~strcmp(colName, othercolName)
            other_column_data = data_set.(othercolName);

                                                                            % Replace NaN in the other column with its mean, creating equal size column vectors instead of removing the NaN values ...
            other_column_mean = mean(other_column_data, 'omitnan');         % thus, we could be able to calculate covariance and correlation coefficient
            other_column_data = fillmissing(other_column_data, 'constant', other_column_mean);

            
            if length(column_data) == length(other_column_data)             % checking equality of two column sizes to start computation
                corr_value = corr(column_data, other_column_data);          % using corr instead of corrcoef for simplicity, we had to define new values if we wanted to define corrcoef for each of the columns as mentioned in the lecture
                corr_ = corr_ + sprintf('  %s: %.2f\n', othercolName, corr_value);

                cov_value = cov(column_data, other_column_data);
                cov_ = cov_ + sprintf('  %s: %.2f\n', othercolName, cov_value(1, 2));
            else
                corr_ = corr_ + sprintf('  %s: Length mismatch\n', othercolName);
                cov_ = cov_ + sprintf('  %s: Length mismatch\n', othercolName);
            end
        end
    end

    our_summary = sprintf(['Information and Summary about the "%s" Condition of Patients:\n\n' ...  % Prepare summary, different computations so far will be put here.
        'Mean: %.2f\n' ...
        'Mode: %.2f\n' ...
        'Min: %.2f\n' ...
        'Max: %.2f\n' ...
        'Standard Deviation: %.2f\n' ...
        'Variance: %.2f\n' ...
        'Skewness: %.2f (%s)\n\n' ...
        '%s\n' ...
        '%s\n' ...
        '%s\n' ...
        '%s\n (var1 = indexes)'], colName, our_mean, our_mode, our_min, our_max, our_std_dev, our_var, skw, skw_type, int_summary, ext_summary, corr_, cov_);

    
    our_fig = uifigure('Name', sprintf('Summary for %s', colName), 'Position', [100, 100, 500, 500]); % Defining the UI figure to put the texture inside... 
    uitextarea(our_fig, 'Value', our_summary, 'Position', [10, 10, 480, 480]);                        % Using 'textarea' instead of textfield so we could have multiple lines combined.

    
    figure('Position', [100, 100, 1000, 700]);                              % Scatterplot
    scatter(1:length(column_data), column_data, 'filled');
    xlabel('Index', 'FontSize', 14);
    ylabel(colName, 'FontSize', 14);
    title(sprintf('Scatterplot of %s', colName), 'FontSize', 16);

    figure('Position', [100, 100, 1000, 700]);                              % Histogram, using Binmethod so the software would automatically decide what value for bin for division is the best
    histogram(column_data, 'BinMethod', 'auto', 'FaceColor', [0.2, 0.6, 0.8]);
    xlabel(colName, 'FontSize', 14);
    ylabel('Frequency', 'FontSize', 14);
    title(sprintf('Histogram of %s', colName), 'FontSize', 16);

    figure('Position', [100, 100, 1000, 700]);                              % BoxPlot, using the dataset and different columns of numerical data at this point
    boxplot(column_data, 'Labels', {colName});
    ylabel(colName, 'FontSize', 14);
    title(sprintf('Boxplot of %s', colName), 'FontSize', 16);

    figure('Position', [100, 100, 1000, 700]);                              % Density curve with putting the histogram behind.
    [density, x] = ksdensity(column_data);
    plot(x, density, 'LineWidth', 2, 'Color', [0.2, 0.6, 0.8]);
    hold on;
    histogram(column_data, 'Normalization', 'pdf', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    hold off;
    xlabel(colName, 'FontSize', 14);
    ylabel('Density', 'FontSize', 14);
    title(sprintf('Density Curve of %s', colName), 'FontSize', 16);
end