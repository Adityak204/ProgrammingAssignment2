#setting working directory
setwd("C:/Users/Umesh Singh/Desktop/r coursera/UCI HAR Dataset")

#loading labels
activityLabels <- read.table("activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

#loading features
features <- read.table("features.txt")
features[,2] <- as.character(features[,2])

#Extracting measurements on the mean and standard deviation for each measurement
featuresNeeded <- grep(".*mean.*|.*std.*", features[,2])
featuresNeeded.names <- features[featuresNeeded,2]

#loading dataset
train <- read.table("train/X_train.txt")
trainActivities <- read.table("train/Y_train.txt")
trainSubjects <- read.table("train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)


test <- read.table("test/X_test.txt")
testActivities <- read.table("test/Y_test.txt")
testSubjects <- read.table("test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

#merging train and test data and adding labels
FinalData <- rbind(train, test)
 colnames(FinalData) <- c("subject", "activity", featuresNeeded.names)

#turn activities & subjects into factors
FinalData$activity <- factor(FinalData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
FinalData$subject <- as.factor(FinalData$subject)

#creating tidy data set
tidyset <- FinalData[,1:81]

write.table(tidyset, "tidy.txt", row.names = FALSE, quote = FALSE)
