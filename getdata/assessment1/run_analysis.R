print("This is the source for the Peer Assessment of the Coursera course
Getting and Cleaning Data, cf https://class.coursera.org/getdata-002/human_grading")

data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
print(paste("Data source will be", data.url, sep=" "))

if (!file.exists("./data/data.zip")) {
  print("`data` dir not existing => creating it")
  dir.create("./data")
  
  print("`data` dir not existing => downloading the data zip in this `data` folder")
  download.file(url = data.url, destfile="./data/data.zip", method="curl")
  
  print("Unzip the data zip file into the `data/expanded` folder")
  unzip(zipfile="./data/data.zip", exdir="./data/expanded")
}

print(" > Files in expanded")
for (file in list.files("./data/expanded/UCI\ HAR\ Dataset")) print(file)
print(" > Files in data root")
for (file in list.files("./data/expanded/UCI\ HAR\ Dataset")) print(file)
print(" > Files in data Train")
for (file in list.files("./data/expanded/UCI\ HAR\ Dataset/train")) print(file)
print(" > Files in data Test")
for (file in list.files("./data/expanded/UCI\ HAR\ Dataset/test")) print(file)

rm.rf <- function() {
  # This function helps in removing all variables in the current env
  # This is particularly helpful because we're memoizing results of intensive
  # computations like reading the data files in R objects
  print(ls())
  rm(list=ls())
}

print("Work")
print("Read features")
features.name <- read.delim("./data/expanded/UCI\ HAR\ Dataset/features.txt", sep=" ", header=F, stringsAsFactors=F)[[2]]

read.das.crap <- function(file) {
  # This function aims to read the data files (the collected measures).
  # Since this text files have leading white chars and may have one or more 
  # blank chars separating the values, it's rather hard to use classical
  # read.* functions
  lines <- readLines(file)
  closeAllConnections() 
  
  cleaned.lines <- gsub("^ +", "", lines)
  
  splitted <- strsplit(cleaned.lines, " ( )*", perl=T)
  
  data <- as.data.frame(do.call("rbind", splitted))
  names(data) <- features.name
  
  data
}

if (!"data.train" %in% ls()) {
  print("Read train data")
  data.train <- read.das.crap("./data/expanded/UCI\ HAR\ Dataset/train/X_train.txt")
} else {
  warning("Train data not read, `data.train` is already present")
}
if (!"data.test" %in% ls()) {
  print("Read test data")
  data.test <- read.das.crap("./data/expanded/UCI\ HAR\ Dataset/test/X_test.txt")
} else {
  warning("Test data not read, `data.test` is already present")
}

if (!"data.full" %in% ls()) {
  print("Binding the two sets into a single one: `data.full`")
  data.full <- rbind(data.train, data.test)
} else {
  warning("Full data not read, `data.full` is already present")
}

print("The result of #1 is `data.full`")

keep.them <- function(data, us) {
  # This function return a version of `data` which
  # has been stripped out of the column that aren't 
  # matching the measurement to be kept.
  
  # data is the data frame that will be filtered using its column names
  
  # The `us` is the vector holding the measurements to be kept,
  # it'll be used to construct simple regexp to be matched against
  # the names of the data.full dataset.
  
  exp <- paste(us, "\\(\\)", sep="", collapse="|")
  cols.kept <- which(grepl(exp, features.name))
  data[, cols.kept]
}

if (!"data.mean.std" %in% ls()) {
  print("Stripping `data.full`, keeping only mean and std of the measurements")
  data.mean.std <- keep.them(data.full, c("mean", "std"))
} else {
  warning("Full data not stripped, `data.mean.std` is already present")
}

print("The result of #2 is `data.mean.std`")