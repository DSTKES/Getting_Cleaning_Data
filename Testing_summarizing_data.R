# Summarizing Data
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = rd <- tempfile(fileext = ".csv"))
restData <- read.csv(rd)
head(restData, n=3)
tail(restData, n=3)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, probs = c(0.5,0.75,0.9))

# Make tables using table()
table(restData$zipCode,useNA = "ifany") #"ifany" will display count of missing values

# Create 2x2 table
table(restData$councilDistrict, restData$zipCode)

# checking for missing values
sum(is.na(restData$councilDistrict))

# any() will look through all values to see if any are NA
any(is.na(restData$councilDistrict))

# all() checks if every values satisfies the given condition
all(restData$councilDistrict>0)

# row & column sums
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

# Values w/ specific characteristics
# using %in% operator
table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"),]

# Crosstabs
data("UCBAdmissions") #dataset in R
DF = as.data.frame(UCBAdmissions)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt

# Flat tables
warpbreaks$replicate <- rep(1:9, len=54)
xt = xtabs(breaks ~.,data=warpbreaks)  # period "." means all variables
xt

ftable(xt)

# Size of dataset
fakeData = rnorm(1e5)
object.size(fakeData)

print(object.size(fakeData), units="Mb")
