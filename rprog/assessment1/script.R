setwd("/home/noootsab/src/noootsab/data-scientist/rprog/assessment1")

makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}


cachemean <- function(x, ...) {
  m <- x$getmean()
  if(is.null(m)) {
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
  } else {
    message("getting cached data")
  }
  m
}

setwd("/home/noootsab/src/noootsab/data-scientist/rprog/ProgrammingAssignment2/")

