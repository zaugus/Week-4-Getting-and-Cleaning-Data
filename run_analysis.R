### Download and unzip the dataset:

filename <- "getdata_dataset.zip"

if (!file.exists(filename)){
  download.file(url = paste("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                          sep = ""), 
              destfile = filename, mode = 'wb',cacheOK = FALSE)
}

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

### Load activity lables as tables and convert the class of activity as characters

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
Load features as tables and convert the class of features as characters

features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

### Extracts only the measurements on the mean and standard deviation for each measurement

featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

### Load the training datasets, training lables and subject who performed the activity window sample (ranges from 1 to 30)

train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

### Merge Training dataset, Activities and Subjects

train <- cbind(trainSubjects, trainActivities, train)

### Load the testing datasets, testing lables and subject who performed the activity window sample (ranges from 1 to 30)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

### Merge Testing dataset, Activities and Subjects

test <- cbind(testSubjects, testActivities, test)

### Merges the training and the testing data sets to create one data set

merged_data <- rbind(train, test)

### Appropriately labels the data set with descriptive variable names

colnames(merged_data) <- c("subject", "activity", featuresWanted.names)

### Convert activities & subjects into factors from activityLabels

merged_data$activity <- factor(merged_data$activity, 
                                levels = activityLabels[,1], 
                                labels = activityLabels[,2])

merged_data$subject <- as.factor(merged_data$subject)

### Convert merged_data into a molten data frame

library(reshape2)

merged_data.melted <- melt(merged_data, id = c("subject", "activity"))

### Cast a molten data frame into data frame subject and activities are breaked by variables and averaged Basically, this creates a independent tidy data set with the average of each variable for each activity and each subject.

merged_data.mean <- dcast(merged_data.melted, 
                           subject + activity ~ variable, mean)
                           
### Upload complete data set as a txt file created with write.table() using row.name=FALSE

write.table(merged_data.mean, file = "TidyDataSet.txt", 
            row.names = FALSE, quote = FALSE)
