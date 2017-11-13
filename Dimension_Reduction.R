
# What if we add a pattern to an otherwise noisy and unorganized data set?
set.seed(678910)
for (i in 1:40) {
    # Flip a coin:
    coinFlip <- rbinom(1, size = 1, prob = 0.5)
    # If coin is heads up (i.e. = 1) we add a pattern to that row:
    if (coinFlip) {
        # Five of the columns in that row have a mean 3 and 5 have mean 0:
        dataMatrix[i, ] <- dataMatrix[i, ] + rep(c(0, 3), each = 5)
    }
}

# Find the best matrix created with fewer variables (that is, a lower rank
#   matrix) that explains the original data. This is related to data compression.




##### Singular Value Decomposition (SVD) ####
#   - If X is a matrix with each variable in a column and each observation in a
#       row, then the SVD is a "matrix decomposition":
#               X = UDV^T
#       - Where the columns of U are orthogonal(uncorrelated) (left singular vectors)
#       - The columns of V are orthogonal (right singular vectors), and
#       - D is a diagonal matrix (singular values)


# EXAMPLE OF SVD:
#   - Sample data set: mat (2x3 matrix)
#           [,1]    [,2]    [,3]
#     [1,]   1       2       3
#     [2,]   2       5       7
svd(mat)
#       $d          #d holds diagonal elements
#   [1] 9.5899624 0.1806108
#       $u          
#           [,1]       [,2]
#   [1,] -0.3897782 -0.9209087
#   [2,] -0.9209087  0.3897782
#       $v
#           [,1]       [,2]
#   [1,] -0.2327012 -0.7826345
#   [2,] -0.5614308  0.5928424
#   [3,] -0.7941320 -0.1897921

# Multiply the three matrices:
matu %*% diag %*% t(matv)
#       ^^^ should return the same original matrix





#### Principal Component Analysis (PCA) ####
#   - A method to reduce a high-dimensional data set to its essential elements
#       and explain the variability in the data
#   - The principal components are equal to the right singular values if you
#       first scale (subtract the mean, divide by standard deviation) the vars


# EXAMPLE OF PCA:
svd(scale(mat))
prcomp(scale(mat))

