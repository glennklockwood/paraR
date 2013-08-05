k-means Parallel R Examples
===========================

* BENCHMARKS - some very basic, unscientific performance measurements for these codes
* gen-data.R - script to generate the 'dataset.csv' required by all of these examples
* kmeans-serial.R - the simplest possible serial reference code
* kmeans-lapply.R - the serial implementation using lapply
* kmeans-mclapply.R - the shared-memory parallel version (parallel/multicore library)
* kmeans-ClusterApply.R - the distributed-memory parallel version (parallel/snow+Rmpi libraries)
* kmeans-foreach.R - the serial implementation using the foreach library
* kmeans-doMC.R - the shared-memory parallel version (foreach+doMC libraries)
* kmeans-doSNOW.R - the distributed-memory parallel version (foreach+doSNOW+Rmpi libraries)

These examples are distributed under a Creative Commons Attribution-NonCommercial-ShareAlike license.  See ../LICENSE for the full text.
