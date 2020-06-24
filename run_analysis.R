#run_analysis
# extract training data and labels
setwd("D:/Users/Yongxiao/datasciencecoursera/ProgrammingAssignment4/UCI HAR Dataset/train")
train<-read.table("X_train.txt",sep = "")
trainsub<-read.table("subject_train.txt")
trainlab<-read.table("y_train.txt")

# extract test data and labels
setwd("D:/Users/Yongxiao/datasciencecoursera/ProgrammingAssignment4/UCI HAR Dataset/test")
test<-read.table("X_test.txt",sep = "")
testsub<-read.table("subject_test.txt")
testlab<-read.table("y_test.txt")

# merge train and test data together
data<-rbind(train,test)
datasub<-rbind(trainsub,testsub)
datalab<-rbind(trainlab,testlab)

#read feature name
setwd("D:/Users/Yongxiao/datasciencecoursera/ProgrammingAssignment4/UCI HAR Dataset")
feature<-read.table("features.txt")

#add column name
colnames(data)<-feature[,2]

#read activity name
activity<-read.table("activity_labels.txt")

#add descriptive activity name to label
datalab<-gsub("1",activity[1,2],datalab)
datalab<-gsub("2",activity[2,2],datalab)
datalab<-gsub("3",activity[3,2],datalab)
datalab<-gsub("4",activity[4,2],datalab)
datalab<-gsub("5",activity[5,2],datalab)
datalab<-gsub("6",activity[6,2],datalab)
datalab_new<-unlist(strsplit(datalab,","))
datalab_new[1]<-" STANDING"
datalab_new[10299]<-" WALKING_UPSTAIRS"


# add descriptive activity name to data
data<-cbind(datalab_new,data)

# subset only mean and std value and the activity label
sublocation<-grep("[mM]ean|[sS]td",feature$V2)
subdata<-data[,c(1,sublocation+1)]

# average by subject, add subject information to data
subdata<-cbind(datasub,subdata)
datalab<-rbind(trainlab,testlab)
subdata<-cbind(datalab,subdata)


#remove descriptive activity name and calculate mean
subdata_t <-subdata[,-3]
new_data<-subdata_t[1,]
for (i in 1:30) {
        for (j in 1:6) {
                new_data<-rbind(new_data,colMeans(subdata_t[(subdata_t[,2]==i) & (subdata_t[,1]==j),]))
        }
        
}
new_data<-new_data[-1,]
colnames(new_data)[1]<-"activity"
colnames(new_data)[2]<-"subject"

#add descriptive activity name to label
new_data$activity<-gsub("1",activity[1,2],new_data$activity)
new_data$activity<-gsub("2",activity[2,2],new_data$activity)
new_data$activity<-gsub("3",activity[3,2],new_data$activity)
new_data$activity<-gsub("4",activity[4,2],new_data$activity)
new_data$activity<-gsub("5",activity[5,2],new_data$activity)
new_data$activity<-gsub("6",activity[6,2],new_data$activity)
