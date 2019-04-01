library(dplyr)

# Obtain American Community Survey data for Idaho housing in 2006
file1URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
if(!file.exists("idaho_acs.csv")){
    download.file(file1URL, destfile = "idaho_acs.csv", methos = "curl")
}
idaho_data <- read.csv("idaho_acs.csv")

# Split the variable names that begin with "wgtp"
split_names <- strsplit(names(idaho_data), "wgtp")
print(split_names[123])

######################################################

# Obtain worldwide GDP data by country
file2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
if(!file.exists("gdp_rank.csv")){
    download.file(file2URL, destfile = "gdp_rank.csv", methos = "curl")
}
gdp_data <- read.csv("gdp_rank.csv")

# Tidy up the GDP data
gdp_data <- gdp_data %>%
    select(countryCodes = X,
           ranking = Gross.domestic.product.2012,
           countryNames = X.2,
           gdp = X.3) %>%
    slice(-c(1:4, 195, 220:330))

# Remove commas from GDP values an convert to numeric
mean_gdp <- gdp_data %>%
    select(gdp = gdp) %>%
    mutate(gdp = as.numeric(gsub(",", "", gdp))) %>%
    summarize(average = mean(gdp, na.rm = TRUE))
print(mean_gdp)

# Use regular expressions to find country names that begin with "United"
countries <- as.character(gdp_data$countryNames)
uniteds <- grep("^United", countries, value = TRUE)
print(uniteds)

# Obtain the worldwide education data by country
file3URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
if(!file.exists("education.csv")){
    download.file(file3URL, destfile = "education.csv", methos = "curl")
}
edu_data <- read.csv("education.csv")

# Tidy up the education data
edu_data <- edu_data %>%
    select(countryCodes = CountryCode,
           notes = Special.Notes) %>%
    mutate(notes = tolower((as.character(notes))))

# Find the number of countries for which a fiscal year end of June is reported
fiscaljune <- "fiscal year end: june"
print(length(grep(fiscaljune,edu_data$notes)))

# Find the number of times Amazon stock value was recorded on Mondays in 2012
library(quantmod)
library(lubridate)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

years2012 <- sampleTimes[year(sampleTimes) == 2012]
print(length(years2012))
mondays2012 <- years2012[wday(years2012) == 2]
print(length(mondays2012))

