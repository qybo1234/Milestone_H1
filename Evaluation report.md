#Evaluation report of the milestone H.1.

## DataSpaces configuration

Here takes CAPER as the demo system.



### Load module

```bash
module load openmpi
```



### Compile DataSpaces

1. TCP

```bash
./autogen.sh
./configure CC=mpicc FC=mpif90 --enable-dart-tcp LIBS="-lpthread -lm"
make
```

2. Infiniband

```bash
./autogen.sh
./configure CC=mpicc FC=mpif90 CFLAGS="-DHAVE_INFINIBAND -lrdmacm -std=gnu99" --with-ib-interface=ib0
make
```



## Script configuration

```bash
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
```



## Evaluation

### Run on CAPER with TCP configuration

Pass

1. DataSpaces output

```bash
[yq47@login2 C]$ cat *.log
TS= 1 TRANSPORT_TYPE= DATASPACES read MAX time= 0.040609
TS= 2 TRANSPORT_TYPE= DATASPACES read MAX time= 0.080348
test_get_run(): done
Kill Request Sent
Server received kill command. Going to shut down...
All ok.
TS= 1 TRANSPORT_TYPE= DATASPACES write MAX time= 0.000074
TS= 2 TRANSPORT_TYPE= DATASPACES write MAX time= 0.000032
test_put_run(): done
All complete
All complete
All complete
All complete
```

2. Script output

```bash
[yq47@login2 C]$ cat *.stdout
Start clients ...
Clients are running at caper-03 ...
Clients completed!
Start server ...
Server is running at caper-02 ...
Server completed!
```



### Result table

| System | TCP  | Infiniband |
| ------ | ---- | ---------- |
| CAPER  | Pass |            |
| Amarel |      |            |
| Cori   |      |            |

