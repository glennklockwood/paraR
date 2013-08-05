#!/usr/bin/env Rscript

data <- read.csv('dataset.csv')
result <- kmeans( data,
                  centers=4,
                  nstart=100 )
print(result)
