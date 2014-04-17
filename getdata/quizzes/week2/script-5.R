data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

data.file <- "./data-5.for"

if (!file.exists(data.file)) download.file(url=data.url, destfile=data.file, method="curl")

data <- read.fwf(file=data.file, skip=4,widths=c(12, 7,4, 9,4, 9,4, 9,4))

result5 <- sum(data[, 4])
