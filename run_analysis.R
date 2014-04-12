# Read X data from text files

X_test <- read.table("~/UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("~/UCI HAR Dataset/train/X_train.txt", quote="\"")

# save names to avoid typing _ everytime

xtest <- X_test
xtrain <- X_train

# features is the list of column headers
features <- read.table("~/UCI HAR Dataset/features.txt", quote="\"", colClasses = "character")

# converting features to character format
features[, 2] <- as.character(features[, 2])

# naming columns in the imported x data files
colnames(xtest) <- features[, 2]
colnames(xtrain) <- features[, 2]

# Filtering relevant columns for further use
relxtest <- xtest[1:6]
relxtrain <- xtrain[1:6]

# Creating one table of relevant data 
mergedrelxdata <- rbind(relxtest, relxtrain)

# read numbers for activities
y_train <- read.table("~/UCI HAR Dataset/train/y_train.txt", quote="\"")
y_test <- read.table("~/UCI HAR Dataset/test/y_test.txt", quote="\"")

#merge activities into one column
mergedydata <- rbind(y_test, y_train)

# merge activities column in to existing table
mergedrelxdata <- cbind(mergedrelxdata, mergedydata)

# create column that will contain translation of activity numbers
translatedydata <- as.character(mergedydata)

# Convert activity numbers into translation.
for(i in 1: length(mergedrelxdata$V1)) { 
   if( mergedrelxdata$V1[i] == 1 ) translatedydata[i] = "Walking"
   if(mergedrelxdata$V1[i] == 2) translatedydata[i] = "Walking Upstairs"
   if(mergedrelxdata$V1[i] == 3) translatedydata[i] = "Walking Downstairs"
   if(mergedrelxdata$V1[i] == 4) translatedydata[i] = "Sitting"
   if(mergedrelxdata$V1[i] == 5) translatedydata[i] = "Standing"
   if(mergedrelxdata$V1[i] == 6) translatedydata[i] = "Laying"
   }

# merge translated activities into existing table
mergedrelxdata <- cbind(mergedrelxdata, translatedydata)

#check existing table
head(mergedrelxdata)

# Revising headers
revisedheader <- c("Mean Body Acc. X", "Mean Body Acc. Y", "Mean Body Acc. Z",
                   "SD Body Acc. X", "SD Body Acc. Y", "SD Body Acc. Z",
                   "Activity Code", "Activity")
# Apply revised headers to existing table

colnames(mergedrelxdata) <- revisedheader

# Split existing table into 6 tables for separate activities
act1 <- mergedrelxdata[mergedrelxdata$Activity == "Walking", ]
act2 <- mergedrelxdata[mergedrelxdata$Activity == "Walking Upstairs", ]
act3 <- mergedrelxdata[mergedrelxdata$Activity == "Walking Downstairs", ]
act4 <- mergedrelxdata[mergedrelxdata$Activity == "Sitting", ]
act5 <- mergedrelxdata[mergedrelxdata$Activity == "Standing", ]
act6 <- mergedrelxdata[mergedrelxdata$Activity == "Laying", ]


# Remove extra two columns

act1 <- act1[1:6]
act2 <- act2[1:6]
act3 <- act3[1:6]
act4 <- act4[1:6]
act5 <- act5[1:6]
act6 <- act6[1:6]

# Calculate mean for each activity


act1sum <- NULL
act2sum <- NULL
act3sum <- NULL
act4sum <- NULL
act5sum <- NULL
act6sum <- NULL

for (i in 1:6){
  act1sum[i] = mean(act1[, i])
  act2sum[i] = mean(act2[, i])
  act3sum[i] = mean(act3[, i])
  act4sum[i] = mean(act4[, i])
  act5sum[i] = mean(act5[, i])
  act6sum[i] = mean(act6[, i])


}

# Combine mean values into one table
result <- cbind(act1sum, act2sum, act3sum, act4sum, act5sum, act6sum)

# Add column names
colnames(result)<- c("Walking","Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")

# Add row names
rownames <- c("Mean Body Acc X", "Mean Body Acc Y", "Mean Body Acc Z", "SD Body Acc X", "SD Body Acc Y", "SD Body Acc Z")
result <- cbind(rownames, result)


# Save data set to a txt file
# The file named Result.txt is saved in the home directory
write.csv(file="~/Result.txt", x = result)



