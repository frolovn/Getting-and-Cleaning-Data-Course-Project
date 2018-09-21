# Getting and Cleaning Data Script

Description of the `run_analysis.R` script:

1. Download and unzip the data archive `getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`, check if file/folder exists.

2. Read, select `mean` and `std` values, and tidy up the features list from the `features.txt` file. 

3. Read `test` and `train` data sets, read `IDs` and `Activities` tables for each data set, combine all in two data frames.

4. Combine `test` and `train` data frames into single data frame, perform grouping by `ID` and `activity` and summarize using `mean` function.

5. Read activities table from the `activity_labels.txt` file, tidy up the values and replace the activity ID in the summarized data frame with the corresponding activity label.

6. Generate cleaned output "tidy.txt" file without row names and quotation marks.

Note: Most of the steps of the script are also followed by descriptive comments insde the code itself.
