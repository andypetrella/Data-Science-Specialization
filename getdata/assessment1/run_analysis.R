print("This is the source for the Peer Assessment of the Coursera course
Getting and Cleaning Data, cf https://class.coursera.org/getdata-002/human_grading")

## Some tools ##

get.or.compute <- function(var.name, compute, env = parent.frame()) {
  value <- mget(var.name, env, ifnotfound=list(NULL))[[var.name]]
  if (is.null(value)) {
    print(paste(c("Computing ", var.name), sep=""))
    value <- eval(compute, envir=env)
    assign(var.name, value, envir = env)    
  } else {
    print(paste(c("Using memoized value of ", var.name), sep=""))
    value
  }
}

rm.rf <- function(env = parent.frame()) {
  # This function helps in removing all variables in the current env
  # This is particularly helpful because we're memoizing results of intensive
  # computations like reading the data files in R objects
  rm(list=ls(env), envir=env)
}

read.das.crap <- function(file) {
  # This function aims to read the data files (the collected measures).
  # Since this text files have leading white chars and may have one or more 
  # blank chars separating the values, it's rather hard to use classical
  # read.* functions
  lines <- readLines(file)
  closeAllConnections() 
  
  cleaned.lines <- gsub("^ +", "", lines)
  
  splitted <- strsplit(cleaned.lines, " ( )*", perl=T)
  
  as.num.splitted <- lapply(splitted, as.numeric)
  
  data <- as.data.frame(do.call("rbind", as.num.splitted))
  
  data
}
################


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


print("Work")
print("Read features")
features.name <- read.delim("./data/expanded/UCI\ HAR\ Dataset/features.txt", sep=" ", header=F, stringsAsFactors=F)[[2]]

get.or.compute("data.train",  {
  value <- read.das.crap("./data/expanded/UCI\ HAR\ Dataset/train/X_train.txt")
  names(value) <- features.name
  value
})
get.or.compute("data.test",  {
  value <- read.das.crap("./data/expanded/UCI\ HAR\ Dataset/test/X_test.txt")
  names(value) <- features.name
  value
})

get.or.compute("data.full",  {
  rbind(data.train, data.test)
})


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

get.or.compute("data.mean.std", {
  keep.them(data.full, c("mean", "std"))
})

print("The result of #2 is `data.mean.std`")


print("Read the activity labels")
activity.labels <- read.delim("./data/expanded/UCI HAR Dataset/activity_labels.txt", sep=" ", header=F)

print("Read the assigned labels")
get.or.compute("train.label",  {
  read.delim("./data/expanded/UCI\ HAR\ Dataset/train/y_train.txt", sep=" ", header=F)
})
get.or.compute("test.label",  {
  read.delim("./data/expanded/UCI\ HAR\ Dataset/test/y_test.txt", sep=" ", header=F)
})
get.or.compute("full.label",  {
  rbind(train.label, test.label)
})
get.or.compute("full.activity",  {
  merge(full.label, activity.labels, by.x="V1", by.y="V1")$V2
})

print("The result of #3 is `full.activity`")


get.or.compute("labeled.data",  {
  cbind(data.full, activity=full.activity)
})

print("The result of #4 is `labeled.data`")


get.or.compute("train.pop",  {
  read.delim("./data/expanded/UCI\ HAR\ Dataset/train/subject_train.txt", sep="", header=F)
})
get.or.compute("test.pop",  {
  read.delim("./data/expanded/UCI\ HAR\ Dataset/test/subject_test.txt", sep="", header=F)
})
get.or.compute("full.pop",  {
  value <- rbind(train.pop, test.pop)
  names(value) <- c("pop")
  value
})
get.or.compute("personified.data",  {
  cbind(labeled.data, full.pop)
})


# split the whole thing by activity
get.or.compute("per.activity",  {
  split(personified.data, personified.data$activity)
})
# then, for each resulting data, take the mean of all variable per subject
get.or.compute("mean.per.pop.per.activity",  {
  library(plyr)
  agg <- function(name, d) {
    if (name == "pop" | name == "activity") {
      # even if mean(pop)==pop and mean(activity)==activity in this case...
      d
    } else {
      mean(d[!is.na(d)])      
    }
  }
  df <- function(df) { 
    as.data.frame(mapply(agg, names(df), df)) 
  }
  DF <- function(DF) {
    ddply(DF, .(pop),  df)
  }
  R <- lapply(per.activity, DF)
  R
})

if (!file.exists("./data/output")) {
  dir.create("./data/output")
}
write.df <- function(name, df) {
  write.csv(df, 
            file=paste("./data/output/", name, ".csv", sep=""),
            row.names=F
  )
}
mapply(write.df, names(mean.per.pop.per.activity), mean.per.pop.per.activity)