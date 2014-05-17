### Code Book
## for Course Project 
## for Coursera Class Getting and Cleaning Data

Input data for this course project from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The project script, run_analysis.R creates a tidy dataset
SamsungAveragesTidyData.txt that contains 81 features (columns) and 180 rows.

The rows are for the 6 different activities, laying, sitting, standing,
walking, walking upstairs, and walking downstairs, for 30 different subjects
(6 * 30 = 180 rows).

The features include one for the subject id's (1 to (including) 30) and one
for the activity labels. The remaining 79 features are described in more
detail below.

IMPORTANT transformation of the original data: The measurements for the
79 features in the tidy dataset are the AVERAGES of the 
original measurements for a given subject for all occurrences of a given 
activity. The feature names do not include the word "average" in them
because 1) to help keep the feature names as short as possible (while
still meeting project guidelines) and 2) since all the measurements are
averages, there is no need to label every column as such. For example,
for subject 1, activity WALKING, the column tdbodyaccelerationmeanx
has the average for that subject's walking data points for the linear 
acceleration of the phone in the X dimension (in the time domain).


# General statements about the features

* Information about original features is taken from zip file's README.txt.

* The original data's features were normalized and restricted to the range 
[-1, 1].

* The original features originated with data collected from a Samsung phone
worn by the subjects performing various activities. The raw data
consisted of the linear acceleration along the X, Y, and Z axes of the phone
and the angular velocity (rotation, indicated as "gyro") in these 3
dimensions.

* The X-dimension is along the long face of the phone, the Y-dimension is
along the short face of the phone, and the Z-dimension is along the
width (thickness) of the phone.

* The raw data was sampled over time; consequently, it is considered as
being in the "time domain".

* The authors also used a Fast Fourier Transform (FFT) to convert some of
the time data into frequency data.

* Furthermore, the authors also took the first derivative of the linear
acceleration (the "jerk") and retained this data in additional features. They
also took the first derivative of the angular momentum, which they labeled
as "GyroJerk" in additional features.

* For some values, they took the X, Y, and Z data and computed the magnitude
(sqrt(X**2 + Y**2 + Z**2)) into additional features.

* They also computed the mean and standard deviation of many of the features.
For FFT-generated features, they also computed the weighted average of
the frequency components to get the mean frequency.

* The course guidelines said to select the measurements that deal with mean
and standard deviation only. According to the zip's README, features with
"mean" or "std" in their name are the ones that meet this guideline.

* It was deliberately decided to do no further pruning of features but to
keep all features that had "mean" or "std" in their name. This allows
the maximum of the original data that still meets the guidelines to
be used in creating the final tidy dataset.

* Note that a feature with "Mean" (capitalized) was not one to keep. The 
features with Mean in their name dealt with angles and were ignored.

* The original feature names contained punctuation that is illegal in R 
variable names like parentheses, as well as other punctuation. All 
punctuation was removed to adhere to guidelines presented in Week 4 
of the course.

* In addition, the course Week 4 lecture said to make the variables all
lowercase, so this was also done.

* Some of the original feature names used abbreviations. The course 
instructions indicated to make variables more descriptive, so these
abbreviations were expanded: freq to frequency, acc to acceleration, 
mag to magnitude, f to fft, and t to td (for time domain -- 
expanding all the way to time domain was not done to keep the
feature names from getting even longer).

* According to Wikipedia, "jerk" is the first derivative of acceleration.
If the original feature data regarding gyroscope measurements are
measuring angular velocity, their first derivative wouldn't be called
"jerk". However, the term "jerk" was retained (in the "gyrojerk"
features) to maintain traceability back to the original features.


# Specific statements about features

* subject: numbers 1 to 30, inclusive. These are the identifiers of the
subjects used in generating the original data.

* activity: values drawn from LAYING, SITTING, STANDING, WALKING, 
WALKING_UPSTAIRS and WALKING_DOWNSTAIRS. These were the original activity
labels. To stay as close as possible to the original data, while 
following project instructions, these labels were used.

* tdbodyaccelerationmeanx, tdbodyaccelerationmeany,	tdbodyaccelerationmeanz:
for one activity of one subject, the average time domain data about the 
mean of the linear acceleration of the phone, in the X, Y, and Z dimensions.

* tdbodyaccelerationstdx, tdbodyaccelerationstdy, tdbodyaccelerationstdz:
for one activity of one subject, the average time domain data about the 
standard deviation of the linear acceleration of the phone, in the X, Y, and
Z dimensions.

* tdgravityaccelerationmeanx, tdgravityaccelerationmeany, tdgravityaccelerationmeanz:
for one activity of one subject, the average time domain data about the 
mean of the linear acceleration of the gravity measurement, 
in the X, Y, and Z dimensions.

* tdgravityaccelerationstdx, tdgravityaccelerationstdy, tdgravityaccelerationstdz:
for one activity of one subject, the average time domain data about the 
standard deviation of the linear acceleration of the gravity measurement,
in the X, Y, and Z dimensions.

* tdbodyaccelerationjerkmeanx, tdbodyaccelerationjerkmeany, tdbodyaccelerationjerkmeanz:
for one activity of one subject, the average time domain data about the 
mean of the derivative of the linear acceleration of the phone
in the X, Y, and Z dimensions.

* tdbodyaccelerationjerkstdx, tdbodyaccelerationjerkstdy, tdbodyaccelerationjerkstdz:
for one activity of one subject, the average time domain data about the 
standard deviation of the derivative of the linear acceleration of the phone 
in the X, Y, and Z dimensions.

* tdbodygyromeanx, tdbodygyromeany, tdbodygyromeanz:
for one activity of one subject, the average time domain data about the 
mean of the angular velocity of the phone, in the X, Y, and Z dimensions.

* tdbodygyrostdx, tdbodygyrostdy, tdbodygyrostdz:
for one activity of one subject, the average time domain data about the 
standard deviation of the angular velocity of the phone, in the X, Y,
and Z dimensions.

* tdbodygyrojerkmeanx, tdbodygyrojerkmeany, tdbodygyrojerkmeanz:
for one activity of one subject, the average time domain data about the 
mean of the derivative of the angular velocity of the phone 
in the X, Y, and Z dimensions.

* tdbodygyrojerkstdx, tdbodygyrojerkstdy, tdbodygyrojerkstdz:
for one activity of one subject, the average time domain data about the 
standard deviation of the derivative of the angular velocity of the phone
in the X, Y, and Z dimensions.

* tdbodyaccelerationmagnitudemean, tdbodyaccelerationmagnitudestd:
for one activity of one subject, the average magnitude of the time domain
data about the linear acceleration of the phone, mean and standard
deviation.

* tdgravityaccelerationmagnitudemean, tdgravityaccelerationmagnitudestd:
for one activity of one subject, the average magnitude of the time domain
data about the linear acceleration of the gravity measurement, 
mean and standard deviation.

* tdbodyaccelerationjerkmagnitudemean, tdbodyaccelerationjerkmagnitudestd:
for one activity of one subject, the average magnitude of the time domain
data about the first derivative of the linear acceleration of the phone,
mean and standard deviation.

* tdbodygyromagnitudemean, tdbodygyromagnitudestd:
for one activity of one subject, the average magnitude of the time domain
data about the angular velocity of the phone, 
mean and standard deviation.

* tdbodygyrojerkmagnitudemean, tdbodygyrojerkmagnitudestd:
for one activity of one subject, the average magnitude of the time domain
data about the first derivative of the angular velocity of the phone,
mean and standard deviation.

* fftbodyaccelerationmeanx, fftbodyaccelerationmeany, fftbodyaccelerationmeanz:
for one activity of one subject, the average frequency domain data about the 
mean of the linear acceleration of the phone, in the X, Y, and Z dimensions.

* fftbodyaccelerationstdx, fftbodyaccelerationstdy, fftbodyaccelerationstdz:
for one activity of one subject, the average frequency domain data about the 
standard deviation of the linear acceleration of the phone, in the
X, Y, and Z dimensions.

* fftbodyaccelerationmeanfrequencyx, fftbodyaccelerationmeanfrequencyy, fftbodyaccelerationmeanfrequencyz:
for one activity of one subject, the average frequency domain data about the 
mean of the frequencies of the linear acceleration of the phone, in the
X, Y, and Z dimensions.

* fftbodyaccelerationjerkmeanx, fftbodyaccelerationjerkmeany, fftbodyaccelerationjerkmeanz:
for one activity of one subject, the average frequency domain data about the 
mean of the first derivative of the linear acceleration of the phone, 
in the X, Y, and Z dimensions.

* fftbodyaccelerationjerkstdx, fftbodyaccelerationjerkstdy, fftbodyaccelerationjerkstdz:
for one activity of one subject, the average frequency domain data about the 
standard deviation of the first derivative of the linear acceleration of the phone, 
in the X, Y, and Z dimensions.

* fftbodyaccelerationjerkmeanfrequencyx, fftbodyaccelerationjerkmeanfrequencyy, fftbodyaccelerationjerkmeanfrequencyz:
for one activity of one subject, the average frequency domain data about the 
mean of the frequencies of the first derivative of the linear acceleration
of the phone, in the X, Y, and Z dimensions.

* fftbodygyromeanx, fftbodygyromeany, fftbodygyromeanz:
for one activity of one subject, the average frequency domain data about the 
mean of the angular velocity of the phone, in the X, Y, and Z dimensions.

* fftbodygyrostdx, fftbodygyrostdy, fftbodygyrostdz:
for one activity of one subject, the average frequency domain data about the 
standard deviation of the angular velocity of the phone, in the
X, Y, and Z dimensions.

* fftbodygyromeanfrequencyx, fftbodygyromeanfrequencyy, fftbodygyromeanfrequencyz:
for one activity of one subject, the average frequency domain data about the 
mean of the frequencies of the first derivative of the angular velocity
of the phone, in the X, Y, and Z dimensions.

* fftbodyaccelerationmagnitudemean, fftbodyaccelerationmagnitudestd:
for one activity of one subject, the average magnitude of the frequency domain
data about the linear acceleration of the phone, mean and standard deviation.

* fftbodyaccelerationmagnitudemeanfrequency:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the linear acceleration of the phone.

* fftbodybodyaccelerationjerkmagnitudemean, fftbodybodyaccelerationjerkmagnitudestd:
for one activity of one subject, the average magnitude of the frequency domain
data about the first derivative of the linear acceleration of the phone,
mean and standard deviation.

* fftbodybodyaccelerationjerkmagnitudemeanfrequency:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the first derivative of the linear 
acceleration of the phone.

* fftbodybodygyromagnitudemean, fftbodybodygyromagnitudestd:
for one activity of one subject, the average magnitude of the frequency domain
data about the angular velocity of the phone, mean and standard deviation.

* fftbodybodygyromagnitudemeanfrequency:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the angular velocity of the phone.

* fftbodybodygyrojerkmagnitudemean, fftbodybodygyrojerkmagnitudestd:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the first derivative of the angular 
velocity of the phone.

* fftbodybodygyrojerkmagnitudemeanfrequency:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the first derivative of the angular 
velocity of the phone.



# Original data

Original dataset from: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original authors' citation request:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using 
a Multiclass Hardware-Friendly Support Vector Machine. International 
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
Spain. Dec 2012

