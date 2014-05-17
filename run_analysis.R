#############################################################################
# Course Project Script for Coursera Class Getting and Cleaning Data
# Input: Samsung data from zip (see below).
# Output: SamsungAveragesTidyDataset.txt (tab-delimited file)
#
# Original dataset from: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Original authors citation request:
# Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
# Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using 
# a Multiclass Hardware-Friendly Support Vector Machine. International 
# Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
# Spain. Dec 2012
#
# Input data for this course project from:  
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# Run the code in the directory with the data zip file.
# Due to issues with downloading depending on the OS the code runs on,
# this script does not download the zip.
#
#############################################################################
# Helper functions
#
# Helper function to add subjects and activities to a data frame.
buildUpTable <- function(df, uciDir, whichDir, activs) {
    # Add subject and activities (y's).
    # First, set up subject filename, and get the subject information.
    # Note: using forward slash works fine on Windows. R converts to \\

    fname <- paste(uciDir, "/", whichDir, "/", "subject_", whichDir, 
                   ".txt", sep="")
    tsubs <- read.table(fname, header=FALSE, stringsAsFactors=FALSE)

    # Now the y's -- filename and activity numbers.
    fname <- paste(uciDir, "/", whichDir, "/", "y_", whichDir, ".txt", 
                   sep="")
    ys <- read.table(fname, header=FALSE, stringsAsFactors=FALSE)

    # Handle step 3: use descriptive activity names to name
    # the activities in the data set.
    # Convert the numbers in y to meaningful labels (as factor or string).
    # From http://www.statmethods.net/input/valuelabels.html.
    ys$V1 <- factor(ys$V1, levels=activs$V1, labels=activs$V2)
    ys$V1 <- as.character(ys$V1)

    # Add to data frame. Will name columns later.
    df <- cbind(df, tsubs, ys)
    return(df)
}
########################
# Helper function to setup the data files. It will unzip the zip file
# and currently overwrites zip's files on disk to be sure to get
# the latest files.
#
setupDataFiles <- function(uciDir) {
    # Return information for caller:
    success <- TRUE
    msg <- "OK"

    # See if the zip is there -- error if not
    fname <- paste("getdata_projectfiles_UCI HAR Dataset.zip", sep="")
    if (!file.exists(fname)) {
        success <- FALSE
        msg <- "Project data zip file not found."
    } else {
        # Unzip the file, will overwrite files on disk.
        unzip(fname)
    }
    ret_list <- list(success=success, msg=msg)
    return(ret_list)
}
##############################################################################
# Main part of code begins here. 
# The general approach taken is to leave as much of the original 
# data in its original state as possible, while still
# following the guidelines of the project assignment. Consequently, no
# transformations of the numeric data was performed, except taking the
# averages as requested in step 5.
#

# Step 0: The project submission says, "The code should have a file 
# run_analysis.R in the main directory that can be run as long as the 
# Samsung data is in your working directory."
# So check that the zip data is there and unzip it. 
#
# Can also check if already created the tidy data, in which don't re-run
# so the data is not overwritten by accident. Make user delete the
# tidy datafile first.
#
tidyFName = "SamsungAveragesTidyDataset.txt"
if (file.exists(tidyFName)) {
    msg <- paste("Final tidy dataset file,", tidyFName, 
                 ", already exists.",
                 "Delete this file first and re-run script.")
    stop(msg)
}

# Unzip file if it is there. Note: will overwrite existing zip files in 
# the zip if previously unzipped.
uciDirectory <- "UCI HAR Dataset"
filesSetup <- setupDataFiles(uciDirectory)
if (!filesSetup$success) {
    # Problem setting up files. Cannot continue
    stop(filesSetup$msg)
}

# Step 1: Merge training and test sets to create one data set.

# Easy way to read in the data. There is a space separator, but it is 
# not the same number of spaces between each number. Using the default 
# sep in read.table handles this situation fine.
tFName <- paste(uciDirectory, "/test/X_test.txt", sep="")
test <- read.table(tFName, header=FALSE, stringsAsFactors=FALSE) 
tFName <- paste(uciDirectory, "/train/X_train.txt", sep="")
train <- read.table(tFName, header=FALSE, stringsAsFactors=FALSE)

# Read the activity labels data
aFName <- paste(uciDirectory, "/activity_labels.txt", sep="")
activities <- read.table(aFName, header=FALSE, stringsAsFactors=FALSE)

# Complete the test table and the training table
test <- buildUpTable(test, uciDirectory, "test", activities)
train <- buildUpTable(train, uciDirectory, "train", activities)

# Combine the two tables. 
merged <- rbind(train, test) # Note must have same colnames


# Step 2: Extract only the measurements on the mean and std dev.
# To do this, need the feature names, so read them in. 
fFName <- paste(uciDirectory, "/features.txt", sep="")
fs <- read.table(fFName, header=FALSE, stringsAsFactors=FALSE, 
                 col.names=c("Pos", "Features"))

# Initial name clean up to just remove illegal characters in R variables.
# Reg exp help see http://www.endmemo.com/program/R/gsub.php 
# http://stat.ethz.ch/R-manual/R-devel/library/base/html/grep.html
# http://biostat.mc.vanderbilt.edu/wiki/pub/Main/SvetlanaEdenRFiles/regExprTalk.pdf

# Remove ()'s -- these are illegal R variable names
features <- gsub("[()]+$", "", fs$Features) 

# Additional cleanup here in preparation for step 4 below.
# Handle other punctuation separately. Doing this in a second step means
# the punctuation can easily be converted to just . by putting "\\." 
# in the gsub call instead of "", if desired.

features <- gsub("[^0-9a-zA-Z]+", "", features) # Remove punctuation

# Check if we have duplicate names and make unique if we do.
if (length(features) != length(unique(features))) {
   features <- make.unique(features)
}

# Add subject and activity to the end of the features.
features <- c(features, "subject", "activity")

# Set feature names without punctuation as colnames for merged table.
# Keeping capital letters for the moment until after trimming dataset.
colnames(merged) <- features

# Trim down to only features dealing with mean and std -- NOT "Mean". 
# Capitalized "Mean" feature names deal with angles--we don't want those.
# Also still want to keep subject and activity.
# This usage returns the column numbers, which are then used for 
# subsetting to obtain the trimmed down dataframe.
# See http://www.regular-expressions.info/rlanguage.html
selected_features <- grep("mean|std|subject|activity", features, 
                           perl=TRUE, value=FALSE)

trimmed <- merged[, selected_features]

# Step 3 was handled above in buildUpTable.

# Step 4: Appropriately label the data set with descriptive 
# activity names. 
trmCols <- colnames(trimmed)
# Since "f" is short for fft, replace leading f
trmCols <- gsub("^f","fft", trmCols)
# Since "t" is short for time domain (but time domain is too long)
# replace "t" with td
trmCols <- gsub("^t", "td", trmCols)
# Make Acc be Acceleration (clearer naming)
trmCols <- gsub("Acc","Acceleration", trmCols)
# Change Mag to Magnitude
trmCols <- gsub("Mag","Magnitude", trmCols)
# Change Freq to Frequency
trmCols <- gsub("Freq","Frequency", trmCols)

# Note: lecture video in Week 4 indicates that variables
# should not have upper case letters, dots, underscores. 
# Punctuation has been removed already. Now it is time to
# lower case everything. Frankly, this is really a bad idea.
# If a user wants all lower case, he/she can easily do so with tolower(). 
# But it is hard to put the upper case letters back in the right
# places if you decide you want them! Nevertheless, since we have no idea
# what the rubic asks for, I'll lower case the feature names.
trmCols <-tolower(trmCols)
colnames(trimmed) <-trmCols


# Step 5: Create a second, independent tidy data set with the average of
# each variable for each activity and each subject. 
# The instuctions also say, "Please upload a tidy data set according to the 
# instructions in the project description. Please upload your data set 
# as a separate file..." Since this is the only file requested, this is
# the only file that is created by this script.
#
# Using a data.table -- it enables easy row manipulations and fast
# function applications.
#
# From http://stackoverflow.com/questions/14937165/using-dynamic-column-names-in-data-table
# And data.table help, and forums.
library(data.table)

# This function call makes a data table by reference (no copy) so 
# doesn't use extra memory.
# from http://stackoverflow.com/questions/20345022/convert-a-data-frame-to-a-data-table-without-copy
dtable = setDT(trimmed)

# Use data.table's key technique to "subset" the table and apply a function
# to just the rows and columns desired. This will give the average for
# each subject for each of the 6 activities for each of the mean and std
# features (79 of these).
setkey(dtable, subject, activity)
averages <- dtable[, lapply(.SD, mean), .SDcols=1:79, by=key(dtable)]

# Note: the original data, according to the authors, was normalized
# between -1 and 1. Consequently, some data (such as std dev) could be
# negative. It was decided to maintain the original authors' normalization
# and to leave negative numbers alone. Consequently, no further manipulation
# of the numbers is done.

# And write the tidy dataset.
write.table(averages, tidyFName, sep="\t", row.names=FALSE)

