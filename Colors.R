
#### Base Colors ####

# If you call col = 1:3, that means:
#   - col = 1, black
#   - col = 2, red
#   - col = 3, green

# heat.colors(): red (low) through yellow/white (high)
# topo.colors(): dark blue (low) through yellow/white (high)





#### grDevices package ####

colors() 
# Lists the names of 657 predefined colors you can use in any plot func

colorRamp() 
# Takes a palette of colors (args) and returns a func that takes vales b/w
#   0 and 1 as args. The 0 and 1 correspond to the extremes of the color 
#   palette and args b/w 0 and 1 return blends of these extremes. 

pal <- colorRamp(c("red", "blue"))
pal(0)
#   Returns:     [,1] [,2] [,3]
#           [1,]  255    0    0
#       - 1x3 array with 255 as the first entry and 0 in the other 2
#       - This vector corresponds to RGB color encoding: 24 bits (3 sets of 8
#           bits) each of which represents an intensidy for one of RGB
#       - EX. (255, 0, 0) corresponds to highest possible value of red2


colorRampPalette()
# Takes a palette of colors (args) and returns a func that takes integer args
#   and returns a vector of colors each of which is a blend of colors of the 
#   original palette. The arg you pass to the returned func specified the num
#   of colors you want returned. Each element of returned vector is 24 bit num
#   represented as 6 hex chars (0-F). This set represents the intensities of 
#   RGB with two chars for each color. Similar to heat.colors() or topo.colors()

p1 <- colorRampPalette(c("red", "blue"))

p1(2)
#   Returns: [1] "#FF0000" "#0000FF"
#       - The first entry represents red, the second represents blue
#       - FF is hexidecimal for 255

p1(6)
#   Returns: "#FF0000" "#CC0033" "#990066" "#650099" "#3200CC" "#0000FF"

alpha
# Represents an opacity level in cals to rgb()
plot(x, y, pch = 19, col = rgb(0, 0.5, 0.5, 0.3))



#### RColorBrewer Package ####

# provides color palettes for sequential, categorical, and diverging data
cols <- brewer.pal(3, "BuGn")
