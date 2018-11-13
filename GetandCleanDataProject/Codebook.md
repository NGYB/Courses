Study Design
======================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. We have merged both the training data and test data together.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

## For each record ie. each unique subject + activity combination it is provided:


- Average of the mean/standard deviation of the triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Average of the mean/standard deviation of the triaxial angular velocity from the gyroscope. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


Codebook
======================================

In the dataset "tidied_dataset",

Each of the rows represents one unique combination of subject (represented by number 1-30) and activity.

The subject is obtained from "UCI HAR Dataset/test/subject_test" and "UCI HAR Dataset/train/subject_train" and are merged together.

The activity is obtained from "UCI HAR Dataset/test/y_test" and "UCI HAR Dataset/train/y_train" and are merged together.

The activities are WALKING
, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS
, SITTING, STANDING
, LAYING
. This is obtained from "activity_labels".

Each of the columns represent the average of the features corresponding the the mean and standard deviation for each measurement.

All column names are switched to lower case characters. Also all brackets () are removed for easier reading. Also, all column names have a suffix '_avg'. This indicates that our data gives the average of the feature.

The units are seconds for time and hertz for frequency.

The column names of tidied_dataset (obtained from file "features") are in this order (left to right in the tidied_dataset):
* tbodyacc-mean-y 
* tbodyacc-mean-z 
* tgravityacc-mean-x 
* tgravityacc-mean-y 
* tgravityacc-mean-z 
* tbodyaccjerk-mean-x 
* tbodyaccjerk-mean-y 
* tbodyaccjerk-mean-z 
* tbodygyro-mean-x 
* tbodygyro-mean-y 
* tbodygyro-mean-z 
* tbodygyrojerk-mean-x 
* tbodygyrojerk-mean-y 
* tbodygyrojerk-mean-z 
* tbodyaccmag-mean 
* tgravityaccmag-mean 
* tbodyaccjerkmag-mean 
* tbodygyromag-mean 
* tbodygyrojerkmag-mean 
* fbodyacc-mean-x 
* fbodyacc-mean-y 
* fbodyacc-mean-z 
* fbodyacc-meanfreq-x 
* fbodyacc-meanfreq-y 
* fbodyacc-meanfreq-z 
* fbodyaccjerk-mean-x 
* fbodyaccjerk-mean-y 
* fbodyaccjerk-mean-z 
* fbodyaccjerk-meanfreq-x 
* fbodyaccjerk-meanfreq-y 
* fbodyaccjerk-meanfreq-z 
* fbodygyro-mean-x 
* fbodygyro-mean-y 
* fbodygyro-mean-z 
* fbodygyro-meanfreq-x 
* fbodygyro-meanfreq-y 
* fbodygyro-meanfreq-z 
* fbodyaccmag-mean 
* fbodyaccmag-meanfreq 
* fbodybodyaccjerkmag-mean 
* fbodybodyaccjerkmag-meanfreq 
* fbodybodygyromag-mean 
* fbodybodygyromag-meanfreq 
* fbodybodygyrojerkmag-mean 
* fbodybodygyrojerkmag-meanfreq 
* angle(tbodyaccmean,gravity) 
* angle(tbodyaccjerkmean),gravitymean) 
* angle(tbodygyromean,gravitymean) 
* angle(tbodygyrojerkmean,gravitymean) 
* angle(x,gravitymean) 
* angle(y,gravitymean) 
* angle(z,gravitymean) 
* tbodyacc-std-x 
* tbodyacc-std-y 
* tbodyacc-std-z 
* tgravityacc-std-x 
* tgravityacc-std-y 
* tgravityacc-std-z 
* tbodyaccjerk-std-x 
* tbodyaccjerk-std-y 
* tbodyaccjerk-std-z 
* tbodygyro-std-x 
* tbodygyro-std-y 
* tbodygyro-std-z 
* tbodygyrojerk-std-x 
* tbodygyrojerk-std-y 
* tbodygyrojerk-std-z 
* tbodyaccmag-std 
* tgravityaccmag-std 
* tbodyaccjerkmag-std 
* tbodygyromag-std 
* tbodygyrojerkmag-std 
* fbodyacc-std-x 
* fbodyacc-std-y 
* fbodyacc-std-z 
* fbodyaccjerk-std-x 
* fbodyaccjerk-std-y 
* fbodyaccjerk-std-z 
* fbodygyro-std-x 
* fbodygyro-std-y 
* fbodygyro-std-z 
* fbodyaccmag-std 
* fbodybodyaccjerkmag-std 
* fbodybodygyromag-std 
* fbodybodygyrojerkmag-std 