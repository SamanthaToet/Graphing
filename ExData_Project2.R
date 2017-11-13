
#### Intro ####

# Note: to be included with the source code for each question. 

# Set working directory and read in the data:

setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")

NEI <- readRDS("summarySCC_PM25.rds")
#   This file contains a data frame with all of the PM2.5 emissions data for 
#       1999, 2002, 2005, and 2008. For each year, the table contains number 
#       of tons of PM2.5 emitted from a specific type of source for the 
#       entire year. 

SCC <- readRDS("Source_Classification_Code.rds")
#   This table provides a mapping from the SCC digit strings in the Emissions 
#       table to the actual name of the PM2.5 source. The sources are 
#       categorized in a few different ways from more general to more specific.




#### Question 1 ####
# Have total emissions from PM2.5 decreased in the United States from 
#   1999 to 2008? Using the base plotting system, make a plot showing the total 
#   PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
#   and 2008.

# Set working directory and read in the data:
setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Aggregate the total emissions from all sources by year:
total_emissions <- aggregate(Emissions ~ year, NEI, sum)

# Create plot:
    # Bc we are looking at a measure of counts, we should use a barplot:
barplot(
    (total_emissions$Emissions)/10^6,
    names.arg = c("1999", "2002", "2005", "2008"),
    xlab = "Year", 
    ylab = "Total PM2.5 Emissions (Millions of Tons)", 
    main = "Total PM2.5 Emissions from All Sources")

# Save plot:
dev.copy(png,'Plot1.png')
dev.off()

# ANSWER:
# From the plot, we can see that total emissions have decreased from over 7.3 
#   million tons in 1999 to 3.4 million tons in 2008. 





#### Question 2 ####
# Have total emissions from PM2.5 decreased in Baltimore City, Maryland 
#   (fips == "24510") from 1999 to 2008? Use the base plotting system to 
#   make a plot answering this question. 

# Set working directory and read in the data:
setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset Baltimore:
baltimore <- NEI[NEI$fips == "24510",]

# Aggregate the total emissions from all sources by year for baltimore:
baltimore_total <- aggregate(Emissions ~ year, baltimore, sum)

# Create plot:
# Bc we are looking at a measure of counts, we should use a barplot:
barplot(
    (baltimore_total$Emissions), 
    names.arg = c("1999", "2002", "2005", "2008"), 
    xlab = "Years",
    ylab = "Total PM2 Emissions (Tons)", 
    main = "Total PM2 Emissions in Baltimore from All Sources")

# Save plot:
dev.copy(png,'Plot2.png')
dev.off()

# ANSWER:
# From the plot we can see that overall the total emissions have decreased from
#   about 3.3 thousand tons in 1999 to about 1.9 thousand tons in 2008. 





#### Question 3 ####
# Of the four types of sources indicated by the type variable (point, nonpoint,
#   onroad, nonroad), which of these four sources have seen decreases in 
#   emissions from 1999 - 2008 in Baltimore? Which have seen increases in 
#   emissions from 1999 - 2008? Use ggplot2.

# Set working directory and read in the data:
setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Subset Baltimore:
baltimore <- NEI[NEI$fips == "24510",]

# Aggregate total emissions by year and source:
baltimore_bysource <- aggregate(Emissions ~ year + type, baltimore, sum)

# Make plot:
ggplot(baltimore_bysource, aes(x = as.factor(year), y = Emissions)) +
    geom_col() + 
    facet_wrap(~ type, scales = "free_y") +
    labs(x = "Year")

# Save plot:
dev.copy(png,'Plot3.png')
dev.off()


# ANSWER:
# According to the plot, Nonroad, Nonpoint, and Onroad have decreased emissions 
#   from 1999 to 2008 while Point has increased slightly from 1999 to 2008 with 
#   a large spike in 2005.





#### Question 4 ####

# Across the United States, how have emissions from coal combustion-related 
#   sources changed from 1999–2008?

# Set working directory and read in the data:
setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot)

# Subset coal-combustion-related sources in SCC dataframe:
coal <- SCC[grep("Coal", SCC$EI.Sector), ]

# Join coal to NEI on SCC:
df <- merge(coal, NEI, by = "SCC")

# Drop empty levels:
df <- droplevels(df)

# Aggregate df by year:
df <- aggregate(Emissions ~ year + EI.Sector, df, sum)

# Make plot:
ggplot(df, aes(x = as.factor(year), y = Emissions)) +
    geom_col() + 
    facet_wrap(~ EI.Sector, scales = "free_y", nrow = 3) +
    labs(x = "Year")

# Save plot:
dev.copy(png,'Plot4.png')
dev.off()

# ANSWER:
# According to the plot, from 1999 to 2008 Commercial/Industrial coal emissions 
#   have decreased, Electric Generation coal emissions have decreased, and 
#   Industrial Boilers/ICE's coal emissions have increased. 





#### Question 5 ####
# How have emissions from motor vehicle sources changed from 1999–2008 in 
#   Baltimore City?

# Set working directory and read in the data:
setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Subset Baltimore:
baltimore <- NEI[NEI$fips == "24510",]

# Subset motor vehicle sources in SCC dataframe:
motor <- SCC[grep("Mobile - On-Road", SCC$EI.Sector), ]

# Join motor dataframe to baltimore df on SCC:
df2 <- merge(motor, baltimore, by = "SCC")

# Drop empty levels:
df2 <- droplevels(df2)

# Aggregate df2 by year:
df2 <- aggregate(Emissions ~ year + EI.Sector, df2, sum)

# Make plot:
ggplot(df2, aes(x = as.factor(year), y = Emissions)) +
    geom_col() + 
    facet_wrap(~ EI.Sector, scales = "free_y", nrow = 3) +
    labs(x = "Year")

# Save plot:
dev.copy(png,'Plot5.png')
dev.off()

# ANSWER:
# According to the plot, Heavy Duty Diesel, Light Duty Diesel, Heavy Duty 
#   Gasoline, and Light Duty Gasoline have all decreased in Baltimore city 
#   from 1999 to 2008.





#### Question 6 ####
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
#   from motor vehicle sources in Los Angeles County, California 
#   (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time
#   in motor vehicle emissions?

# Set working directory and read in the data:
setwd("~/Desktop/Data Science/Graphing/exdata%2Fdata%2FNEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Subset Baltimore and Los Angeles:
balt_la <- NEI[NEI$fips == "24510" | NEI$fips == "06037",]

# Subset motor vehicle sources in SCC dataframe:
motor <- SCC[grep("Mobile - On-Road", SCC$EI.Sector), ]

# Join motor dataframe to balt_la df on SCC:
balt_la_motor <- merge(motor, balt_la, by = "SCC")

# Drop empty levels:
bl_motor <- droplevels(balt_la_motor)

# Aggregate all the things:
bl_motor_agg <- aggregate(Emissions ~ year + EI.Sector + fips, bl_motor, sum)

# Make plot:
ggplot(bl_motor_agg, aes(x = as.factor(year), y = Emissions, fill = fips)) +
    geom_col(position = "dodge") + 
    facet_wrap(~ EI.Sector, scales = "free_y", nrow = 3) +
    labs(x = "Year") +
    scale_fill_discrete(name="City", 
                        breaks = c("06037", "24510"), 
                        labels=c("Los Angeles", "Baltimore"))

# Save plot:
dev.copy(png,'Plot6.png')
dev.off()

# ANSWER:
# According to the plot, overall there are more emissions in LA than Baltimore.
#   The emissions from Heavy Duty Diesel vehicles and Heavy Duty Gasoline
#   vehicles have increased in LA from 1999-2008, but decreased in Baltimore. 
#   Emissions from Light Duty Diesel vehicles and Light Duty Gasoline vehicles
#   have decreased for both Baltimore and LA. 


