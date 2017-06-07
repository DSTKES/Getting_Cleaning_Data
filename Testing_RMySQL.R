# Testing RMySQL (from lecture notes)
library(RMySQL)
ucscDB <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.soe.ucsc.edu")  #this might be blocked by firewall or vpn