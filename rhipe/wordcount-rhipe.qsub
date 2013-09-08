#!/bin/bash
################################################################################
#
#  Job script to spin up a semi-persistent Hadoop cluster on XSEDE/SDSC Gordon
#
#  Glenn K. Lockwood, San Diego Supercomputer Center                 August 2013
#
################################################################################
#PBS -N hadoopcluster
#PBS -q normal
#PBS -l nodes=2:ppn=1:native
#PBS -l walltime=00:15:00
#PBS -m bae
#PBS -j oe
#PBS -o hadoopcluster.log
#PBS -v Catalina_maxhops=None
 
cd $PBS_O_WORKDIR
 
export MY_HADOOP_HOME="/opt/hadoop/contrib/myHadoop"

export HADOOP_CONF_DIR=$PBS_O_WORKDIR/$PBS_JOBID

### Gordon: need to build setenv.sh from hardcoded values in configure.sh
TMPFILE=$(mktemp)
grep '^export' $MY_HADOOP_HOME/bin/configure.sh > $TMPFILE
source $TMPFILE && rm $TMPFILE

### Gordon: Enable Hadoop over Infiniband (add ".ibnet0" suffix to hostnames)
export PBS_NODEFILEZ=$(mktemp)
sed -e 's/$/.ibnet0/g' $PBS_NODEFILE > $PBS_NODEFILEZ

$MY_HADOOP_HOME/bin/configure.sh -n 2 -c $HADOOP_CONF_DIR || exit 1

### Gordon: myHadoop template environment has dummy vars that must be replaced
sed -i 's:^export HADOOP_PID_DIR=.*:export HADOOP_PID_DIR=/scratch/'$USER'/'$PBS_JOBID':' $HADOOP_CONF_DIR/hadoop-env.sh
sed -i 's:^export TMPDIR=.*:export TMPDIR=/scratch/'$USER'/'$PBS_JOBID':' $HADOOP_CONF_DIR/hadoop-env.sh

### Gordon: R environment variables
cat <<'EOF' >> $HADOOP_CONF_DIR/hadoop-env.sh
export PATH=/home/glock/gordon/R/bin:/opt/hadoop/bin:$PATH
export LD_LIBRARY_PATH=/home/glock/gordon/R/lib:/home/glock/gordon/R/lib64/R/library/Rcpp/lib:/usr/java/jdk1.6.0_26/jre/lib/amd64/server:/home/glock/gordon/R/lib64/R/library/rJava/libs:$LD_LIBRARY_PATH
export HADOOP_HOME=/opt/hadoop
export HADOOP_CONF=$HADOOP_CONF_DIR
EOF
### Specific for RHadoop/RHDFS
export HADOOP_CONF=$HADOOP_CONF_DIR
export PATH=/opt/hadoop/bin:$PATH

$HADOOP_HOME/bin/hadoop --config $HADOOP_CONF_DIR namenode -format
 
$HADOOP_HOME/bin/start-all.sh

### Necessary modules for Rhadoop and Rhipe
source /etc/profile.d/modules.sh
export MODULEPATH=/home/glock/gordon/modulefiles:$MODULEPATH
module swap mvapich2_ib openmpi_ib
module load R/3.0.1-gkl protobuf
### Rhipe 0.73 also implicitly needs hdfs:///tmp to exist for some reason(???)
$HADOOP_HOME/bin/hadoop dfs -mkdir /tmp

### insert job here ############################################################

R CMD BATCH ./wordcount-rhipe.R

################################################################################

$HADOOP_HOME/bin/stop-all.sh
cp -Lr $HADOOP_LOG_DIR $PBS_O_WORKDIR/hadoop-logs.$PBS_JOBID
$MY_HADOOP_HOME/bin/pbs-cleanup.sh -n 2
