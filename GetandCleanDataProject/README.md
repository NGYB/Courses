##Introduction


One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data for this project

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

In this project, we clean the original data set obtained from the above location. 

##The script run_analysis.R does the following. 

   1. Merges the training and the test sets to create one data set. This means we merge the files 'X_train.txt' with 'X_test.txt', 'y_train.txt' with 'y_test.txt', 'subject_train.txt' with 'subject_test.txt'. 	

   2. Extracts only the measurements on the mean and standard deviation for each measurement. This is done by going through all the 561 features and extracting those features corresponding to the mean and standard deviation.

   3. Uses descriptive activity names to name the activities in the data set. The activities are labelled according to the file 'activity_labels.txt'.

   4. Appropriately labels the data set with descriptive variable names. Each column represents a variable. The column names are tidied such that all are lower case and all the brackets () are removed.

   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. All column names have a suffix '_avg' appended to reflect that these values are the average of the original values. This is stored in data frame 'tidied_dataset'.
