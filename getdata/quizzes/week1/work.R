download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", method="curl")
download.file(file="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", method="curl")
download.file(destfile="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", method="curl")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", method="curl")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile="housing_idaho_2006.csv", method="curl")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf", destfile="housing_idaho_2006-cookbook.pdf", method="curl")
?readLines
?open.connection
file_conn <- file("housing_idaho_2006.csv")
readLines(file_conn, n = 4)
data <- read.csv(file="housing_idaho_2006.csv", comment.char="")
head(data)
pdf("housing_idaho_2006-cookbook.pdf")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf", destfile="housing_idaho_2006-cookbook.pdf", method="curl")
class(data)
head(data[["VAL"]])
head(data[["VAL"]] > 14) 
with.val <- data[!is.na(data$VAL)]
head(!is.na(data$VAL))
with.val <- data[which(!is.na(data$VAL))]
with.val <- subset(data, !is.na(data$VAL))
head(with.val$VAL)
length(is.na(with.val$VAL))
with.val$VAL
is.na(with.val$VAL)
sum(is.na(with.val$VAL))
more.than.1M <- sum(with.val$VAL >= 14)
more.than.1M
 sum(with.val$VAL > 14)
 sum(with.val$VAL >= 24)
more.than.1M <- sum(with.val$VAL >= 24)
more.than.1M
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile="NGAP.xlsx")
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", destfile="NGAP.xlsx", method="curl")
install.packages("xlsx")
library("xlsx")
library(xlsx)
install.packages("xlsx")
install.packages("xlsxjars")
install.packages("xlsxjars", contrib.url="")
install.packages("xlsxjars", contriburl="")
install.packages("xlsxjars", repos="")
options(”repos”=c(CRAN=”@CRAN@”))
options("repos"=c(CRAN="@CRAN@"))
install.packages("xlsx")
data <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=T)
library(xlsx)
data <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=T)
head(data)
?subset.data.frame
subset(data, subset=c(18,23), select=c(7,15))
subset(data, subset=18:23, select=c(7,15))
subset(data, subset=data[18:23, ], select=c(7,15))
subset(data, subset=data[[18:23, ]], select=c(7,15))
subset(data, subset=data[[18:23 ]], select=c(7,15))
subset(data, subset=data[18:23], select=c(7,15))
s <- subset(data,  select=c(7,15))
head(s)
s <- subset(data,  select=7:15)
head(s)
library(data.table)
install.packages("table")
install.packages("data.table")
data <- data.table (data)
library(data.table)
data <- data.table (data)
data[18:23, ]
data[18:23, 7:15][B
data[18:23, 7:15]
data[, 7:15]
data[, 7:30]
data[18:23, 7:15, with=F]
?table.table
?data.table
data <- data[18:23, 7:15, with=F]
data <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=T)
table <- data.table (data)
dat <- table[18:23, 7:15, with=F]
sum(dat$Zip*dat$Ext,na.rm=T) 
xml <- download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", destfile="resto.xml", method="curl")
read.("resto.xml")
library(xml)
library(XML)
install.packages(XML)
install.packages("XML")
library(XML)
library(xml)
install.packages("XML")
library(xml)
library(XML)
  system("which xml2-config", intern = TRUE) 
install.packages("XML")
install.packages("xml2-config")
install.packages("XML")
library(XML)
xml <- xmlTreeParse("resto.xml")
xml
xml <- xmlTreeParse("resto.xml", useInternalNodes=T)
rootXml <- xmlRoot(xml)
names(rootXml)
]]
rootXml[[1]][[1]]
rootXml$row$zipcode
rootXml$row
xpathSApply(rootXml, "/row/zipcode", xmlvalue)
xpathSApply(rootXml, "/row/zipcode", xmlValue)
xpathSApply(rootXml, "//row/zipcode", xmlValue)
xpathSApply(rootXml, "//row/zipcode", xmlValue)
xmlName(rootXml)
sum(xpathSApply(rootXml, "//row/zipcode", xmlValue) == "21231")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "US-communities.csv", method="curl")
?fread
fread(input="communities.csv")
fread(input="US-communities.csv")
DT <- fread(input="US-communities.csv")
time(sapply(split(DT$pwgtp15,DT$SEX),mean))
time(1+1)
?time
timetaken(1+1)
syste.time(1+1)
system.time(1+1)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time({sapply(split(DT$pwgtp15,DT$SEX),mean)})
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time({DT[,mean(pwgtp15),by=SEX]})
system.time({tapply(DT$pwgtp15,DT$SEX,mean)})
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time({mean(DT$pwgtp15,by=DT$SEX)})
DT$pwgtp15,by=DT$SEX)
DT$pwgtp15,by=DT$SEX
mean(DT$pwgtp15,by=DT$SEX)
?mean
mean(DT$pwgtp15)
sapply(split(DT$pwgtp15,DT$SEX),mean)
dat
dat <- table[18:23, 7:15, with=F]
table
data <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=F)
dat <- table[18:23, 7:15, with=F]
dat
sum(dat$Zip*dat$Ext,na.rm=T) 
table <- data.table (data)
dat <- table[18:23, 7:15, with=F]
dat
sum(dat$Zip*dat$Ext,na.rm=T) 
dat
dat
dat$Zip
?data.table
head(data)
?read.xlsx
data <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=T, rowIndex=18:23, colIndex=7:15)
data
dat <- read.xlsx("NGAP.xlsx", sheetIndex=1, header=T, rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T) 
save()
save
?save
?
;
?workspace
??workspace
??save
utils::savehistory
utils::savehistory("work.R")
