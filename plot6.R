### Question 6: ###############################################################################
# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions (fips==24510) from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions
###############################################################################################
library(plyr)
library(ggplot2)

filepath <- getwd() #filepath
## Read Data Files

NEI <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "summarySCC_PM25.rds")) 
SCC <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "Source_Classification_Code.rds"))
str(SCC)

## Search and subset motor vehicle source related emissions for Baltimore and LA
vehicleSource <- subset(NEI, (fips=="24510" | fips=="06037") & type =="ON-ROAD") 

## Convert all data types to factor except the "Emissions" variable.
colsToFactor <- names(vehicleSource) != "Emissions" 
vehicleSource[ ,colsToFactors] <- lapply(vehicleSource[ ,colsToFactors], factor) 

str(vehicleSource) #check data type
table(vehicleSource$fips) #check Baltimore fips VS CA fips

#total motor vehicle related emissions in different years
vehicleEmissionTtl <- aggregate(Emissions ~ year + fips, data=vehicleSource, sum)
#str(vehicleEmissionTtl); head(vehicleEmissionTtl, n=2); tail(vehicleEmissionTtl, n=2)


## mf_labeller copied and modified from: 
 # http://stackoverflow.com/questions/10151123/how-to-specify-columns-in-facet-grid-or-how-to-change-labels-in-facet-wrap
mf_labeller <- function(var, value){
      value <- as.character(value)
      if (var=="fips") { 
            value[value=="24510"] <- "Baltimore City"
            value[value=="06037"]   <- "LA County"
      }
      return(value)
}

png(file="plot6.png", width=600, height=600, bg="white") 
      gplot1 <- ggplot(vehicleEmissionTtl, aes(year, Emissions)) + facet_grid(. ~ fips, labeller=mf_labeller) + geom_bar(stat="identity", aes(fill=factor(year))) + xlab("Year") + ylab("PM 2.5 Emissions in Tons") + ggtitle("Comparison of Total PM 2.5 Emissions Changes between Baltimore (MD) and Los Angeles (CA)")
      gplot1
dev.off()

#print(gplot1)
