run_analysis <-  function()
{
    library(reshape2)
   
    #--------------- Activity Labels File ---------------
    # Get activity label categories (requirement 3 in the assignment)
    df_activities <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
    df_activities[,2]<- as.character(df_activities[,2])
    
    #--------------- Features File ---------------
    # Get features
    df_features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
    df_features[,2] <- as.character(df_features[,2])
    
    # Since we only want features, use regex to grab features related to std deviation and mean and clean up the labels
    # Requirement 2 from the assignment)
    featureSubset <- grep(".*mean.*|.*std.*", df_features[,2])
    featureNames <- df_features[featureSubset,2]
    featureNames <- gsub('-std', 'Std', featureNames)
    featureNames <- gsub('-mean', 'Mean', featureNames)
    featureNames <- gsub('[-()]','',featureNames)
    head(featureNames)
    
    #------------- Rather than grabbing all data, just grab which data we want -------------
    #--------------- Training Dataset Files ---------------
    # Get the data files
    df_XTrain <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")[featureSubset]
    df_YTrain <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
    df_SubjectTrain <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
    
    # Combine the data sets with the subjects (requirement 1 from assignment)
    trainCombined <- cbind(df_SubjectTrain, df_YTrain, df_XTrain)
    
    #--------------- Test Dataset Files ---------------
    # Get the data files
    df_XTest <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")[featureSubset]
    df_YTest <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
    df_SubjectTest <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

    # -------------- Combine and Merge the two data sets ------------
    # Combine the data sets with the subjects
    testCombined <- cbind(df_SubjectTest, df_YTest,df_XTest)
    combined <- rbind(trainCombined,testCombined)
    # rename the columns to be more friendly (assignment requirement 4)
    colnames(combined) <- c("Subject", "Activity", featureNames)
    
    combined$Subject <- factor(combined$Subject)
    combined$Activity <- factor(combined$Activity, levels = df_activities[,1], labels = df_activities[,2])
    
    datamelt_combined <- melt(combined, id = c("Subject", "Activity"))
    datamelt_mean <- dcast(datamelt_combined, Subject + Activity ~ variable, mean)
    
    write.table(datamelt_mean, "tidy.txt", row.name = FALSE)
    View(datamelt_mean)
}