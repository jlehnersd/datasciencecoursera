library(dplyr)

# Locate the data 
file1URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
file2URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

# Download the data
if (!file.exists("gdp.csv")) {
    download.file(file1URL, destfile = "gdp.csv", method = "curl")
}
if (!file.exists("edu.csv")) {
    download.file(file2URL, destfile = "edu.csv", method = "curl")
}

# Read in the data
gdp_raw <- read.csv("gdp.csv")
edu_raw <- read.csv("edu.csv")

# Tidy the data
gdp_data <- gdp_raw %>%
    select(code = X,
           country = X.2, gdp = X.3,
           ranking = Gross.domestic.product.2012) %>%
    slice(-c(1:4, 195, 220:330)) %>%
    mutate(code = as.character(code),
           country = as.character(country),
           gdp = as.numeric(gsub(",", "", gdp)),
           ranking = as.numeric(as.character(ranking))) %>%
    filter(!(code == "")) %>%
    arrange(code)
edu_data <- edu_raw %>%
    rename(code = CountryCode) %>%
    mutate(code = as.character(code),
           incomegroup = as.character(Income.Group)) %>%
    arrange(code)

# Merge data into one data table
merged_dt <- merge(gdp_data, edu_data, by = "code", all = TRUE)

# Count the number of country codes common to both data sets
nMatches <- sum(!is.na(unique(merged_dt$ranking)))

# Determine the rank-13 country in GDP
merged_dt <- arrange(merged_dt, desc(ranking))
rank13gdp <- merged_dt$country[13]

# Determine average GDP rank for "High income" groups
grp1 <- "High income: OECD"
grp2 <- "High income: nonOECD"
rank_avg_dt <- merged_dt %>%
    group_by(incomegroup) %>%
    summarize(mean_rank = mean(ranking, na.rm = TRUE)) %>%
    filter(incomegroup == grp1 | incomegroup == grp2)

# Determine number of lower middle income countries in 1st quantile of GDP
quants <- quantile(merged_dt$ranking, seq(0, 1, 0.2), na.rm = TRUE)
quant_dt <- merged_dt %>%
    mutate(rankquants = cut(ranking, quants)) %>%
    group_by(rankquants, incomegroup) %>%
    summarize(nCountries = n())