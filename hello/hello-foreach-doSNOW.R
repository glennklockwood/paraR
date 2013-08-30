#!/usr/bin/env Rscript
 
hello.world <- function(i) {
   sprintf('Hello from loop iteration %d running on rank %d on node %s',
       i, mpi.comm.rank(), Sys.info()[c("nodename")]);
}
 
library(snow)
library(doSNOW)

cl <- makeCluster( mpi.universe.size(), type="MPI" )
registerDoSNOW(cl)
 
foreach(i = (1:128)) %dopar% {
   hello.world(i)
}
 
stopCluster(cl)
mpi.exit()
