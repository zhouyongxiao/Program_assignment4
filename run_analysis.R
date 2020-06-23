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
datalab<-rbind(trainlab,testsub)

#read feature.txt
setwd("D:/Users/Yongxiao/datasciencecoursera/ProgrammingAssignment4/UCI HAR Dataset")
feature<-read.table("features.txt")

#add column name
colnames(data)<-feature[,2]
sublocation<-grep("mean|std",feature$V2)