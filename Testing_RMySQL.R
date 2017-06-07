# Testing RMySQL (from lecture notes)
library(RMySQL)

#this might be blocked by firewall or vpn -- if the vpn if off it seems to work
ucscDb <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.soe.ucsc.edu")  

Result <- dbGetQuery(ucscDb, "show databases;"); dbDisconnect(ucscDb)
