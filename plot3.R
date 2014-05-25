### Question 3: ###############################################################################
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
###############################################################################################
library(plyr)
library(ggplot2)

filepath <- getwd() #filepath
## Read Data Files

NEI <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "summarySCC_PM25.rds")) 
SCC <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "Source_Classification_Code.rds"))

colsToFactors <- names(NEI) != "Emissions" 
NEI[ ,colsToFactors] <- lapply(NEI[ ,colsToFactors], factor) # str(NEI)

#Subset data for Baltimore, Maryland (fips=="24510")
BaltimoreNEI <- subset(NEI, fips == "24510") #dim(BaltimoreNEI); str(BaltimoreNEI)
ttlEmissionsBaltimoreType <- ddply(BaltimoreNEI, c("type", "year"), summarize, sumEmissions=sum(Emissions))

png(file="plot3-1.png", width=600, height=600, bg="white") 
      gplot1 <- ggplot(data=ttlEmissionsBaltimoreType, aes(year, sumEmissions)) 
      gplot1 + facet_grid(. ~ type) + geom_bar(stat="identity", aes(fill=factor(year))) + xlab("Year") + ylab("PM 2.5 emissions in tons") + ggtitle("Total PM 2.5 Emissions Type in Baltimore City, MD")
dev.off()

png(file="plot3-2.png", width=600, height=600, bg="white") 
      gplot2 <- ggplot(data=ttlEmissionsBaltimoreType, aes(year, sumEmissions, group = type, color = type ))
      gplot2 + geom_line(lwd=2) + ggtitle("Total PM 2.5 Emissions Type in Baltimore City, MD") + xlab("Year") + ylab("PM 2.5 emissions in tons") + ggtitle("Total PM 2.5 Emissions Type in Baltimore City, MD")
dev.off()

#print(gplot1); print(gplot2)