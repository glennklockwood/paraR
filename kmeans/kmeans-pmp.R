#!/usr/bin/env Rscript

args <- commandArgs(TRUE)
set.seed(args[1])
 
data <- read.csv('dataset.csv')
  
result <- kmeans(data, centers=4, nstart=25)
   
print(result)
