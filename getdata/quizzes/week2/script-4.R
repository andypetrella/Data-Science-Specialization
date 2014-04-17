page.url <- "http://biostat.jhsph.edu/~jleek/contact.html"

con <- url(page.url)

cnt <- readLines(con)
close(con)

result4 <- sapply(cnt[c(10, 20, 30, 100)], nchar, USE.NAMES=F)


