if (!"httr" %in% installed.packages()) install.packages("httr")
if (!"httpuv" %in% installed.packages()) install.packages("httpuv")
if (!"jsonlite" %in% installed.packages()) install.packages("jsonlite")

library(httr)
library(jsonlite)

oauth_endpoints("github")

app <- oauth_app("github", "27b85b1cadd7c6d4b18d")

github_token <- oauth2.0_token(oauth_endpoints("github"), app)

url <- "https://api.github.com/users/jtleek/repos"

req <- GET(url, config(token = github_token))
cnt <- content(req)
json <- jsonlite::fromJSON(toJSON(cnt))

# str(json)

result <- json[json$name == "datasharing", ]$created_at
