runAnalysis <- function() 
  {
  #READING ALL THE DATA
  
  # Reading train data
  trainData <- read.table("data/train/X_train.txt")
  # Reading train labels
  trainLabel <- read.table("data/train/y_train.txt")
  # Reading train subject
  trainSubject <- read.table("data/train/subject_train.txt")
  
  #Reading test data
  testData <- read.table("data/test/X_test.txt")
  #Reading test labels
  testLabel <- read.table("data/test/y_test.txt") 
  #Reading test subjects
  testSubject <- read.table("data/test/subject_test.txt")
  #Combining trainData and testData row-wise 
  combinedData <- rbind(trainData, testData) 
  #Since both data have same no. of columns we can join it 
  #row wise. Now nrow(trainData)+nrow(testData) = nrow(joinData)
  
  #Similarly we can join the two labels
  combinedLabel <- rbind(trainLabel, testLabel)
  #Similarly we can join the two subjects  
  combinedSubject <- rbind(trainSubject, testSubject)

   # Extracts only the measurements on the mean 
   # and standard deviation for each measurement. 
 
  features <- read.table("data/features.txt")
  meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
  combinedData <- combinedData[, meanStdIndices]
  names(combinedData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
  names(combinedData) <- gsub("mean", "Mean", names(combinedData)) 
  names(combinedData) <- gsub("std", "StandardDeviation", names(combinedData)) 
  names(combinedData) <- gsub("-", "", names(combinedData)) # remove "-" in column names 

  # Use descriptive activity names to name the activities in 
  # the data set
  
  activity <- read.table("data/activity_labels.txt")
  activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
  substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
  substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
  activityLabel <- activity[combinedLabel[, 1], 2]
  combinedLabel[, 1] <- activityLabel
  names(combinedLabel) <- "Activity"
 
 
  # Appropriately label the data set with descriptive activity names. 
  names(combinedSubject)<-"Subject"
  cleanedData <- cbind(combinedSubject, combinedLabel, combinedData)
  
  # Creates a second, independent tidy data set with the average of 
  # each variable for each activity and each subject. 
  
  subjectLen  <- length(table(combinedSubject)) 
  activityLen <- dim(activity)[1]
  columnLen   <- dim(cleanedData)[2]
  result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
  result <- as.data.frame(result)
  colnames(result) <- colnames(cleanedData)
  row <- 1
  for(i in 1:subjectLen) {
    for(j in 1:activityLen) {
      result[row, 1] <- sort(unique(combinedSubject)[, 1])[i]
      result[row, 2] <- activity[j, 2]
      bool1 <- i == cleanedData$Subject
      bool2 <- activity[j, 2] == cleanedData$Activity
      result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
      row <- row + 1
    }
  }
  write.table(result, "tidy_dataSet.txt") # write out the tidy dataset
}
