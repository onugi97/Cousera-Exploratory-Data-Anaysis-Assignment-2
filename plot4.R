### Question 4: ###############################################################################
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
###############################################################################################
library(plyr)
library(ggplot2)

filepath <- getwd() #filepath
## Read Data Files

NEI <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "summarySCC_PM25.rds")) 
SCC <- readRDS(paste0(filepath,"/exdata-data-NEI_data/", "Source_Classification_Code.rds"))
str(SCC)

## Search and subset coal-combustion-related sources from SCCs
coalID <- SCC[grepl("[Cc]oal", SCC$Short.Name, perl=TRUE) & !grepl("[Cc]oal\\sMining", SCC$Short.Name, perl=TRUE),]  
coal_NEI <- NEI[NEI$SCC %in% coalID$SCC,] #head(coal_NEI)

# Summarize total emissions by years
coalEmissionTtl <- aggregate(Emissions ~ year, data=coalNEI, sum)

png(file="plot4.png", width=600, height=600, bg="white") 
barplot(coalEmissionTtl$Emissions, names.arg=coalEmissionTtl$year, 
        xlab="Year", ylab="PM 2.5 Emissions in Tons", 
        main="Total Coal Combustion-Related PM 2.5 Emissions in the US")  
dev.off()
