
#### Base R Graphics ####

# 1.) Five Number Summary:
    summary(df$col)
    
# 2.) Boxplot:
    boxplot(df$col, col = "color")
    # Add overlaying horizontal line at 12:
        abline(h = 12)
    
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

# 4.) Barplot:
    barplot(table(df$col), col = "wheat", main = "Number of Counties in Each Region")
    
