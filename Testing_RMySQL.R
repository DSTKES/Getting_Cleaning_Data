# Testing RMySQL (from lecture notes)
library(RMySQL)

#this might be blocked by firewall or vpn -- if the vpn if off it seems to work
ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.soe.ucsc.edu")  

Result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

Result[1:10,]


# Connect to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                  host="genome-mysql.soe.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]
