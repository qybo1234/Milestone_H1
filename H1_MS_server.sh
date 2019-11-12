#!/bin/bash
#SBATCH -J H1_Server
#SBATCH -o H1_Server.%J.stdout
#SBATCH -e H1_Server.%J.stderr
#SBATCH -t 00:05:00
#SBATCH -p caper
#SBATCH -N 1
#SBATCH -n 16

###################################
# Environment configurations	  #
###################################
module load openmpi


###################################
# DataSpaces configurations		  #
###################################

# Absolute path to the dataspaces root directory
DIR=/home1/yq47/dataspaces

# 2-dimension bounding box
CONF_DIMS_1=128
CONF_DIMS_2=128

# Server and client ranks
NUM_SERVER=1
NUM_WRITER=4
NUM_READER=4

# Create dataspaces.conf
rm -f conf cred dataspaces.conf srv.lck

echo "## Config file for DataSpaces
ndim = 2
dims = $CONF_DIMS_1, $CONF_DIMS_2

max_versions = 1
lock_type = 2
" > dataspaces.conf

###################################
# DataSpaces Server		  		  #
###################################

echo "Start server ..."
mpirun -n $NUM_SERVER $DIR/tests/C/dataspaces_server -s $NUM_SERVER -c $(($NUM_WRITER+$NUM_READER)) &>> server.log & sleep 2

echo "Server is running at ${HOSTNAME} ..."

# echo "Trigger the clients ..."
# bash $DIR/H1_MS_client.sh

echo "Server completed!"

wait