if (!file.exists("data.zip")) {
  download.file(
    url="https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2Fspecdata.zip",
    destfile="data.zip",
    method="curl"
  )  
}
if (!file.exists("data")) {
  dir.create("./data")  
  unzip(zipfile="data.zip", exdir="data")
}

list.files(path="data", recursive=T)

#move specdata in this root folder rather than in data