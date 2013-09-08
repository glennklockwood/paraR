#!/usr/bin/env Rscript
 
hello.world <- function(i) {
   sprintf('Hello from loop iteration %d running on rank %d on node %s',
       i, mpi.comm.rank(), Sys.info()[c("nodename")]);
}

library(Rmpi)
library(parallel)
cl <- makeCluster( mpi.universe.size(), type='MPI' )

output.lines <- parLapply( cl=cl, X=(1:128), fun=hello.world )
cat(unlist(output.lines), sep='\n')
stopCluster(cl)
mpi.exit()
