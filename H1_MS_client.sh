#!/bin/bash
#SBATCH -J H1_Client
#SBATCH -o H1_Client.%J.stdout
#SBATCH -e H1_Client.%J.stderr
#SBATCH -t 00:05:00
#SBATCH -p main # For Amarel
#SBATCH -N 1
#SBATCH -n 10

###################################
# Environment configurations	  #
###################################
module load openmpi

###################################
# DataSpaces configurations		  #
###################################

# Absolute path to the dataspaces root directory
# DIR=/home1/yq47/DataSpaces #For Amaral
DIR=

# 2-dimension bounding box
CONF_DIMS_1=128
CONF_DIMS_2=128

# Server and client ranks
NUM_SERVER=1
NUM_WRITER=4
NUM_READER=4


echo "Start clients ..."
mpirun -n $NUM_WRITER $DIR/tests/C/test_writer DATASPACES $NUM_WRITER 2 $NUM_WRITER 1 $(($CONF_DIMS_1/$NUM_WRITER)) $CONF_DIMS_2 2 1 &>> writer.log &
mpirun -n $NUM_READER $DIR/tests/C/test_reader DATASPACES $NUM_READER 2 $NUM_READER 1 $(($CONF_DIMS_1/$NUM_READER)) $CONF_DIMS_2 2 2 &>> reader.log &
echo "Clients are running at ${HOSTNAME} ..."

echo "Clients completed!"
wait