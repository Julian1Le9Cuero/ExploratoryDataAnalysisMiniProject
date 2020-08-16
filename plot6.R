library(dplyr)
library(ggplot2)

setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot6
# Compare emissions from motor vehicle
# sources in Baltimore City with emissions
# from motor vehicle sources in Los
# Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
vehicle_scc <- subset(SCC, EI.Sector %in% grep('vehicle', EI.Sector, value=TRUE, ignore.case=TRUE))

joined <- NEI %>% filter(fips %in% c('24510', '06037')) %>%
    inner_join(vehicle_scc, by="SCC") %>%
    select(SCC, fips, EI.Sector, Emissions, year) %>%
    group_by(year, EI.Sector)

balt <- subset(joined, fips == "24510") %>%
    summarize(total_em = sum(Emissions, na.rm=TRUE))

angl <- subset(joined, fips == "06037") %>%
    summarize(total_em = sum(Emissions, na.rm=TRUE))

par(mfrow=c(1,2), mar=c(5,4,2,4),oma=c(0,0,2,0), cex=.5)

with(balt, plot(year, total_em, col=EI.Sector, pch=20))
legend('topright', pch=20, col=unique(balt$EI.Sector), legend = unique(balt$EI.Sector))

with(angl, plot(year, total_em, col=EI.Sector, pch=20))
legend('topright', pch=20, col=unique(angl$EI.Sector), legend = unique(angl$EI.Sector))

title( main = 'Emissions from motor vehicle sources in Baltimore vs L.A', outer=TRUE)
