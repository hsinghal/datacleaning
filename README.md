# Readme for run_analysis.R

The input data set is picked up from the location - "~/UCI HAR Dataset/"

Files taken as input at various points of processing are 
1. "~/UCI HAR Dataset/test/X_test.txt"
2. "~/UCI HAR Dataset/train/X_train.txt"
3. "~/UCI HAR Dataset/features.txt"
4. "~/UCI HAR Dataset/train/y_train.txt"
5. "~/UCI HAR Dataset/test/y_test.txt"

The script merges the two files X_test.txt and X_train.txt and imports headers from the file features.txt.

Relevant columns from number 1 to 6 are extracted and stored for further computing. Activity numbers from the files y_train.txt and y_test.txt and activity description is used to decoded from the table. This is then split into 6 separate data frames, one each for each activity.

Once split, column averages for mean and standard deviation of acceleration calculated for each activitiy. These are transferred to the result dataframe with appropriate row and column headers for the tidy data set.
