#load packages
library(dplyr)
library(reshape2)

#read tables
training_sets <- read.table("./train/X_train.txt")
test_sets <- read.table("./test/X_test.txt")
training_labels <- read.table("./train/y_train.txt")
test_labels <- read.table("./test/y_test.txt")
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")
features <- read.table("./features.txt")

#name the column headers
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"
names(training_sets) <- features$V2
names(test_sets) <- features$V2
names(training_labels) <- "activityID"
names(test_labels) <- "activityID"

# #1. Merge the training and the test sets to create one data set. 
merged_train <- cbind(subject_train, training_labels, training_sets)
merged_test <- cbind(subject_test, test_labels, test_sets)
merged_data <- rbind(merged_train, merged_test)

# #2.Extract only the measurements on the mean and standard deviation for each measurement.
mean_std <- merged_data[,grepl("mean|std|activity|subjectID",names(merged_data))]

# #3. Use descriptive activity names to name the activities in the data set
activity_labels <- read.table("./activity_labels.txt")
names(activity_labels) <- c("activityID", "activity")
mean_std2 <- merge(x=mean_std, y=activity_labels, by="activityID")

# remove activityID column and reorder columns so activity at beginning
mean_std2$activityID <- NULL
mean_std2 <- select(mean_std2, subjectID, activity, 2:79) 

# reorder table by subjectID
mean_std2 <- arrange(mean_std2, subjectID) 

# #4. Appropriately label the data set with descriptive variable names.
names(mean_std2) <- gsub("tBody", "Time - Body", names(mean_std2))
names(mean_std2) <- gsub("fBody", "Frequency - Body", names(mean_std2))
names(mean_std2) <- gsub("tGravity", "Time - Gravity", names(mean_std2))
names(mean_std2) <- gsub("BodyBody", "Body", names(mean_std2))
names(mean_std2) <- gsub("Body", "Body ", names(mean_std2))
names(mean_std2) <- gsub("-mean()", " - Mean", names(mean_std2))
names(mean_std2) <- gsub("-std()", " - Standard", names(mean_std2))
names(mean_std2) <- gsub("\\()", "", names(mean_std2))

# #5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- mean_std2
tidy_data <- melt(mean_std2, id = c("subjectID", "activity"))
tidy_data_shaped <- dcast(tidy_data, subjectID + activity ~ variable, mean)

# save data
write.table(mean_std2, file="./cleandata1.txt")
write.table(tidy_data_shaped, file = "./cleandata2.txt")
