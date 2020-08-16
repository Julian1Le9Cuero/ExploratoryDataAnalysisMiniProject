library(dplyr)
library(ggplot2)

setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Plot3
# Of the four types of sources indicated by the
# type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen
# decreases in emissions from 1999-2008 for Baltimore
# City? Which have seen increases in emissions from
# 1999-2008? Use the ggplot2 plotting system to make
# a plot answer this question.
balt <- subset(NEI, fips == "24510")

by_source <- balt %>% group_by(type, year) %>%
    summarize(total_emissions=sum(Emissions, na.rm=TRUE))

by_source %>% ggplot(aes(year, total_emissions, col=type)) + geom_line()
