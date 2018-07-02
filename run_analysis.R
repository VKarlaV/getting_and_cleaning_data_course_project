library(dplyr)

### Step 1: download file and unzip
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

if (!file.exists('UCI HAR Dataset.zip')) {
  download.file(url,'UCI HAR Dataset.zip')
}

if (!file.exists('UCI HAR Dataset')) {
  unzip('UCI HAR Dataset')
}

### Step 2: read data and combine data

## read test data (combine subject, act label, x_test)
df_sub1 <- read.table('UCI HAR Dataset/test/subject_test.txt',col.names = 'Subject')
df_act1 <- read.table('UCI HAR Dataset/test/y_test.txt',col.names = 'ActLabel')
df_set1 <- read.table('UCI HAR Dataset/test/X_test.txt')

## read train data (combine subject, act label, x_train)
df_sub2 <- read.table('UCI HAR Dataset/train/subject_train.txt',col.names = 'Subject')
df_act2 <- read.table('UCI HAR Dataset/train/y_train.txt',col.names = 'ActLabel')
df_set2 <- read.table('UCI HAR Dataset/train/X_train.txt')

## load features and change train/test value sets column names to features
fea <- read.table('UCI HAR Dataset/features.txt',colClasses = 'character')
fea <- fea[,2]

colnames(df_set1) <- fea
colnames(df_set2) <- fea

## combine test/train sets
df_t <- rbind(
  cbind(df_sub1,df_act1,df_set1),
  cbind(df_sub2,df_act2,df_set2)
)

### Step 3: filter only mean & std features(colnames)
df_t <- df_t[,!duplicated(colnames(df_t))]
df_t1 <- df_t %>% select(ActLabel,Subject,grep('mean|std',names(df_t)))

### Step 4: Use descriptive activities names
df_actlab <- read.table('UCI HAR Dataset/activity_labels.txt',colClasses = 'character')
#df_t1$ActLabel <- factor(x = df_actlab, levels = df_actlab[,1],labels = df_actlab[,2])
df_t1[,'ActLabel'] <- df_actlab[match(df_t1[,'ActLabel'], df_actlab[,1]),2]

### Step 5: Use descriptive column names
colnames(df_t1) <- gsub('-','', x = colnames(df_t1))
colnames(df_t1) <- gsub('[()]','', x = colnames(df_t1))
colnames(df_t1) <- gsub('mean','Mean', x = colnames(df_t1))
colnames(df_t1) <- gsub('std','Std', x = colnames(df_t1))

### Step 6: group by subject, activity, to calculate mean
new_tidy_data <- df_t1 %>% 
      group_by(Subject,ActLabel) %>% 
      summarise_all(funs(mean))

### Final step: export new tidy data set as txt
write.table(new_tidy_data, 'tidy_data.txt',row.names = FALSE,quote = FALSE)
