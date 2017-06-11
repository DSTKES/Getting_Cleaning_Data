# Testing RMySQL (from lecture notes)
library(RMySQL)

#this might be blocked by firewall or vpn -- if the vpn if off it seems to work
ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.soe.ucsc.edu")  

Result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)

Result[1:10,]  #show the first 10 listings -- includes object class?


# Connect to hg19 and listing tables
hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                  host="genome-mysql.soe.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

# create query
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)
affyMisSmall <- fetch(query, n=10); dbClearResult(query);
dim(affyMisSmall)
dbDisconnect(hg19)
