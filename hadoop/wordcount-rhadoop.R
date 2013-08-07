#!/usr/bin/env Rscript
################################################################################
#   Simple Word Counter for RHadoop 1.3.1
#
#   Glenn K. Lockwood, San Diego Supercomputer Center               August 2013
################################################################################

library(rmr)
library(rhdfs)
 
input.file.local <- 'pg2701.txt'
input.file.hdfs <- 'mobydick.txt'
output.dir.hdfs <- 'output'
output.file.local <- 'output.txt'

mapper <- function( keys, lines ) {
    lines <- gsub('(^\\s+|\\s+$)', '', lines)
    keys <- unlist(strsplit(lines, split='\\s+'))
    value <- 1
    lapply(keys, FUN=keyval, v=value)
}

reducer <- function( key, values ) {
    running_total <- sum( unlist(values) )
    keyval(key, running_total)
}

# equivalent to hadoop dfs -copyFromLocal
hdfs.put(input.file.local, input.file.hdfs)

# rmr.results will just be a string containing the output dirname on hdfs
rmr.results <- mapreduce(
    map=mapper, reduce=reducer,
    input=input.file.hdfs, input.format = "text",
    output=output.dir.hdfs,
    combine=T,
    backend.parameters=list("mapred.reduce.tasks=2"))

# results on HDFS are in RHadoop object binary format, NOT ASCII, and must be
# read using from.dfs().  results becomes a list of two-item lists (key,val)
results <- from.dfs(rmr.results)

# the data.frame() below converts list of (key,val) to a list of keys and
# a list of vals, then dumps these into a file with tab delimitation
write.table( data.frame(words=unlist(lapply(X=results,FUN="[[",1)), 
                        count=unlist(lapply(X=results,FUN="[[",2))), 
             file=output.file.local,
             quote=FALSE, 
             row.names=FALSE, 
             col.names=FALSE,
             sep="\t"
             )
