# Reading web data lecture notes

# Google scholar changed webpage generation
# line below errors -- try different site?
con = url("http:/scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# Can use XML packagwe to parse html
library(XML)
# url <- ..
# html 

# Anoter option -- Use GET from httr package
library(httr); html2 = GET(url)
content2 = content(html2,as="text") #extract content as text
parsedHtml = htmlParse(content2,asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

# Accessing website with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1  #won't work b/c authentication needed

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2  #this time it works!

names(pg2)

#Using handles (httr package) -- helps keep track of items like needed cookies
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle = google, path = "search")
