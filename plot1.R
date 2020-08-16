library(dplyr)
library(ggplot2)

setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot1
# Have total emissions from PM2.5 decreased in the
# United States from 1999 to 2008? Using the base
# plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years
# 1999, 2002, 2005, and 2008.
total_pm <- NEI %>% group_by(SCC, year) %>% summarize(total = sum(Emissions, na.rm = TRUE))

with(total_pm, plot(year, total, type = "n"))
with(total_pm, points(year, total, pch=20))
title(main="PM2.5 emission from all sources in USA")