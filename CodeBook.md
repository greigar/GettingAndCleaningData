# Getting and Cleaning Data Project

# Code Book

This code book describes the variables, the data, and transformations and work performed to clean up the data.

## Source data
This project creates a tidy, summarised data set from input data sets.  The input data sets were
sourced from the following project:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data was obtained from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The above project measured six activities carried out by 30 volunteers.  Each subject and activity was measured using a smartphone.

Note that:

* Features are normalized and bounded within [-1,1].
* For more information about this dataset contact: activityrecognition@smartlab.ws


## Output Data Set

The data set created by the `run_analysis.R` script is called `summary_test_train_set` - a data frame of dimensions [180 x 88] - and contains the following:

* The subject (person) ID - an integer from 1 to 30
* The activity label a character string that is one of WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING
* The remaining columns contain averages for each measurement variable (feature) for each activity label and each subject.

These features are described in the following text, taken from the original project README.txt and features_info.txt files.

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

> These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


### Units of measurement
From the original project README.txt file:

* The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.  The same description applies for the Y and Z axis.
* Velocity is measured in radians/second.


## Data set processing

The data set was created by doing the following steps:

* Merge the train & test data files:
    + train/X_train.txt & test/X_test.txt
* Add subject IDs and activity IDs to the data set by reading the files:
    + train/subject_train.txt & test/subject_test.txt
* Assign activity labels to the data set by reading the files:
    + train/y_train.txt & test/y_test.txt

From the original "X" test and train datasets, only columns with names containing "mean" or "std" (regardless of case) were included in the resulting, summary data set.

The average of each feature was taken per subject per activity.



## Data set columns

* Column 1 : subjects : The subject number taken from subject text data files
* Column 2 : activity_labels : The name of the activity taken, cross-referenced with the activity labels data
* Columns 3 to 88 : "tBodyAcc-mean()-X" to "angle(Z,gravityMean)"  : mean of the measurement per subject and activity.  Note that the characters: "-", "(", ")" are replaced by "." when reading the data set in from file (see README.md).


 Col # |  Column Name
-------|---------------------------------------------
     1 |  subjects
     2 |  activity_labels
     3 |  tBodyAcc-mean()-X
     4 |  tBodyAcc-mean()-Y
     5 |  tBodyAcc-mean()-Z
     6 |  tBodyAcc-std()-X
     7 |  tBodyAcc-std()-Y
     8 |  tBodyAcc-std()-Z
     9 |  tGravityAcc-mean()-X
    10 |  tGravityAcc-mean()-Y
    11 |  tGravityAcc-mean()-Z
    12 |  tGravityAcc-std()-X
    13 |  tGravityAcc-std()-Y
    14 |  tGravityAcc-std()-Z
    15 |  tBodyAccJerk-mean()-X
    16 |  tBodyAccJerk-mean()-Y
    17 |  tBodyAccJerk-mean()-Z
    18 |  tBodyAccJerk-std()-X
    19 |  tBodyAccJerk-std()-Y
    20 |  tBodyAccJerk-std()-Z
    21 |  tBodyGyro-mean()-X
    22 |  tBodyGyro-mean()-Y
    23 |  tBodyGyro-mean()-Z
    24 |  tBodyGyro-std()-X
    25 |  tBodyGyro-std()-Y
    26 |  tBodyGyro-std()-Z
    27 |  tBodyGyroJerk-mean()-X
    28 |  tBodyGyroJerk-mean()-Y
    29 |  tBodyGyroJerk-mean()-Z
    30 |  tBodyGyroJerk-std()-X
    31 |  tBodyGyroJerk-std()-Y
    32 |  tBodyGyroJerk-std()-Z
    33 |  tBodyAccMag-mean()
    34 |  tBodyAccMag-std()
    35 |  tGravityAccMag-mean()
    36 |  tGravityAccMag-std()
    37 |  tBodyAccJerkMag-mean()
    38 |  tBodyAccJerkMag-std()
    39 |  tBodyGyroMag-mean()
    40 |  tBodyGyroMag-std()
    41 |  tBodyGyroJerkMag-mean()
    42 |  tBodyGyroJerkMag-std()
    43 |  fBodyAcc-mean()-X
    44 |  fBodyAcc-mean()-Y
    45 |  fBodyAcc-mean()-Z
    46 |  fBodyAcc-std()-X
    47 |  fBodyAcc-std()-Y
    48 |  fBodyAcc-std()-Z
    49 |  fBodyAcc-meanFreq()-X
    50 |  fBodyAcc-meanFreq()-Y
    51 |  fBodyAcc-meanFreq()-Z
    52 |  fBodyAccJerk-mean()-X
    53 |  fBodyAccJerk-mean()-Y
    54 |  fBodyAccJerk-mean()-Z
    55 |  fBodyAccJerk-std()-X
    56 |  fBodyAccJerk-std()-Y
    57 |  fBodyAccJerk-std()-Z
    58 |  fBodyAccJerk-meanFreq()-X
    59 |  fBodyAccJerk-meanFreq()-Y
    60 |  fBodyAccJerk-meanFreq()-Z
    61 |  fBodyGyro-mean()-X
    62 |  fBodyGyro-mean()-Y
    63 |  fBodyGyro-mean()-Z
    64 |  fBodyGyro-std()-X
    65 |  fBodyGyro-std()-Y
    66 |  fBodyGyro-std()-Z
    67 |  fBodyGyro-meanFreq()-X
    68 |  fBodyGyro-meanFreq()-Y
    69 |  fBodyGyro-meanFreq()-Z
    70 |  fBodyAccMag-mean()
    71 |  fBodyAccMag-std()
    72 |  fBodyAccMag-meanFreq()
    73 |  fBodyBodyAccJerkMag-mean()
    74 |  fBodyBodyAccJerkMag-std()
    75 |  fBodyBodyAccJerkMag-meanFreq()
    76 |  fBodyBodyGyroMag-mean()
    77 |  fBodyBodyGyroMag-std()
    78 |  fBodyBodyGyroMag-meanFreq()
    79 |  fBodyBodyGyroJerkMag-mean()
    80 |  fBodyBodyGyroJerkMag-std()
    81 |  fBodyBodyGyroJerkMag-meanFreq()
    82 |  angle(tBodyAccMean,gravity)
    83 |  angle(tBodyAccJerkMean),gravityMean)
    84 |  angle(tBodyGyroMean,gravityMean)
    85 |  angle(tBodyGyroJerkMean,gravityMean)
    86 |  angle(X,gravityMean)
    87 |  angle(Y,gravityMean)
    88 |  angle(Z,gravityMean)

