
#### Lattice Plotting System ####
library(lattice)
library(grid)

# The Lattice Package:
#   - Contains code for producing Trellis graphics
#   - xyplot, bwplot, levelplot
#   - Lattice package builds on the Grid package
#   - All plotting and annotating done in one function call

# Functions:
#   - xyplot: scatterplots 
        - xyplot(y ~ x | f * g, data)
#       - f and g are conditioning variables (they're optional)
#       - the * indicates an interaction between the two variables
#   - bwplot: boxplots (bar and whisker plots)
#   - histogram: histogram
#   - stripplot: like a boxplot but with points
#   - dotplot: plot dots on "voilin strings"
#   - splom: scatterplot matrix (like pairs in base plot)
#   - levelplot, contourplot: for plotting image data 



#### Lattice vs. Base Plotting ####
#   - Base plots directly into graphics device (screen, PDF, PNG, etc.)
#   - Lattice retuns an object of class TRELLIS:
#       - print methods plot the data to a grphics device
#       - Lattice functions return "plot objects" that can be stored (but it's
#           usually better to just save the code and data)
#       - On the commmand line, trellis objects are auto-printed so it appears
#           that the function is plotting the data



#### Panel Functions ####
#   - Panel functions control what happens inside each panel of the plot
#   - Lattice package comes with default panel functions, but you can supply your own
#       to customize
#   - Panel funcs receive x, y coords of data points in their panel

xyplot(y ~ x | f, panel = function(x, y, ...){
    panel.xyplot(x, y, ...) # First call default panel func for xyplot
    panel.abline(h = median(y), lty = 2)
})

names(p) # Returns all named properties of plot