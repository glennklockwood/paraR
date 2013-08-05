#!/usr/bin/env Rscript
library(foreach)
library(doMC)
data <- read.csv('dataset.csv')
registerDoMC(4)
results <- foreach( i = c(25,25,25,25) ) %dopar% {
    kmeans( x=data, centers=4, nstart=i )
}
temp.vector <- sapply( results, function(result) { result$tot.withinss } )
result <- results[[which.min(temp.vector)]]

print(result)
