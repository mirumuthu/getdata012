library(sqldf)
library(dplyr)
library(stringr)
library(plyr)
library(data.table)
activity_desc <- read.table("./activity_labels.txt")
colnames(activity_desc) <- c("id", "activity")

##Column labels
col_labels <- read.table("./features.txt")

##select columns that has mean and std in them
neededCols <- sqldf("select * from col_labels where V2 like '%mean()__' or V2 like '%std()__' ")


##remove special characters
col_labels$V3 <- gsub("\\(|\\)","",gsub("-","_", col_labels$V2))

##read test data
x <- read.table("./test/X_test.txt")
colnames(x) <- col_labels$V3

y <-read.table("./test/y_test.txt") ## read the activity
colnames(y) <- "activity_id"
 
y <- merge(y, activity_desc, by.x = "activity_id", by.y="id")

subject <- read.table("./test/subject_test.txt") ## read the subjects 
colnames(subject) <- "subject"

cbind(subject, activity = y$activity) -> subject 

cbind(subject, x[,neededCols$V1]) ->  all_data

##train data

x <- read.table("./train/X_train.txt")

y <-read.table("./train/y_train.txt") ## read the activity
colnames(y) <- "activity_id"

y <- merge(y, activity_desc, by.x = "activity_id", by.y="id")

subject <- read.table("./train/subject_train.txt") ## read the subjects 
colnames(subject) <- "subject"

cbind(subject, activity = y$activity) -> subject ##combine activity and subject

colnames(x) <- col_labels$V3

##combine the train and test dataset after extracting the needed columns
cbind(subject, x[,neededCols$V1])%>% rbind(all_data) -> all_data 

colnames(all_data )[3:50] <- paste("avg_", colnames(all_data )[3:50], sep="") ##rename columns

 all_data <- data.table(all_data) ## convert to data.table for futher manipulations

all_data[, lapply(.SD, mean), by =list(subject, activity)] -> tidy  ##find column avg

#write the data out to tidy.txt
write.table(tidy,"./tidy.txt", row.names = F)
 