source("./script-2.R")

result3 <- identical(sqldf("select distinct AGEP from acs")$AGEP, unique(acs$AGEP))

