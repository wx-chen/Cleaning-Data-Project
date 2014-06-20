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

* the final tidy data frame is in a wide format, with dimentions 180x82
    * first three columns are "subject.id","activity","Group"
    * the rest 79 columns contain mean value for the 79 variables associated with mean/std measurements
* if one needs a "strict" tidy data frame (long form), with each row only contains value for one variable (e.g. "tBodyAccmeanX" reading for subject 1, walking data), one can use the following codes:

    samdata <- read.table(file="SamsungData.txt", sep=",", header=TRUE)
    
    library(reshape2)
    
    mdata=melt(samdata, id=c("subject.id","activity","Group"), measure.vars=c("tBodyAccmeanX"))
    
    as "melting" the data will result in a (180*79) x 5 matrix, which is crazily long, I choose to keep the wide data format
