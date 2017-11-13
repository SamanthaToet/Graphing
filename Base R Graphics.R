
#### Exploratory Graphs ####

# Used to find patterns in data, suggest modeling strategies, and debug anal. 
# NOT used to communicate results




#### Graphics Devices ####

# Graphics devices are things where you can make a plot appear, EX. a window 
#   on your computer (screen device), PDF or JPG (file device). Plots have to 
#   be "sent" to a graphics device. On a mac the most common place is a screen
#   device launched with quartz()

# There are two types files devices: vector and bitmap
    # Vector formats: 
        # PDF: line graphics, resizes well, good for simple plots
        # SVG (scalable vector graphics): xml based, good for interactive data
            # and web-based plots
    # Bitmap formats: don't resize well
        # PNG (portable network graphics): line graphics, good for plotting 
            # many, many points, lossless compression, doesn't resize well
        # JPG: pictures, lossy compression, don't resize well, can be read by
            # most web browsers
        # TIFF: supports lossless compression

# To see what graphics devices are availibale on your system:
?Devices 

# To see current plotting device:
dev.cur()

# To reset defaults:
dev.off()


#### Parameters ####

    # par() is used to specify global parameters, type par("your parameter")
        # to find out what is set as that value 
    # pch = the plotting symbol (default is open circle)
    # lty = line type (default is solid)
    # lwd = line width specified as an int
    # col = plotting color 
    # xlab = char str for x axis label
    # ylab = char str for y axis label
    # las = orientation of x axis labels 
    # bg = background color
    # mar = margin size
    # oma = outer margin size (default is 0) EX. title of multiple plots
    # mfrow = number of plots per row, column (plots are filled row-wise)
        # EX. mfrow(c(1, 2)) is one row with 2 cols, for side by side plots
    # mfcol = number of plots per row, column (plots are filled column-wise)

# Fitting a linear model:
    model <- lm(y ~ x, variable)
    abline(model)



    
#### Base R Graphics ####

# Functions:
    # plot() make a scatterplot or other type of plot depending on class
    # lines() add lines given vector of x values and corresponding y values
    # points() add points to a plot 
    # text() add text labels to a plot using specific x, y coordinates
    # title() add annotations to x, y axis labels, title, subtitle, or 
        #outer margins
    # mtext() add arbitrary text to the margins
    # axis() add axis ticks/labels

# Inclusive of Base PLotting

# 1.) Five Number Summary:
    summary(df$col)
    
# 2.) Boxplot:
    boxplot(df$col, col = "color")
    # Add overlaying horizontal line at 12:
        abline(h = 12)
    # Show two boxplots side by side:
        # y ~ x shows that y depends on x. If both x and y come from the same
            # df you can specify a data arg set equal to the df so that you 
            # don't have to keep typing df$col:
            boxplot(pm25~region, pollution, col = "red")
    
# 3.) Histogram:
    hist(df$col, col = "color")
    # Plot all points below histogram:
        rug(df$col)
    # Change the number of breaks or bars:
        hist(df$col, col = "color", breaks = 100)
    # Add overlaying vertical line at 12 with a width of 2:
        abline(v = 12, lwd = 2)
    # Add overlaying vertical line in magenta at the median with width of 4:
        abline(v = median(df$col), col = "magenta", lwd = 4)
    # Plot multiple histograms in one plot:
        # First specify how you want plots displayed and margins:
            par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
        # Subset:
            east <- subset(pollution, region == "east")
        # Plot:
            hist(east$pm25, col = "green")
            hist(subset(pollution,region=="west")$pm25, col = "green")

# 4.) Barplot:
    barplot(table(df$col), col = "wheat", main = "Number of Counties 
            in Each Region")
    
# 5.) Scatterplot:
    with(dataset, plot(X variable, Y variable))
    plot(pollution$latitude, ppm, col = pollution$region)
    # Make a dashed horizontal line:
        abline(h = 12, lwd = 2, lty = 2)
    # Plotting multiple scatterplots on one plot:
        # Set up the plot window:
            par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
        # Set up variables:
            west <- subset(pollution, region == "west")
        # Plot:
            plot(west$latitude, west$pm25, main = "West")
            plot(east$latitude, east$pm25, main = "East")



            

#### The Lattice System ####

# Plots are created with single function call (xyplot, etc.)
# Most useful for CONDITIONING types of plots (looking at how y changes with x
#   along z)
# Margins/spacing set automatically 

library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

# ^^^ xyplot() sends to screen device





#### ggplot2 ####

# Automatically deals with spacing, text, titles, but also can annotate by 
#   "adding" a plot

library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

# ^^^ qplot() sends to screen device
