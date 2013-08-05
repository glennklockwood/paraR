#!/usr/bin/env Rscript
data <- read.csv('dataset.csv')
parallel.function <- function(i) {
  kmeans( x=data, centers=4, nstart=i )
}
results <- lapply( c(25, 25, 25, 25), FUN=parallel.function )
temp.vector <- sapply( results, function(result) { result$tot.withinss } )
result <- results[[which.min(temp.vector)]]

print(result)
