### This is the codebook for run_analysis.R

* First read the data frame that output from run_analysis.R into a variable names "samdata"
    * samdata=read.table(file="SamsungData.txt", sep=",", header=TRUE)

* samdata is a 180 x 82 data frame, with 30 (subjects) x 6 (activity) =180 rows

* The columns are:
    * column 1: subject.id, an integer denoting the subject ID number
    * column 2: activity,  a factor variable denoting the type of activity
    * column 3: Group, a factor variable denoting if the subject is grouped into "train" or "test"
    * column 4-82: mean value for reading of the 79 measurements, see below for details

* Column names 4-82 are kept from "features.txt"
    *  For example, column 4 is named "tBodyAccmeanX", which is coming from the first variable name (tBodyAcc-mean()-X) in "features.txt", after removing the "()" and "-"
    * "tBodyAccmeanX" is the mean value for body acceleration measured in X axis, a time-domain signal (prefix "t")
    * For more details regarding nomenclature and preprocessing of the data, see "features_info.txt"
