if (!"sqldf" %in% installed.packages()) install.packages("sqldf")

library(sqldf)

data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"

data.file <- "./data.csv"

if (!file.exists(data.file)) download.file(url=data.url, destfile=data.file, method="curl")

acs <- read.csv(data.file)

# print(head(acs))

result2 <- "select pwgtp1 from acs where AGEP < 50"

