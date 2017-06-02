# ==First Attempt couldn't finish since R needed updating in order to run
# ==needed packages [5/30/2017]


# Started this witout data.table b/c I was updating R version at the time
  # data.table wouldn't run on the version I had installed

# download ACS data

library(xlsx)
library(XML)
library(data.table)  #Documentation states dependent on R >=3.0.0, package says 3.2.5
library(rbenchmark)

setwd("C:/Users/D636578/Coursera/Getting_Cleaning_Data/code")

#Q1 Count number of properties with value over $1,000,000
filenm <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(filenm, destfile = "ss06hid.csv")
acs <- read.csv("ss06hid.csv", sep=",")
DateDownload <- date()
#Line for calculation
table(acs$VAL==24)

#Q2 tidy data question

#Q3 Download Excel Data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "gov_NGAP.xlsx", method = "curl")
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx("gov_NGAP.xlsx", sheetIndex=1, rowIndex=rowIndex, colIndex=colIndex)
head(dat)
sum(dat$Zip*dat$Ext,na.rm=T)

# Read in XML data for Baltimore restuarants and count 21231 zip codes
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"  #https issue

# had to use download to get around https -- maybe certificate issue?
download.file(fileUrl, destfile = tmp <- tempfile(fileext = ".xml"))
doc <- xmlTreeParse(tmp)

zips <- xpathSApply(rootNode, "/response/row/row/zipcode", xmlValue)
sum(zips=="21231")


#Q5 Download ACS data to use data.table() functionality
fileACS <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileACS, destfile = "ss06pid.csv")
DT <- fread("ss06pid.csv")

# test out user time on calculations
# --system.time not precise enough in windows, use rbenchmark
benchmark(sapply(split(DT$pwgtp15, DT$SEX),mean), tapply(DT$pwgtp15,DT$SEX,mean), 
          DT[,mean(pwgtp15),by=SEX])
        # gives user.self times 0.07, 0.14, 0.06 respectively

benchmark({rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]}) #errors -- x must be numeric
benchmark(mean(DT$pwgtp15,by=DT$SEX))           #single num, no break out by SEX! (time = 0.01)

# option below is incorrect because there's a faster option above
benchmark({mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)}) # time = 2.2 but correct output

