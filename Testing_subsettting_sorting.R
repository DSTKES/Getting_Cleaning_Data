# Subsetting & sorting
set.seed(12345)
x <- data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
x <- x[sample(1:5),]; x$var2[c(1,3)]=NA
x

# subset a column
x[,1]           # index on the first column
x[,"var1"]      # name column
x[1:2,"var1"]    # first 2 rows of a single column

# logical statements
x[(x$var1 <= 3 & x$var3 > 11),]  #rows where var1 <= 3 and var3 > 11
x[(x$var1 <= 3 | x$var3 > 15),]  #rows where var1 <= 3 OR var3 > 15

# Dealing with missing values
# --subsetting on NA values won't produce actual rows
x[which(x$var2 > 8),] #which command subsets without NAs

# Sorting
sort(x$var1)
sort(x$var1, decreasing=TRUE)
sort(x$var2, na.last = TRUE)

# Ordering a data frame
x[order(x$var1),] #order function passes values to data frame to give ordered df
x[order(x$var1,x$var3),] #order on 2 vars

# ordering with plyr package (dplyr too?)
library(plyr)
arrange(x, var1)
arrange(x, desc(var1))

# adding rows and columns
x$var4 <- rnorm(5)
x

y <- cbind(x,rnorm(5)) # method2 use cbind
y  # if binding rows then use rbind function
