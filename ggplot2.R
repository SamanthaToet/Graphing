#### ggplot2 ####
library(ggplot2)

# Grammar of graphics: a statistical graphic is a MAPPING from data to AESTHETIC
#   attributes (color, shape, size), of GEOMETRIC objects (points, lines, bars).
#   It may also contain statistic transformations of the data and is drawn on
#   a specific coordinate system. 


# Basic components of ggplot2:
# 1.) A data frame
# 2.) Aesthetic mappings: how data are mapped to color, size
# 3.) Geoms: geometric objects like points, lines, shapes
# 4.) Facets: for conditional plots
# 5.) Stats: statistical transformations like binning, quartiles, smoothing
# 6.) Scales: what scale an aesthetic map uses (EX. male = red, female = blue)
# 7.) Coordinate system

# Plots are built in layers:
#   - Plot the data
#   - Overlay a summary
#   - Metadata and annotation






#### qplot() ####
#   - Works like plot() in base (think quick plot)
#   - Looks for data in df, similar to lattice, or parent environment
#       - Organize df prior to plotting
#   - Plots made up of aesthetics (size, shape color) and geoms (points, lines)
#   - FACTORS important in indicating subsets of data (labeled)


# Use sample data mpg from ggplot2 package:
    qplot(displ, hwy, data = mpg)
    # Apply different color for different category of drv:
        qplot(displ, hwy, data = mpg, color = drv)
            # ^^^ Note auto placement of legend as assignment of colors
            
    # Make a histogram using qplot():
       qplot(hwy, data = mpg, fill = drv) 

qplot(displ, hwy, data = mpg, geom = c("point", "smooth"), facets = .~drv)



#### ggplot() ####

# Create a plot:
    g <- ggplot(mpg, aes(displ, hwy))
# Add a layer to print:
    g + geom_point()




#### Smoothing ####
# Trend lines:
qplot(displ, hwy, data = mpg, color = drv, geom = c("point", "smooth"))
    # ^^^ Note that grey areas are 95% confidence intervals


       
#### Facets ####
#   - like panels in lattice, for conditional plots
#   - Variable on the left of the ~ determines the rows of the panels
#   - Variable on the right of the ~ determines the columns of the panels
    qplot(displ, hwy, data = mpg, facets = .~drv)
    qplot(displ, hwy, data = mpg, facets = drv~., binwidth = 2)   

    
    
#### Printing ####
g <- ggplot(maacs, aes(logpm25, NocturnalSympt))
print(g)
Error: no layers in plot
    # ^^^ ggplot doesn't know what kind of plot to draw (lines, titles, etc.)
p <- g + geom_point() #g has all info geom_point needs to print
print(p)
    # ^^^ now you should get a plot 


#### Annotation ####
#   - Labels: xlab(), ylab(), labs(), ggtitle()
#   - Each of the geom functions has options to modify
#   - For things that only make sense globally, use theme():
        theme(legend.position = "none")
#   - Two standard appearance themes are included:
        theme_grey() # Default theme with grey background
        theme_bw() # More stark/plain
        
# alpha = transparancey
# aes(color = variable)

        
# Axis limits: different for outliers on base vs. gg
        

# Create plot (note that it will NOT be printed, just stored as g)
    g <- ggplot(mpg, aes(x = displ, y = hwy, color = factor(year))) 
# Print g:
    g + geom_point()
# Show as 2D multipanel plot:
g + geom_point() + facet_grid(drv ~ cyl, margins = TRUE)
g + geom_point() + facet_grid(drv ~ cyl, margins = TRUE) + geom_smooth(method = "lm", se = FALSE, size = 2, color = "black") + labs(x = "Displacement", y = "Highway Mileage", title = "Swirl Rules!")



cutpoints <- quantile(data to cut, seq(0, 1, length = 4), na.rm = TRUE)
    