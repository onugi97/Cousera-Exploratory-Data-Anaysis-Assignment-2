### Question 2: ###############################################################################
 # Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
 # from 1999 to 2008? Use the base plotting system to make a plot answering this question.
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
BaltimoreTtlEmissions <- ddply(BaltimoreNEI, "year", summarize, sumEmissions=sum(Emissions))
#BaltimoreTtlEmissions

png(file="plot2.png", width=600, height=600, bg="white") 
par(mar=c(4,5,4,2))
with(BaltimoreTtlEmissions, {
      bplot <- barplot(names.arg=year, sumEmissions, 
                       main = "PM 2.5Emissions in Baltimore, MD",
                       ylab = "PM 2.5 emissions in tons",
                       xlab = "Year",
                       ylim = c(0, max(sumEmissions)*1.05))  # simple scale to look better
})
dev.off()