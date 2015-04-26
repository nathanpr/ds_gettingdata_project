# ds_gettingdata_project
This is my course project for the Getting and Cleaning Data Coursera Course (course #3)

#explains what the analysis did....
Thr run_analysis.R script performs the following steps on the below referenced data set (UCI HAR Dataset):
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement. 
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive variable names. 
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Note: This code assumes the data has been downloaded, unzipped, and in the R working directory. The data in the "Inertial Signals" directory is not used in this program

The zipped data set can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#Steps to Run:
*Download the above dataset to your working directory
*Unzip data to the working directory
*Run run_analysis.R
*View the created tidy data set, named: uci_har_dataset_combined_tidy.txt

#Codebook
Please see the Codebook.md for a more detailed explaination for variables.
