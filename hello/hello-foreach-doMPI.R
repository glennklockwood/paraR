#!/usr/bin/env Rscript
 
hello.world <- function(i) {
   sprintf('Hello from loop iteration %d running on rank %d on node %s',
       i, mpi.comm.rank(), Sys.info()[c("nodename")]);
}
 
library(foreach)
library(doMPI)
cl <- startMPIcluster(includemaster=TRUE)
 
registerDoMPI(cl)
 
output.lines <- foreach(i = (1:128)) %dopar% {
   hello.world(i)
}

cat(unlist(output.lines), sep='\n')
 
closeCluster(cl)
mpi.exit()
print('doMPI is not very robust and tends to cause a lot of subtle problems.  I do not recommend its use; use doSNOW instead.')
