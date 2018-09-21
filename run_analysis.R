library(tools)   ##library needed to convert to title case
library(dplyr)   ##library needed to group and summarize the values

link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("dataset.zip")){download.file(link, "dataset.zip")}  
if (!file.exists("UCI HAR Dataset")) {unzip("dataset.zip")}

features <- read.table("UCI HAR Dataset/features.txt")   ##importing features 
list_features_mean_std <- grep(".*mean.*|*.std.*", features[,2])   ##generate a vector of all mean and std
features_mean_std <- features[list_features_mean_std,2]   ##grab the needed names
features_mean_std <- gsub("\\(\\)", "", features_mean_std)   ##making them more reader friendly
features_mean_std <- gsub("-", "", features_mean_std)
features_mean_std <- gsub("mean", "Mean", features_mean_std)
features_mean_std <- gsub("std", "StdD", features_mean_std)

test <- read.table("UCI HAR Dataset/test/X_test.txt") 
test_clean <- test[,list_features_mean_std]   ##grab only mean and std columns
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")   
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_combined <- cbind(test_subjects, test_activities, test_clean) ##combine all three

train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_clean <- train[,list_features_mean_std]   ##grab only mean and std columns
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_combined <- cbind(train_subjects, train_activities, train_clean)   ##combine all three

full_frame <- rbind(train_combined, test_combined)   ##combine everything into one big frame
colnames(full_frame) <- c("ID", "activity", features_mean_std) ##naming the columns

full_frame_mean <- full_frame %>% group_by(ID, activity) %>% summarise_all(funs(mean))  ## means for all IDs+activities

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")   ##importing labels
activity_labels[,2] <- tolower(activity_labels[,2])   ##making them more reader friendly
activity_labels[,2] <- toTitleCase(activity_labels[,2])
activity_labels[,2] <- gsub("_u", "_U", activity_labels[,2])
activity_labels[,2] <- gsub("_d", "_D", activity_labels[,2])
i <- NULL
for (i in 1:6) {full_frame_mean$activity[full_frame_mean$activity == i] <- activity_labels[i,2]} ##cycle renaming activities

write.table(full_frame_mean, "tidy.txt", row.names = FALSE, quote = FALSE)