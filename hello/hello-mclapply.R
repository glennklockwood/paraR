#!/usr/bin/env Rscript
 
hello.world <- function(i) {
   sprintf('Hello from loop iteration %d running on rank %d on node %s',
       i, Sys.getpid(), Sys.info()[c("nodename")]);
}

library(parallel)

output.lines <- mclapply( X=(1:128), FUN=hello.world )
cat(unlist(output.lines), sep='\n')
