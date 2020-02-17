### C3W4 Getting and Cleaning Data Peer-Graded Assignment

### Purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

### Here are the data for the project:
filename <- "getdata_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
## Download and unzip the dataset:
if (!file.exists(filename)){
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

## 1. Merges the training and the test sets to create one data set.
# Read in the training data sets.
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# Read in the test data sets.
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Read in labels
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Understand data sets
# dim(test_x); test_x_names <- names(test_x); tail(test_x_names)
# str(test_y)
# str(test_subject)
# dim(train_x); train_x_names <- names(train_x); tail(train_x)
# str(train_y)
# str(train_subject)
# str(features)
# View(activity_labels)

# Merge the columns of the Training tables, and add column to distinguish test and training data 
#  when the rows are merged
ID_train_x <- cbind("Train", train_subject, train_y, train_x)
# Create column names for the new columns
colnames(ID_train_x) <- c("Type", "Subject", "Activity")
# Merge the columns of the Test tables, and add column to distinguish test and training data 
ID_test_x <- cbind("Test", test_subject, test_y, test_x)
colnames(ID_test_x) <- c("Type", "Subject", "Activity")

# Append the Test data to the Training data 
# Got stuck a couple hours(!) here wirh rbind and column names:
# attempt to set 'colnames' on an object with less than two dimensions
combined_data <- rbind(ID_train_x, ID_test_x, deparse.level = 0)  # colnames = FALSE)

# Create column names for the new columns
new_col_names <- c("Type", "Subject", "Activity")
feature_col_names <- as.character(features[,2])
all_col_names <- c(new_col_names, feature_col_names)
# Removed the indexing here and it worked;
colnames(combined_data) <- all_col_names


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Identify the column names for the new table; This will imclude the columns from the cbind 
# and any with "mean" or "std" in its name.
has_mean_or_std <- (grepl("Type", all_col_names) |
                    grepl("Subject", all_col_names) |
                    grepl("Activity", all_col_names) |
                    grepl("mean", all_col_names) |
                    grepl("std", all_col_names))
# Create a table from the columns that should be kept (Type, Subject, Activity, containing "std" and "mean") 
mean_and_std <-  combined_data[ , has_mean_or_std == TRUE]           


# 3. Uses descriptive activity names to name the activities in the data set.
# Replace the index from the activity_labels file with the descriptive name
mean_and_std$Activity <- gsub("1", "WALKING", mean_and_std$Activity)
mean_and_std$Activity <- gsub("2", "WALKING_UPSTAIRS", mean_and_std$Activity)
mean_and_std$Activity <- gsub("3", "WALKING_DOWNSTAIRS", mean_and_std$Activity)
mean_and_std$Activity <- gsub("4", "SITTING", mean_and_std$Activity)
mean_and_std$Activity <- gsub("5", "STANDING", mean_and_std$Activity)
mean_and_std$Activity <- gsub("6", "LAYING", mean_and_std$Activity)


# 4. Appropriately labels the data set with descriptive variable names.
# Modify column names to make them more readable
names(mean_and_std) <- gsub("BodyBody", "Body", names(mean_and_std))
names(mean_and_std) <- gsub("tBody", "TimeBody", names(mean_and_std))
names(mean_and_std) <- gsub("fBody", "FreqBody", names(mean_and_std))
names(mean_and_std) <- gsub("tGravity", "TimeGravity", names(mean_and_std))
names(mean_and_std) <- gsub("-mean", "Mean", names(mean_and_std))
names(mean_and_std) <- gsub("-std", "Std", names(mean_and_std))
# names(mean_and_std) <- gsub("()", "", names(mean_and_std))  # Not working


# 5. From the data set in step 4, creates a second, independent tidy data set.
#    with the average of each variable for each activity and each subject.
avg_subj_activity <- aggregate(. ~Type + Activity + Subject, mean_and_std, mean)
# This one didn't work
# avg_subj_activity2 <- aggregate(mean_and_std, by=list(Subject, Activity), FUN=mean)

# Write the table to a file
library(xlsx)
write.xlsx(avg_subj_activity, file="./UCI HAR Dataset/avg_subj_activity.xlsx", 
           sheetName="Subj by Activity Avg")


