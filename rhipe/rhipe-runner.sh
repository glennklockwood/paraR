#!/bin/bash
#
#  Runner script for Rhipe 0.73 for use on SDSC Gordon using Glenn K. Lockwood's
#  special R installation.  August 2013
#

source /etc/profile.d/modules.sh
export MODULEPATH=/home/glock/gordon/modulefiles:$MODULEPATH

module swap mvapich2_ib openmpi_ib
module load R/3.0.1-gkl protobuf
export OMP_NUM_THREADS=1

export PATH=/home/glock/gordon/R/lib64/R/library/Rhipe/bin:/home/glock/gordon/R/bin:$PATH
export LD_LIBRARY_PATH=/usr/java/jdk1.7.0_13/jre/lib/amd64/server:/home/glock/gordon/R/lib64/R/library/rJava/libs:/home/glock/gordon/R/lib:/home/glock/gordon/R/lib64/R/library/Rcpp/lib:$LD_LIBRARY_PATH

R CMD RhipeMapReduce --slave --silent --vanilla
