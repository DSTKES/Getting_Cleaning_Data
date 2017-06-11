# test case from lecture
library(XML)
simplUrl <- "https://www.w3schools.com/xml/simple.xml"
download.file(simplUrl, destfile = bk <- tempfile(fileext = ".xml"))
mnu <- xmlParse(bk)
fd_nm <- xpathSApply(mnu, "//food/name", xmlValue)  #Will //name capture what I need?
