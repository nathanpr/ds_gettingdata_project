#Steps from the descrpition 
#1. You should create one R script called run_analysis.R that does the following. 

library(plyr)
library(dplyr)

#2. Merges the training and the test sets to create one data set.
#3. Extracts only the measurementsT on the mean and standard deviation for each measurement. 

#NOTE: data is assumed to already be in your working directory

#read in data
features <- read.table("./UCI HAR Dataset/features.txt")
actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names=c("num", "name"))

subjTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xTest <- read.table("./UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")

subjTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

#append!
xTestTrain <- rbind(xTest, xTrain)
yTestTrain <- rbind(yTest, yTrain)

#take y, and replace with names of activity for later simplicity
yTestTrain <- merge(yTestTrain, actLabels, by.x="V1", by.y="num", sort=FALSE, all.x=FALSE, all.y=TRUE)[2]

subjTestTrain <- rbind(subjTest, subjTrain)

#filter x
#  1,2,3 # body acc x,y,z mean
#  4,5,6 # body acc std
#  121,122,123 # body gyro x,y,z mean
#  124,125,126 # body gyro x,y,z std 
keepIndicesX <- c(1:6,41:46,81:86, 121:126, 161:166, 
                  201:202, 214:215, 227:228, 240:241,253:254,266:271,294:296,
                  345:350,373:375,424:429,452:454,
                  503:504, 513, 516:517,526,529:530, 539,542:543, 552)

#corresponding labels with slightly nicer names.
#if I had time, I'd use grep and regex foo, but want to make nicer names
indexLabels <- c("T.Body.Acc.Mean.X","T.Body.Acc.Mean.Y","T.Body.Acc.Mean.Z",
                 "T.Body.Acc.Std.X","T.Body.Acc.Std.Y","T.Body.Acc.Std.Z",
                 "T.Gravity.Acc.Mean.X","T.Gravity.Acc.Mean.Y","T.Gravity.Acc.Mean.Z",
                 "T.Gravity.Acc.Std.X","T.Gravity.Acc.Std.Y","T.Gravity.Acc.Std.X",
                 "T.Body.AccJerk.Mean.X","T.Body.AccJerk.Mean.Y","T.Body.Acc.Jerk.Mean.Z",
                 "T.Body.AccJerk.Std.X","T.Body.AccJerk.Std.Y","T.Body.AccJerk.Std.Z",
                 "T.Body.Gyro.Mean.X","T.Body.Gyro.Mean.Y","T.Body.Gyro.Mean.Z",
                 "T.Body.Gyro.Std.X","T.Body.Gyro.Std.Y","T.Body.Gyro.Std.Z", 
                 "T.Body.Gyro.Jerk.Mean.X","T.Body.Gyro.Jerk.Mean.Y","T.Body.Gyro.Jerk.Mean.Z",
                 "T.Body.Gyro.Jerk.Std.X","T.Body.Gyro.Jerk.Std.Y","T.Body.Gyro.Jerk.Std.Z",
                 "T.Body.Acc.Mag.Mean","T.Body.Acc.Mag",
                 "T.Gravity.Acc.Mag.Mean","T.Gravity.Acc.Mag.Std",
                 "T.Body.Acc.Jerk.Mag.Mean","T.Body.Acc.Jerk.Mag-Std",
                 "T.Body.Gyro.Mag.Mean,","T.Body.Gyro.Mag.Std",
                 "T.Body.Gyro.Jerk.Mag.Mean","T.Body.GyroJerkMag.Std",
                 "F.Body.Acc.Mean.X","F.Body.Acc.Mean.Y","F.Body.Acc.Mean.Z",
                 "F.Body.Acc.Std.Z","F.Body.Acc.Std.Y","F.Body.Acc.Std.Z",
                 "F.Body.Acc.Jerk.Mean.X","F.Body.Acc.Jerk.Mean.Y","F.Body.Acc.Jerk.Mean.Z",
                 "F.Body.Acc.Jerk.Std.X","F.Body.Acc.Jerk.Std.Y","F.Body.Acc.Jerk.Std.Z",
                 "F.Body.Acc.Mean.Freq.X","F.Body.Acc.Mean.Freq.Y","F.Body.Acc.Mean.Freq.Z",
                 "F.Body.Gyro.Mean.X", "F.Body.Gyro.Mean.Y", "F.Body.Gyro.Mean.Z",
                 "F.Body.Acc.Jerk.Mean.Freq.X","F.Body.Acc.Jerk.Mean.Freq.Y","F.Body.Acc.Jerk.Mean.Freq.Z",
                 "F.Body.Gyro.Std.X","F.Body.Gyro.Std.Y","F.Body.Gyro.Std.Z",
                 "F.Body.Gyro.Mean.Freq.X","F.Body.Gyro.Mean.Freq.Y","F.Body.Gyro.Mean.Freq.Z",
                 "F.Body.AccMag.Mean","F.Body.Acc.Mag.Std",
                 "F.Body.Acc.Mag.Mean.Freq",
                 "F.Body.Body.Acc.Jerk.Mag.Mean","F.Body.Body.Acc.Jerk.Mag.Std",
                 "F.Body.Body.Acc.Jerk.Mag.Mean.Freq",
                 "F.Body.Body.Gyro.Mag.Mean","F.Body.Body.Gyro.Mag.Std",
                 "F.Body.Body.Gyro.Mag.Mean.Freq",
                 "F.Body.Body.Gyro.Jerk.Mag.Mean","F.Body.Body.Gyro.Jerk.Mag.Std",
                 "F.Body.Body.Gyro.Jerk.Mag.Mean.Freq",
                 "Activity", "Subject")
xTestTrain <- xTestTrain[,keepIndicesX]

#bind it all together
allTestTrain <- cbind(xTestTrain, yTestTrain, subjTestTrain)
names(allTestTrain) <- indexLabels

#4. Uses descriptive activity names to name the activities in the data set
#done earlier with y dataset num->namereplacement

#5. Appropriately labels the data set with descriptive variable names. 
#also done earlier with index names

#6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#each variable, AND for each subject, so melt by activity and subject
#molten, large table with subject, activity (the two keys), the variable name, and the variable value 
allTestTrainMelted <- melt(allTestTrain, id=c("Subject","Activity"))

#now dcast it to a data frame (combined Subject + Activity), calculate the variable's mean
allTestTrainTidy <- dcast(allTestTrainMelted, Subject + Activity ~ variable, mean)

#submission
#Please upload the tidy data set created in step 5 of the instructions. Please upload your data set as a txt file created with write.table() using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).
# (Each variable you measure should be in one column, Each different observation of that variable should be in a different row).

write.table(allTestTrainTidy, file="./uci_har_dataset_combined_tidy.txt", row.name=FALSE)
