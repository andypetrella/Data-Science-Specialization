#### helpers
dl.and <- function(file, url, f, on.file=F) {
  if (!file.exists(file)) {
    download.file(url=url, destfile=file, method="curl")
  }
  con <- file(file, "r")
  result <- if (!on.file) {
    f(con)
  } else {
    f(file)
  }
  close(con)
  result
}

##############
data <- dl.and("/tmp/microdata-2006.csv", 
   "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
   function(con) {
     read.csv(con)
   })

agricultureLogical <- data$ACR >= 2 & data$AGS == 6

print(head(which(agricultureLogical), n=3))

##### -------------
if (!"jpeg" %in% installed.packages()) install.packages("jpeg")
library(jpeg)
img <- dl.and("/tmp/getdata.jpg", 
       "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg",
       function(file) {
         readJPEG(file, native=T)
       },
       on.file=T)

quantile(img, probs = c(0.3, 0.8), na.rm=F)

##### -------------
fgdp <- dl.and("/tmp/FGDP.csv", 
       "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv",
       function(con) {
         v <- read.csv(con, skip = 5, nrows=190, header=F, stringsAsFactors=F)
         v <- v[!is.na(v[, "V1"]) & nchar(v[, "V1"]) > 0, ]
         v$V5 <- as.numeric(gsub(",","", v[, "V5"]))
         v
       })

stats <- dl.and("/tmp/DefStats.csv", 
       "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv",
       function(con) {
         read.csv(con, stringsAsFactors=F)
       })

merged <- merge(stats,fgdp, by.y=c("V1"), by.x=c("CountryCode"))

merged.ordered <- merged[order(merged$V5, decreasing=T), ]

merged.ordered$Rank <- seq(1, nrow(merged.ordered))
mean(md[md$Income.Group == "High income: OECD", ]$Rank, na.rm=T)
mean(md[md$Income.Group == "High income: nonOECD", ]$Rank, na.rm=T)

gdpQuantiles <- quantile(merged.ordered$V5, probs=seq(0,1, length.out=6))

cut.data <- cut(merged.ordered$V5, 
    gdpQuantiles, 
    labels=c("0-20","20-40","40-60","60-80","80-100"), 
    include.lowest=TRUE)

merged.ordered$Quantiles <- cut.data

compare <- table(merged.ordered$Income.Group, merged.ordered$Quantiles)
print(compare["Lower middle income" , "80-100"])

