#Read all the necessary files and store them
#body_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)

#body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)

#1.Merges the training and the test sets to create one data set.
#body_acc_x_merge <- rbind(body_acc_x_test, body_acc_x_train)
subject_merge <- rbind(subject_test, subject_train) #10299 rows, 1 col
X_merge <- rbind(X_test, X_train) #these are the dataset. 10299 rows denotes the observations. 561 cols denote the features.
y_merge <- rbind(y_test, y_train) #10299 rows, 1 col

#Create folder to store the merged data sets
if(!file.exists("UCI HAR Dataset_Merged")){
  dir.create("UCI HAR Dataset_Merged")
}

setwd("./UCI HAR Dataset_Merged")

write.table(subject_merge, file = "subject_merge.txt", sep = " ", row.names=FALSE, col.names=FALSE)
write.table(X_merge, file = "X_merge.txt", sep = " ", row.names=FALSE, col.names=FALSE)
write.table(y_merge, file = "y_merge.txt", sep = " ", row.names=FALSE, col.names=FALSE)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
ind <- grep("mean",features[,2],value=F, ignore.case=TRUE)
X_merge_mean <- X_merge[,ind]
ind2 <- grep("std",features[,2],value=F, ignore.case=TRUE)
X_merge_std <- X_merge[,ind2]
X_merge_mean_std <- cbind(X_merge_mean, X_merge_std)

#3.Uses descriptive activity names to name the activities in the data set
act <- activity_labels[unlist(y_merge),2]
X_merge_mean_std_act <- cbind(X_merge_mean_std, act)

#4.Appropriately labels the data set with descriptive variable names. 
var_names <- features[c(ind, ind2),2]
var_names <- tolower(var_names)
var_names <- sub("\\(\\)", "", var_names) #remove the ()
colnames(X_merge_mean_std_act) <- var_names
colnames(X_merge_mean_std_act)[ncol(X_merge_mean_std_act)] <- "activity"

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject.
library(reshape2)
X3 <- cbind(X_merge_mean_std_act, subject_merge)
colnames(X3)[ncol(X3)] <- "subject"

i <- colnames(X3)[1]
narrow0 <- X3[, c(i, "activity", "subject")]
tidied_dataset <- dcast(narrow0, subject+activity~i, value.var=i, mean)
ind <- which(colnames(tidied_dataset) == i) #rename the col so that it reflects this variable is now the average
colnames(tidied_dataset)[ind] <- paste(colnames(tidied_dataset)[ind], "avg", sep="_" )

for(i in colnames(X3)[2:(ncol(X3)-2)]){  
  cat(paste("*", i, "\n"))
  narrow0 <- X3[, c(i, "activity", "subject")]
  tidied0 <- dcast(narrow0, subject+activity~i, value.var=i, mean) #returns a data frame where the rows represent all unique combinations of subject and activity
  ind <- which(colnames(tidied0) == i) #rename the col so that it reflects this variable is now the average
  colnames(tidied0)[ind] <- paste(colnames(tidied0)[ind], "avg", sep="_" )    
  tidied_dataset <- merge(tidied_dataset, tidied0) #combine it all together
}

write.table(tidied_dataset, file = "tidied_dataset.txt", sep = "\t", row.names=FALSE)

#Go back to original working directory
setwd("../")
