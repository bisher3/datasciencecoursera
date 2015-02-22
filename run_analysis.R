# Coursera "Getting and Cleaning Data" project
# submitted by Bisher Tarakji
#
# Working directory should be inside the Samsung data folder 
# meaning the folder that has two folders "train" and "test"
#
#
# dplyr library is required for final step
require(dplyr)

# read in the data files
x_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")
subj_train<-read.table("train/subject_train.txt")
x_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
subj_test<-read.table("test/subject_test.txt")

#read in the features names
feature_names<-read.table("features.txt")
feature_names<-feature_names$V2

#add the feature names to the x_train and x_test tables
colnames(x_train)<-feature_names
colnames(x_test)<-feature_names

#name the colums in y_train and y_test "activity"
colnames(y_train)<-c("activity")
colnames(y_test)<-c("activity")

#name the colums in subj_test and subj_train "subject"
colnames(subj_test)<-c("subject")
colnames(subj_train)<-c("subject")

#bind the training data together as columns, activity and subject first
x_train<-cbind(y_train,subj_train,x_train)
#bind the testing data together as columns,  activity and subject first
x_test<-cbind(y_test,subj_test,x_test)

# bind entire data together as rows 
fulldata<-rbind(x_train,x_test)
# delete all the intermediate objects (everything but fulldata)
rm(list=setdiff(ls(), "fulldata"))

#read in the activity labels from the file
activity_labels<-read.table("activity_labels.txt")
#convert the activity column in fulldata to factor
fulldata$activity<-as.factor(fulldata$activity)

#set the levels of the activity column to the values from the activity_labels
levels(fulldata$activity)<-activity_labels$V2

#find all columns that contain "mean" or "std" by using the grep
#function and the correct regular expression and using case sensitive search
#add to it the first and second columns that are the "activity" and "subject"
#columns and subset the data using those columns only.
fulldata<-fulldata[,c(1,2,grep("mean|std",colnames(fulldata),ignore.case=F))]

#use dplyr piping function to group by activity and subject and summarise 
# using the means function
mean_set<-fulldata %>% group_by(activity,subject) %>% summarise_each(funs(mean))
write.table(mean_set,row.name=FALSE,file = "tidydata.txt")
#output the file