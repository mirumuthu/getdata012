
Getting and Cleaning data course project repository
##run_analysis.R 
The code does the following
- loads the necessary libraries. 
- Read the activity_labels.txt and assign a column name for easy manipulation.
- Read the features.txt to get the column names for each of the columns. Select only the columns that are mean and std deviation   readings as per the requirment
- Remove the special characters from the column names.
- Read the   data for subject, activity and the readings. Assign the column heading for the readings. 
- Select only the necessary columns from the readings. 
- Combine necessary columns, subject and activity all into one data frame called all_data
- Repeat the read, select and combine steps for train data. So that at the end all_data will contain both test and train data     sets. 
- Cast it as data table to find the avg for each of the variable by subject and activity. Store average in tidy data table. 
- Write the table out to tidy.txt file. 

