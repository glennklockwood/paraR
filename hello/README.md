Parallel Hello World in R
=========================
These are various 'hello world' scripts written in R to verify the installation
of the basic parallel libraries and the job submission process on both of the
XSEDE resources at SDSC, Gordon and Trestles.

All of these applications print some unique parallel worker id (e.g., MPI rank
for distributed memory or process id for shared memory) and the hostname on 
which that worker is running.

Hello World Scripts
-------------------
* hello-foreach-serial.R - foreach with serial backend
* hello-foreach-doMC.R - foreach with multicore (single-node) backend
* hello-foreach-doSNOW.R - foreach with snow (multinode) backend
* hello-foreach-doMPI.R - foreach with raw MPI (multinode) backend
* hello-lapply.R - serial lapply
* hello-mclapply.R - lapply with multicore/parallel's mclapply (single-node)
* hello-parLapply.R - lapply with snow's parLapply (multinode)
* hello-clusterApply.R - lapply with snow's clusterApply (multinode)
* hello-sfClusterApply.R  - lapply with snowfall's sfClusterApply (multinode)

Submit Scripts
--------------
* submit-singlenode-gordon.qsub - submit script for serial and doMC scripts
* submit-multinode-gordon.qsub - submit script for snow, snowfall, doMPI scripts
* submit-singlenode-trestles.qsub - submit script for serial and doMC scripts
* submit-multinode-trestles.qsub - submit script for snow, snowfall, doMPI
