GetCleanDataCourseProject
=========================

The repository for the Getting and Cleaning Data course project.

This repository has one script, run_analysis.R, that performs
the required steps for the course project. 

*Input File: Samsung data from zip,
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .
*Output File: SamsungAveragesTidyDataset.txt (tab-delimited file)

###The project instructions indicate/suggest the following:
* Run the script where the zip file is located (no need to download it).
* The script requires no command line arguments. It can be sourced and run in R.
* If the zip is not there, the script exits with an error.
* Step 1: Merge training and test sets to create one data set.
* Step 2: Extract only the measurements on the mean and std dev.
* Step 3: Use descriptive activity names to name the activities in the data set
* Step 4: Appropriately label the data set with descriptive activity names.
* Step 5: Create a second, independent tidy data set with the average of
each variable for each activity and each subject.

###Notes:
* The general approach taken is to leave as much of the original 
data in its original state as possible, while still
following the guidelines of the project assignment. Consequently, no
transformations of the numeric data was performed, except taking the
averages as requested in step 5.
* If the zip is there, the files are extracted, overwriting the 
current zip files on disk.
* It was decided to not let the script run if the tidy data file
already existed to keep the script from overwriting the file.
* The script uses 2 helper functions. 
* buildUpTable reads in the appropriate subject and y files for 
a given data table (test or train). It changes the activity numbers
into descriptive names (step 3). It binds the subject and activity
information to the appropriate table.
* setupDataFiles checks for the existence of the zip file. It returns
an error if the zip is not there, otherwise it unzips the file.


## Details about the code

###Step 1
* read.table is used to read in the test and training data files 
as well as the activity data (individually). 
* buildUpTable is used
to complete the tables. Rbind is used to "merge" the training
and testing data into one data frame.

###Step 2
* To select features just dealing with the mean or standard deviation
from the original features, the names of the features are needed.
* These are read in with read.table. 
* gsub is used to remove punctuation. 
* The make.unique function was used to make sure the feature names
are all unique.
* grep is used to select the final features (any feature dealing
with mean or standard deviation from the original feature list,
as well as the subject and activity features).
* This trimmed feature list is used to subset the merged data frame
to create a trimmed-down data frame with only the needed features.
* There are 81 features -- subject, activity, plus 79 for mean or
standard deviation.

###Step 3
* The activities are given descriptive names in the buildUpTable
function.

###Step 4
* gsub is used to expand abbreviations in the remaining feature names.
* These are also converted to all lower case to fit the guidelines
given in the Week 4 lecture.
* See __CodeBook.md__ for details about each of the features in the tidy
dataset.

###Step 5
* The data.table library was used because it provides an easy way
to select data and apply functions.
* The trimmed data was converted into a data table and the subject and
activity were set as keys.
* For each subject, the data values for each activity were averaged. This
resulted in 6 rows for each subject (one row per activity), giving a 
total of 6 * 30 = 180 rows.
* Each subject has 79 averages for each activity.
* This 180 x 81 data table with the averages was saved as the tidy dataset
into SamsungAveragesTidyDataset.txt as tab-delimited data.

For more details, please refer to the comments in the R script.

