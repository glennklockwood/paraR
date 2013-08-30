#!/usr/bin/env Rscript
 
hello.world <- function(i) {
   sprintf('Hello from loop iteration %d running on rank %d on node %s',
       i, Sys.getpid(), Sys.info()[c("nodename")]);
}
 
library(doMC)
registerDoMC(16)
 
foreach(i = (1:128)) %dopar% {
   hello.world(i)
}
