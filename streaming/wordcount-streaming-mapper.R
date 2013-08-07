#!/usr/bin/env Rscript

emit.keyval = function(key, value) {
    cat(key,'\t',value,'\n',sep='')
}

stdin <- file('stdin', open='r')
while ( length(line <- readLines(stdin, n=1)) > 0 ) {
    line <- gsub('(^\\s+|\\s+$)', '', line)
    keys <- unlist(strsplit(line, split='\\s+'))
    value <- 1
    lapply(keys, FUN=emit.keyval, value=value)
}
close(stdin)

