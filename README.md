Cleaning-Data-Project
=====================

for Coursera- Getting and cleaning data project submission


* first download the data file (.zip) and unzip

* put all useful .txt files into one folder, containing:

    * subject_train.txt
    * X_train.txt
    * y_train.txt
    * subject_test.txt
    * X_train.txt
    * y_train.txt

* put "run_analysis.R" file into the same folder

* run the code

* output will be a tidy data file "SamsungData.txt"
   which can be read into a data frame using 


   samdata <- read.table(file="SamsungData.txt", sep=",", header=TRUE)

