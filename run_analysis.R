#download the initial zip file containing the dataset to the working directory
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "./dataset.zip"
if (!file.exists(destFile)) {
  download.file(zipUrl, destfile=destFile)  
}

#unzip the downloaded file
zipFile <- "./dataset.zip"
if (!dir.exists("./UCI HAR Dataset")) {
  unzip(zipFile, files = NULL, list = FALSE, overwrite = TRUE, exdir = ".", unzip = "internal")
}

#load the data into the memory
activitiesFile <- "./UCI HAR Dataset/activity_labels.txt"
featuresFile <- "./UCI HAR Dataset/features.txt"

trainXFile <- "./UCI HAR Dataset/train/X_train.txt"
trainYFile <- "./UCI HAR Dataset/train/Y_train.txt"
trainSubjectFile <- "./UCI HAR Dataset/train/subject_train.txt"

testXFile <- "./UCI HAR Dataset/test/X_test.txt"
testYFile <- "./UCI HAR Dataset/test/Y_test.txt"
testSubjectFile <- "./UCI HAR Dataset/test/subject_test.txt"

activities <- read.table(activitiesFile)
features <- read.table(featuresFile)

trainX <- read.table(trainXFile)
trainY <- read.table(trainYFile)
trainSubject <- read.table(trainSubjectFile)

testX <- read.table(testXFile)
testY <- read.table(testYFile)
testSubject <- read.table(testSubjectFile)

# Merge the train and test datasets (union of the rows in train and test datasets)
bindX <- rbind(trainX, testX)
bindY <- rbind(trainY, testY)
bindSubject <- rbind(trainSubject, testSubject)


# Filters the features on names containing mean or std
features[,2] <- as.character(features[,2])
featuresFiltered <- grep(".*mean.*|.*std.*", features[,2])
featuresFiltered.names <- features[featuresFiltered,2]
featuresFiltered.names = gsub('-mean', 'Mean', featuresFiltered.names)
featuresFiltered.names = gsub('-std', 'Std', featuresFiltered.names)
featuresFiltered.names <- gsub('[-()]', '', featuresFiltered.names)

# Filter the data with the selected features
dataX <- bindX[featuresFiltered]

# Merge the 3 previous tables (union of columns: adding the subject and activity)
alldata <- cbind(bindSubject, bindY, dataX)

# Rename some columns
colnames(alldata) <- c("subject", "activity", featuresFiltered.names)

alldata$activity <- factor(alldata$activity, levels = activities[,1], labels = activities[,2])
alldata$subject <- as.factor(alldata$subject)

groupedData <- group_by(alldata, subject, activity)
tidyData <- summarise_each(groupedData, funs(mean(., na.rm = TRUE)))

write.table(tidyData, "tidyData.txt", row.names = FALSE, quote = FALSE)
