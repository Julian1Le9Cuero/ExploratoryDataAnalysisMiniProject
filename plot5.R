library(dplyr)
library(ggplot2)

setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot5
# How have emissions from motor
# vehicle sources changed from
# 1999-2008 in Baltimore City?
vehicle_scc <- subset(SCC, EI.Sector %in% grep('vehicle', EI.Sector, value=TRUE, ignore.case=TRUE))

mt_vehicle <- balt %>% inner_join(vehicle_scc, by="SCC") %>%
    select(SCC, year, Emissions, type, EI.Sector) %>%
    group_by(EI.Sector, year) %>% summarize(total_em = sum(Emissions, na.rm=TRUE)) %>%
    rename(motor_vehicle_scc = EI.Sector)

mt_vehicle %>% ggplot(aes(year, total_em, col=motor_vehicle_scc)) + geom_line()
