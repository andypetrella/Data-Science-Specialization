source(file = "./complete.R")

corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  files <- complete(directory)
  files.filtered <- subset(files, files$nobs > threshold)
  
  if (length(files.filtered$id) == 0) {
    numeric()
  } else {
    valid.data <- read.files(directory, find.files(directory, files.filtered$id))
    valid.data.complete <- lapply(valid.data, function(d) d[complete.cases(d), ])
    sapply(valid.data.complete, function(d) cor(d$nitrate, d$sulfate))    
  }
}