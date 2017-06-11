# Creating New Variables
# Useful in flagging missing values, cutting up quantitative values
# and applying transformations

# option to check if a directory exists
# if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = rd <- tempfile(fileext = ".csv"))
restData <- read.csv(rd)

# Creating sequences (seq function)
s1 <- seq(1,10,by=2) ; s1  #by argument
s2 <- seq(1,10,length=3); s2 #length of vector

x <- c(1,3,8,25,100); seq(along = x) # along takes length from x

# Subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

# Create binary variables (flags)
restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

# Create categorical variables
# cut function
# NOTE -- cutting produces factor variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)

table(restData$zipGroups, restData$zipCode)

# Easier cutting with cut2 (finds breaks)
library(Hmisc)
restData$zipGroups=cut2(restData$zipCode,g=4)
table(restData$zipGroups)

# Creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)

# Levels of factor variables
# create vector of yes & no values
yesno <- sample(c("yes","no"),size=10,replace=TRUE)

# this sets 'yes' as lowest level in vector
# relevels on yes
yesnofac = factor(yesno,levels=c("yes","no"))
relevel(yesnofac,ref="yes")

as.numeric(yesnofac)  #changes factor back to numeric (lowest gets value 1)

# Using the mutate function (plyr package)
library(Hmisc); library(plyr)
# create new dataset with new column zipGroups
restData2 = mutate(restData, zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

# Common transform functions
        # abs()
        # sqrt()
        # ceiling()
        # floor()
        # round() --- digits is num of dec places
        # signif() -- digits is num of sig figs
        # cos()
        # log()
        # log2(), log10()
        # exp()