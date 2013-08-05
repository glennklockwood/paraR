#!/usr/bin/env Rscript

library(parallel)

data <- read.csv( 'dataset.csv' )

parallel.function <- function(i) {
    kmeans( x=data, centers=4, nstart=i )
}

cl <- makeCluster( mpi.universe.size(), type="MPI" )
clusterExport(cl, c('data'))

results <- clusterApply( cl, c(25,25,25,25), fun=parallel.function )
temp.vector <- sapply( results, function(result) { result$tot.withinss } )
result <- results[[which.min(temp.vector)]]
print(result)
 
stopCluster(cl)
mpi.exit()
