
# Clustering organizes things that are close into groups. 
#   - How do we define close?
#   - How do we group things?
#   - How do we visualize the grouping?
#   - How do we interpret the grouping?




#### Hierarchical Clustering ####
#   - An agglomerative approach (bottom up):
#       1.) Find closest two things
#       2.) Put them together
#       3.) Find next closest
#           - When do you stop clustering?
#               1.) Clusters are too far apart to be merged (distance criterion)
#               2.) Sufficiently small number of clusters (number criterion)
#   - Requires:
#       1.) A defined distance
#       2.) A merging approach
#   - Produces:
#       1.) A tree that shows how close things are to eachother 

# So how do we define distance or similarity in hierarchical clustering? 
#   1.) Euclidean: continuous, straight line distance bw two points 
#           EX. (x1, y1) - (x2, y2) or length of hypotenuse of triange
#   2.) Correlation similarity: continuous
#   3.) Manhattan: binary, imagine points on grid
#           EX. Taxi Cab geometry, absolute sum of all different coordinates
#           EX. |x1 - x2| + |y1 - y2|


# EXAMPLE OF HIERARCHICAL CLUSTERING:

# Set seed to make data reproducible:
    set.seed(1234)
# Set margins to 0:
    par(mar = c(0, 0, 0, 0))
# Assign values to x and y:
    x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
    y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
# Make plot:
    plot(x, y, col = "blue", pch = 19, cex = 2)
# Annotate each data point:
    text(x + 0.05, y + 0.05, labels = as.character(1:12))

# Run hierarchical clustering algorithm:
#   STEP 1 - calculate all pairwise distances (distances bw all points):
        df <- data.frame(x = x, y = y)
        dist(df)
            # Returns distance matrix (EX. dist b/w P1 and P2 is 0.3412)
            # Lower triangular matrix
        
#   STEP 2 - take the two points that are closest to eachother (in this case
#       P5 and P6), group them together, and merge them into a single cluster. 
#       Then take the second two points that are closest together (in this case
#       P10 and P11), group them together, and merge them into a single cluster.

#       Merging points: how to you know where new, merged point is?
#           - Average linkage: new point is avg of x and y coordinates
#           - Complete linkage: the similarity of two clusters is the similarity
#               of their most different points
#           
#   STEP 3 - Create cluster Dendrogram using hclust():
        distxy <- dist(df)
        hClustering <- hclust(distxy) # hclust takes pairwise dist matrix
        plot(hClustering)
#           To interpret plot: points that are closest to the bottom are clustered
#               first, and the higher up, the later they are clustered (i.e. 
#               greater pairwise distance)

#   STEP 4 - Count the number of clusters: depends on number of brances cut if 
#        you draw a horizonal line. 
#            - Cut the clusters: abline()

        
        
#   Heatmap(): a graphical representation of data where the individual values 
#       contained in a matrix are represented as colors. Image with a dendrogram
#       added to left and top. Reordering of the  rows and columns within the 
#       restrictions imposed by Hclustering. Larger values = darker and smaller
#       values = ligher. 

# HEATMAP HC EXAMPLE:
    df <- data.frame(x = x, y = y)
    set.seed(143)
    dataMatrix <- as.matrix(df) [sample(1:12), ]
    heatmap(dataMatrix)








#### K-Means Clustering ####

#   - A partitioning approach: aims to partition the points into k groups such
#           that the sum of squares from points to the assigned cluster centers
#           is minimized. 
#       1.) Fix a number of clusters 
#       2.) Get "centroids" of each cluster
#       3.) Assign things to closest centroid
#       4.) Recalculate centroids
#   - Requires:
#       1.) A defined distance metric
#       2.) A number of clusters
#       3.) An initial guess as to cluster centroids
#   - Produces:
#       1.) Final estimate of cluster centroids
#       2.) An assignment of each point to clusters



# K-MEANS CLUSTERING EXAMPLE: (Note data is same as HC example)
    keams(x = numeric matrix of data, centers = num clusters or set of initial
          centroids, iter.max = max num of iterations to go through, nstart = 
          number of random starts to try if centers is a number)

# Set seed to make data reproducible:
    set.seed(1234)
# Set margins to 0:
    par(mar = c(0, 0, 0, 0))
# Assign values to x and y:
    x <- rnorm(12, mean = rep(1:3, each = 4), sd = 0.2)
    y <- rnorm(12, mean = rep(c(1, 2, 1), each = 4), sd = 0.2)
# Make plot:
    plot(x, y, col = "blue", pch = 19, cex = 2)
# Annotate each data point:
    text(x + 0.05, y + 0.05, labels = as.character(1:12))

# Run K-Means clustering algorithm:
#    STEP 1 - assign random starting points for centroids
#    STEP 2 - assign each data point to closest centroid
#    STEP 3 - recalculate centroids (EX. by taking mean of each cluster)
#    STEP 4 - reassign each data point to closest centroid 
    
# K-Means algorithm:
    df <- data.frame(x, y)
    kmeansObj <- kmeans(df, center = 3) #Assuming 3 clusters
            #^^^ kmeansObj returns a list of 9 elements

# To see what clusters each point is assigned:
    kmeansObj$cluster
        # Returns [1] 3 3 3 3 1 1 1 1 2 2 2 2

# To plot the results of kmeans:
    # Set margins:
        par(mar = rep(0.2, 4))
    # Plot the points:
        plot(x, y, col = kmeansObj$cluster, pch = 19, cex = 2)
    # Plot the centroids: 
        points(kmeansObj$centers, col = 1:3, pch = 3, cex = 3, lwd = 3)



# HEATMAP KM EXAMPLE:
    set.seed(1243)
    dataMatrix <- as.matrix(df) [sample(1:12), ]
    kmeansObj2 <- kmeans(df, centers = 3)
    par(mfrow = c(1, 2), mar = c(2, 4, 0.1, 0.1))
    image(t(dataMatrix) [, nrow(dataMatrix):1], yaxt = "n")
    image(t(dataMatrix) [, order(kmeansObj$cluster)], yaxt = "n")
    # Plot on the left is original data
    # Plot on the right is reorg of rows so clusters are together
    