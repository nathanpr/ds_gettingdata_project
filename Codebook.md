#Codebook
#Files and Inputs
The input data can be downloaded from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##File Details
The below files are used in this script:
NOTE: the Inertial Signals directory is not used by this script.
* activity_labels.txt - Activity Labels
* features.txt - Names of each of the variables in the X_test.txt, and X_train.txt data (561 variables)
* features_info.txt - Description of the features and labels (For informational purposes only)
* test/ - Test Data Directory
* test/X_test.txt - Main data for the test data (2947 rows, 561 columns)
* test/subject_test.txt - Subject IDs for the test data (2947 rows, 1 column)
* test/y_test.txt - Activity label IDs for the test data (2947 rows, 1 column)
* train/ - Training Data Direcotry 
* train/X_train.txt - Main data for training data (7352 rows, 561 column)
* train/subject_train.txt - Subject IDs for the training data (7352 rows, 1 column)
* train/y_train.txt - Activity label IDs for the training data (7352 rows, 1 column)

#Processing Steps
These are the steps the run_analysis.R takes for the resulting data output.
This is assuming the data is downloaded, unzipped, and loaded in to the working directory

1. Read each required file in to a data table 
2. Append the training data for the test set for X data, y data, and subject data
3. Select each of the mean and standard deviation variables from the X appended data
4. Rename columns in data set to be more human friendly
5. Add subject appended data and y appended data to X data making a single data frame
6. Melt the data to break down variables for each Subject + Activity
7. Convert the molten data to a data frame (dcast)
8. Write tidy data set to disk: uci_har_dataset_combined_tidy.txt

#Variables
* Subject - The ID of the subject
* Activity - The name of the activity the subject performed.
* T.Body.Acc.Mean.X - First of 77 other variables (Mean of each of the Subject's + Activity variable value)
* ...
* F.Body.Body.Gyro.Jerk.Mag.Mean.Freq - last of 77 other variables from the X data

#Additional Information
For more detailed information on the variables, you can visit the website explaining this project: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  or look at the top level directory text files.