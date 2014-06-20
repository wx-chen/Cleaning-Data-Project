# run_analysis.R
## Cleaning data, project
## --------------------------------------------------------------
## |  before begin, put following 6 .txt files into one folder  |
## --------------------------------------------------------------
## subject_train.txt, X_train.txt, y_train.txt,
## subject_test.txt, X_test.txt, y_test.txt


### Get all the data & clean

# get feature name/number, activity name/number
features=read.table("features.txt")
names(features)=c("Var.Num","Var.Name")
act_label=read.table("activity_labels.txt")
names(act_label)=c("Act.Num","Act.Name")

# get subject id, convert into factor variable
sub_test=read.table("subject_test.txt")
sub_test$V1=as.factor(as.character(sub_test$V1))
names(sub_test)=c("id.f")

sub_train=read.table("subject_train.txt")
sub_train$V1=as.factor(as.character(sub_train$V1))
names(sub_train)=c("id.f")

# get activity label and convert into factor variable
y_test=read.table("y_test.txt")
y_test$V1=as.factor(as.character(y_test$V1))
names(y_test)=c("activity.f")

y_train=read.table("y_train.txt")
y_train$V1=as.factor(as.character(y_train$V1))
names(y_train)=c("activity.f")

x_test=read.table("X_test.txt")
x_train=read.table("X_train.txt")


## get feature columns corresponding to mean/std variables, clean names to remove "()"
features$StrVarName=as.character(features$Var.Name)
VarKeep = grepl("mean",features$StrVarName) | grepl("std",features$StrVarName)
dirtyname=features$StrVarName[VarKeep]
cleanname=gsub("\\(\\)","",dirtyname)
cleanname=gsub("\\-","",cleanname)

## get subset of x_train/test data with only mean/std data, change names to variable feature
temp_xtest=x_test[,VarKeep]
names(temp_xtest)=cleanname
temp_xtrain=x_train[,VarKeep]
names(temp_xtrain)=cleanname


## combine train/test data, with columns of mean/std data
traindata=cbind(sub_train, y_train, temp_xtrain)
testdata=cbind(sub_test, y_test, temp_xtest)

# label the activity type
levels(traindata$activity.f)=act_label$Act.Name
levels(testdata$activity.f)=act_label$Act.Name

# add group category and combine train/test data
traindata$Group=c("train")
traindata$Group=as.factor(traindata$Group)
testdata$Group=c("test")
testdata$Group=as.factor(testdata$Group)

Alldata=rbind(traindata,testdata)
colnum=dim(Alldata)[2]
Alldata=Alldata[,c(1:2,colnum,3:(colnum-1))]

## Calculate mean for each subject/activity/variable
datasplit=split(Alldata,list(Alldata$id.f,Alldata$activity.f,Alldata$Group))
splitmean=sapply(datasplit,function(x) colMeans(x[,4:colnum]))
row1=splitmean[1,]
splitmean=splitmean[,!is.na(row1)]  #remove nonexisting groups

splitmean=t(splitmean) #now rowname is "id.activity.group", colname is all the measurements, class is matrix


## tidy the data so that each row contains one combination of id/activity/group
splitmean=data.frame(splitmean) # convert matrix to data frame
splitmean$subject.id=c("0") # creaty empty subject/activity/group columns, to be filled in
splitmean$activity=c("0")
splitmean$Group=c("0")
colnum=dim(splitmean)[2]
splitmean=splitmean[,c((colnum-2):colnum,1:(colnum-3))] #put sub/act/group columns to front

groupcat=rownames(splitmean) # i.e. "1.WALKING.train"
for (i in 1:length(groupcat)){
        dotloc=c(0,0)
        name=strsplit(groupcat[i],"")
        dotloc=which(name[[1]]==".")
        splitmean$subject.id[i]=paste(name[[1]][1:(dotloc[1]-1)], sep="", collapse="")
        splitmean$activity[i]=paste(name[[1]][(dotloc[1]+1):(dotloc[2]-1)], sep="", collapse="")
        splitmean$Group[i]=paste(name[[1]][(dotloc[2]+1):length(name[[1]])], sep="", collapse="")
                
}
row.names(splitmean)=NULL

splitmean$subject.id=as.numeric(splitmean$subject.id) # now number
splitmean$activity=as.factor(splitmean$activity)      # now factor
splitmean$Group=as.factor(splitmean$Group)            # now factor


# sort according to subject id
splitmean=splitmean[order(splitmean$subject.id),]
row.names(splitmean)=NULL

write.table(splitmean, file="SamsungData.txt", sep=",", row.names=FALSE)

## read table
## samdata=read.table(file="SamsungData.txt", sep=",", header=TRUE)

