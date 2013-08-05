#!/usr/bin/env Rscript
library(foreach)
data <- read.csv('dataset.csv')
results <- foreach( i = c(25,25,25,25) ) %do% {
    kmeans( x=data, centers=4, nstart=i )
}
temp.vector <- sapply( results, function(result) { result$tot.withinss } )
result <- results[[which.min(temp.vector)]]

print(result)
