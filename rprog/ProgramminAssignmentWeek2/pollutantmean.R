find.files <- function(directory, id = 1:332) {
  files <- list.files(path=directory)
  filtered.full <- sapply(
    files, 
    function(x) if (as.numeric(substr(x, 1, nchar(x)-nchar(".csv"))) %in% id) x else NA,
    USE.NAMES=F
  )
  filtered <- filtered.full[!is.na(filtered.full)]
  filtered
}

read.files <- function(directory, files) {
  read.list <- lapply(paste(directory, files, sep="/"), read.csv)
  read.list
}

read.files.append <- function(directory, files) {
  read.list <- read.files(directory, files)
  flatten <- do.call("rbind", read.list)
  flatten
}

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  filtered <- find.files(directory, id)
  all.data <- read.files.append(directory, filtered)

  all.polluant <- all.data[pollutant]
  
  all.polluant.complete <- all.polluant[!is.na(all.polluant)]
  
  all.polluant.mean <- mean(all.polluant.complete)
  
  all.polluant.mean
}