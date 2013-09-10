#!/usr/bin/env Rscript

last_key <- ""
running_total <- 0

stdin <- file('stdin', open='r')
while ( length(line <- readLines(stdin, n=1)) > 0 ) {
    line <- gsub('(^\\s+)|(\\s+$)', '', line)
    keyvalue <- unlist(strsplit(line, split='\t', fixed=TRUE))
    this_key <- keyvalue[[1]]
    value <- as.numeric(keyvalue[[2]])

    if ( last_key == this_key ) {
        running_total <- running_total + value
    }
    else {
        if ( last_key != "" ) {
            cat( paste(last_key,'\t',running_total,'\n',sep='') )
        }
        running_total <- value
        last_key <- this_key
    }
}

if ( last_key == this_key ) {
            cat( paste(last_key,'\t',running_total,'\n',sep='') )
}
close(stdin)
