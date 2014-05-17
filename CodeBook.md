# Code Book
## Course Project 
### for Coursera Class Getting and Cleaning Data

Input data for this course project from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The project script, run_analysis.R, creates a tab-delimited tidy dataset,
SamsungAveragesTidyData.txt, that contains 81 features (columns) and 180 rows.

The rows are for the 6 different activities, laying, sitting, standing,
walking, walking upstairs, and walking downstairs, for 30 different subjects
(6 * 30 = 180 rows).

The features include one for the subject id's (1 to (including) 30) and one
for the activity labels. The remaining 79 features are described in more
detail below.

IMPORTANT transformation of the original data: The values for the
79 features in the tidy dataset are the AVERAGES of the 
original measurements for a given subject for all occurrences of a given 
activity. The feature names do not include the word "average" in them
1) to help keep the feature names as short as possible (while
still meeting project guidelines) and 2) since all the measurements are
averages, there is no need to label every column as such. For example,
for subject 1, activity WALKING, the column tdbodyaccelerationmeanx
has the average for that subject's walking data points for the linear 
acceleration of the phone in the X dimension (in the time domain).


### General statements about the features

* Information about original features is taken from zip file's README.txt.

* The original data's features were normalized and restricted to the range 
[-1, 1].

* The original features originated with data collected from a Samsung phone
worn by the subjects performing various activities. The raw data
consisted of the linear acceleration along the X, Y, and Z axes of the phone
and the angular velocity (rotation, indicated as "gyro") in these 3
dimensions.

* The X-dimension is along the short face of the phone, the Y-dimension is
along the long face of the phone, and the Z-dimension is along the
width (thickness) of the phone.

* The raw data was sampled over time; consequently, it is considered as
being in the "time domain".

* The authors also used a Fast Fourier Transform (FFT) to convert some of
the time data into frequency data.

* Furthermore, the authors took the first derivative of the linear
acceleration (the "jerk") and retained this data in additional features. 
In addition, they took the first derivative of the angular momentum, which
they labelled as "GyroJerk" in additional features.

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

* Note that a feature with "Mean" (capitalized) in its name was not one to
keep. The features with Mean in their name dealt with angles and were ignored.

* The original feature names contained punctuation that is illegal in R 
variable names like parentheses, as well as other punctuation. All 
punctuation was removed to adhere to guidelines presented in Week 4 
of the course.

* In addition, the course Week 4 lecture said to make the variables all
lower case, so this was done.

* Some of the original feature names used abbreviations. The course 
instructions indicated to make variables more descriptive, so these
abbreviations were expanded: freq to frequency, acc to acceleration, 
mag to magnitude, f to fft, and t to td (for time domain -- 
expanding all the way to time domain was not done to keep the
feature names from getting even longer).

* According to Wikipedia, "jerk" is the first derivative of acceleration.
If the original feature data regarding gyroscope measurements are
measuring angular velocity, their first derivative likely shouldn't be called
"jerk". However, the term "jerk" was retained (in the "gyrojerk"
features) to maintain traceability back to the original features.


### The features of the tidy dataset

* __subject__: numbers 1 to 30, inclusive. These are the identifiers of the
subjects used in generating the original data.

* __activity__: values drawn from LAYING, SITTING, STANDING, WALKING, 
WALKING_UPSTAIRS and WALKING_DOWNSTAIRS. These were the original activity
labels. To stay as close as possible to the original data, while 
following project instructions, these labels were used.

* __tdbodyaccelerationmeanx__, __tdbodyaccelerationmeany__, __tdbodyaccelerationmeanz__:
for one activity of one subject, the average time domain data about the 
mean of the linear acceleration of the phone, in the X, Y, and Z dimensions.

* __tdbodyaccelerationstdx__, __tdbodyaccelerationstdy__, __tdbodyaccelerationstdz__:
for one activity of one subject, the average time domain data about the 
standard deviation of the linear acceleration of the phone, in the X, Y, and
Z dimensions.

* __tdgravityaccelerationmeanx__, __tdgravityaccelerationmeany__, __tdgravityaccelerationmeanz__:
for one activity of one subject, the average time domain data about the 
mean of the linear acceleration of gravity, 
in the X, Y, and Z dimensions.

* __tdgravityaccelerationstdx__, __tdgravityaccelerationstdy__, __tdgravityaccelerationstdz__:
for one activity of one subject, the average time domain data about the 
standard deviation of the linear acceleration of gravity,
in the X, Y, and Z dimensions.

* __tdbodyaccelerationjerkmeanx__, __tdbodyaccelerationjerkmeany__, __tdbodyaccelerationjerkmeanz__:
for one activity of one subject, the average time domain data about the 
mean of the derivative of the linear acceleration of the phone
in the X, Y, and Z dimensions.

* __tdbodyaccelerationjerkstdx__, __tdbodyaccelerationjerkstdy__, __tdbodyaccelerationjerkstdz__:
for one activity of one subject, the average time domain data about the 
standard deviation of the derivative of the linear acceleration of the phone 
in the X, Y, and Z dimensions.

* __tdbodygyromeanx__, __tdbodygyromeany__, __tdbodygyromeanz__:
for one activity of one subject, the average time domain data about the 
mean of the angular velocity of the phone, in the X, Y, and Z dimensions.

* __tdbodygyrostdx__, __tdbodygyrostdy__, __tdbodygyrostdz__:
for one activity of one subject, the average time domain data about the 
standard deviation of the angular velocity of the phone, in the X, Y,
and Z dimensions.

* __tdbodygyrojerkmeanx__, __tdbodygyrojerkmeany__, __tdbodygyrojerkmeanz__:
for one activity of one subject, the average time domain data about the 
mean of the derivative of the angular velocity of the phone 
in the X, Y, and Z dimensions.

* __tdbodygyrojerkstdx__, __tdbodygyrojerkstdy__, __tdbodygyrojerkstdz__:
for one activity of one subject, the average time domain data about the 
standard deviation of the derivative of the angular velocity of the phone
in the X, Y, and Z dimensions.

* __tdbodyaccelerationmagnitudemean__, __tdbodyaccelerationmagnitudestd__:
for one activity of one subject, the average magnitude of the time domain
data about the linear acceleration of the phone, mean and standard
deviation.

* __tdgravityaccelerationmagnitudemean__, __tdgravityaccelerationmagnitudestd__:
for one activity of one subject, the average magnitude of the time domain
data about the linear acceleration of gravity, 
mean and standard deviation.

* __tdbodyaccelerationjerkmagnitudemean__, __tdbodyaccelerationjerkmagnitudestd__:
for one activity of one subject, the average magnitude of the time domain
data about the first derivative of the linear acceleration of the phone,
mean and standard deviation.

* __tdbodygyromagnitudemean__, __tdbodygyromagnitudestd__:
for one activity of one subject, the average magnitude of the time domain
data about the angular velocity of the phone, 
mean and standard deviation.

* __tdbodygyrojerkmagnitudemean__, __tdbodygyrojerkmagnitudestd__:
for one activity of one subject, the average magnitude of the time domain
data about the first derivative of the angular velocity of the phone,
mean and standard deviation.

* __fftbodyaccelerationmeanx__, __fftbodyaccelerationmeany__, __fftbodyaccelerationmeanz__:
for one activity of one subject, the average frequency domain data about the 
mean of the linear acceleration of the phone, in the X, Y, and Z dimensions.

* __fftbodyaccelerationstdx__, __fftbodyaccelerationstdy__, __fftbodyaccelerationstdz__:
for one activity of one subject, the average frequency domain data about the 
standard deviation of the linear acceleration of the phone, in the
X, Y, and Z dimensions.

* __fftbodyaccelerationmeanfrequencyx__, __fftbodyaccelerationmeanfrequencyy__, __fftbodyaccelerationmeanfrequencyz__:
for one activity of one subject, the average frequency domain data about the 
mean of the frequencies of the linear acceleration of the phone, in the
X, Y, and Z dimensions.

* __fftbodyaccelerationjerkmeanx__, __fftbodyaccelerationjerkmeany__, __fftbodyaccelerationjerkmeanz__:
for one activity of one subject, the average frequency domain data about the 
mean of the first derivative of the linear acceleration of the phone, 
in the X, Y, and Z dimensions.

* __fftbodyaccelerationjerkstdx__, __fftbodyaccelerationjerkstdy__, __fftbodyaccelerationjerkstdz__:
for one activity of one subject, the average frequency domain data about the 
standard deviation of the first derivative of the linear acceleration of the phone, 
in the X, Y, and Z dimensions.

* __fftbodyaccelerationjerkmeanfrequencyx__, __fftbodyaccelerationjerkmeanfrequencyy__, __fftbodyaccelerationjerkmeanfrequencyz__:
for one activity of one subject, the average frequency domain data about the 
mean of the frequencies of the first derivative of the linear acceleration
of the phone, in the X, Y, and Z dimensions.

* __fftbodygyromeanx__, __fftbodygyromeany__, __fftbodygyromeanz__:
for one activity of one subject, the average frequency domain data about the 
mean of the angular velocity of the phone, in the X, Y, and Z dimensions.

* __fftbodygyrostdx__, __fftbodygyrostdy__, __fftbodygyrostdz__:
for one activity of one subject, the average frequency domain data about the 
standard deviation of the angular velocity of the phone, in the
X, Y, and Z dimensions.

* __fftbodygyromeanfrequencyx__, __fftbodygyromeanfrequencyy__, __fftbodygyromeanfrequencyz__:
for one activity of one subject, the average frequency domain data about the 
mean of the frequencies of the first derivative of the angular velocity
of the phone, in the X, Y, and Z dimensions.

* __fftbodyaccelerationmagnitudemean__, __fftbodyaccelerationmagnitudestd__:
for one activity of one subject, the average magnitude of the frequency domain
data about the linear acceleration of the phone, mean and standard deviation.

* __fftbodyaccelerationmagnitudemeanfrequency__:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the linear acceleration of the phone.

* __fftbodybodyaccelerationjerkmagnitudemean__, __fftbodybodyaccelerationjerkmagnitudestd__:
for one activity of one subject, the average magnitude of the frequency domain
data about the first derivative of the linear acceleration of the phone,
mean and standard deviation.

* __fftbodybodyaccelerationjerkmagnitudemeanfrequency__:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the first derivative of the linear 
acceleration of the phone.

* __fftbodybodygyromagnitudemean__, __fftbodybodygyromagnitudestd__:
for one activity of one subject, the average magnitude of the frequency domain
data about the angular velocity of the phone, mean and standard deviation.

* __fftbodybodygyromagnitudemeanfrequency__:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the angular velocity of the phone.

* __fftbodybodygyrojerkmagnitudemean__, __fftbodybodygyrojerkmagnitudestd__:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the first derivative of the angular 
velocity of the phone.

* __fftbodybodygyrojerkmagnitudemeanfrequency__:
for one activity of one subject, the average magnitude of the frequency domain
data for the mean frequencies of the first derivative of the angular 
velocity of the phone.



### Original data

Original dataset from: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Original authors' citation request:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using 
a Multiclass Hardware-Friendly Support Vector Machine. International 
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, 
Spain. Dec 2012

