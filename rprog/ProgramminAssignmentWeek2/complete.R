find.files <- function(directory, id = 1:332) {
  files <- as.vector(list.files(path=directory))
  files.as.num <- sapply(files, function(x) as.numeric(substr(x, 1, nchar(x)-nchar(".csv"))))

  f <- data.frame(id = files.as.num, file = files, stringsAsFactors=F)
  
  sapply(id, function(i) {
    if (i %in% f$id) 
      f[f$id == i, ]$file 
    else 
      NA
  })
}

read.files <- function(directory, files) {
  read.list <- lapply(paste(directory, files, sep="/"), read.csv)
  read.list
}

complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  all.read <- read.files(directory, find.files(directory, id))
  data.frame(id = id, nobs = sapply(all.read, function(dataset) sum(complete.cases(dataset))))
}