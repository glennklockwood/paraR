#!/usr/bin/env Rscript
 
library(foreach)
 
hello.world <- function(i) {
   sprintf('Hello from loop iteration %d running on rank %d on node %s',
       i, Sys.getpid(), Sys.info()[c("nodename")]);
}
 
foreach(i = (1:128)) %do% {
   hello.world(i)
}
