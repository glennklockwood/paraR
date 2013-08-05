#!/usr/bin/env Rscript
#
#  gen-data.R - generate a "dataset.csv" for use with the k-means clustering
#    examples included in this repository
#

nrow <- 50000
sd <- 0.5

real.centers <- list( x=c(-1.3, -0.7, 0.0, +0.7, +1.2), 
                      y=c(-1.0, +1.0, 0.1, -1.3, +1.2) )

data <- matrix(nrow=0, ncol=2)
colnames(data) <- c("x", "y")

for (i in seq(1, 5)) {
    x0 <- rnorm(nrow, mean=real.centers$x[[i]], sd=sd)
    y0 <- rnorm(nrow, mean=real.centers$y[[i]], sd=sd)
    data <- rbind( data, cbind(x0,y0) )
}

write.csv(data, file='dataset.csv', row.names=FALSE)
