# DataSpaces Milestone H.1. 

## Goal

Be able to run the server in one job, and run clients on a different job. Confirm this works today on all systems using TCP, and on verbs systems. Development work is required for Aries systems.



## Script

### Description

1. H1_MS_main.sh

This script controls the DataSpaces server and clients running order by submitting them in sequence. It measures the job waiting time in the job queue.

2. H1_MS_server.sh

This script initiates the DataSpaces server and waiting for clients to join. 

3. H1_MS_client.sh

This script initiate the DataSpaces clients.

### Configuration

#### Load modules

```bash
###################################
# Environment configurations	  #
###################################
module load openmpi
```



#### Configure DataSpaces

Specify the absolute path to your DataSpaces root directory. Put the same configurations in the ``H1_MS_server.sh`` and ``H1_MS_client.sh``.

```bash
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
```



### Configure SLURM

Specify your SLURM configuration on both ``H1_MS_server.sh`` and ``H1_MS_client.sh``.

```bash
#SBATCH -J H1_Server
#SBATCH -o H1_Server.%J.stdout
#SBATCH -e H1_Server.%J.stderr
#SBATCH -t 00:05:00
#SBATCH -p caper
#SBATCH -N 1
#SBATCH -n 16
```

If your system does not use SLURM, please modify it accordingly.



## Testing plan

1. Systems
   1. CAPER
   2. Amarel
   3. Cori
2. Network
   1. TCP
   2. Inifiniband





