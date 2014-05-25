### Question 1: 1. #####################################################################
  # Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
  # Using the baseplotting system, make a plot showing the total PM2.5 emission from all 
  # sources for each of the years 1999, 2002, 2005, and 2008.
########################################################################################
library(plyr)
library(ggplot2)

filepath <- getwd() #filepath
## Read Data Files

NEI <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "summarySCC_PM25.rds")) 
SCC <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "Source_Classification_Code.rds")) 

## Convert all data types to factor except the "Emissions" variable.
colsToFactors <- names(NEI) != "Emissions" 
NEI[ ,colsToFactors] <- lapply(NEI[ ,colsToFactors], factor) # str(NEI)

ttlEmissions <- ddply(NEI, "year", summarize, sumEmissions=sum(Emissions))

png(file="plot1.png", width=600, height=600, bg="white") 
par(mar=c(4,5,4,2))
with(ttlEmissions, {
      bplot <- barplot(names.arg=year, sumEmissions, 
                    main = "US PM 2.5 Emissions per Year",
                    ylab = "PM 2.5 emissions in tons",
                    xlab = "Year",
                    ylim = c(0, max(sumEmissions)*1.05))
})
dev.off()



