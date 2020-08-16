library(dplyr)
library(ggplot2)

setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Plot2
# Have total emissions from PM2.5 decreased in the
# Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008? Yes
# Use the base plotting system to make a plot answering this question.
balt <- subset(NEI, fips == "24510")

by_scc_yr <- balt %>%
    select(SCC, year) %>%
    group_by(SCC, year) %>%
    summarize(total_emissions = sum(SCC))

total_em <- balt %>%
     group_by(SCC, year) %>%
     summarize(total_emissions = sum(Emissions, na.rm=TRUE))

with(total_em, plot(year, total_emissions, main="PM2.5 emission from all sources in Baltimore City"))
