library(dplyr)
library(ggplot2)

setwd("C:/Users/julia/OneDrive/Escritorio/Rprogramming/EDAcourseproject1")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot4
# Across the United States, how have emissions
# from coal combustion-related sources changed
# from 1999-2008?
coal_combustion <- subset(SCC, SCC.Level.Three %in% c('Anthracite Coal', 'Bituminous/Subbituminous Coal')) %>%
    select(SCC, SCC.Level.Three)

coal_scc <- NEI %>%
    inner_join(coal_combustion, by="SCC") %>%
    select(SCC, SCC.Level.Three, Emissions, year)

coal_scc %>% group_by(SCC.Level.Three, year) %>%
    summarize(total_em = sum(Emissions, na.rm = TRUE)) %>%
    ggplot(aes(year, total_em, col = SCC.Level.Three)) + geom_line()
