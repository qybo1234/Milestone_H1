#Evaluation report of the milestone H.1.

## DataSpaces configuration

Here takes CAPER as the demo system.



### Load module

```bash
module load openmpi
module load gcc
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
TS= 1 TRANSPORT_TYPE= DATASPACES read MAX time= 0.039918
TS= 2 TRANSPORT_TYPE= DATASPACES read MAX time= 0.080078
test_get_run(): done
Kill Request Sent
TS= 1 TRANSPORT_TYPE= DATASPACES write MAX time= 0.000091
TS= 2 TRANSPORT_TYPE= DATASPACES write MAX time= 0.000048
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
Clients are running at caper-06 ...
Clients completed!
Start server ...
Server is running at caper-05 ...
Server completed!
```

3. H1_MS_main output

```bash
yq47@login2 C]$ ./H1_MS_main.sh
Submit DataSpaces server ...
Submitted batch job 47
Waiting to DataSpaces server job to launch ...
DataSpaces server launched after waiting 0 sec
Submit DataSpaces clients ...
Submitted batch job 48
DataSpaces clients launched after waiting 15 sec
Please wait a moment and check the server.log, writer.log, and reader.log!
```



### Run on Amarel with TCP configuration

Pass

1. DataSpaces output

```bash
[yq47@amarel1 Milestone_H1]$ cat *.log
TS= 1 TRANSPORT_TYPE= DATASPACES read MAX time= 0.041539
TS= 2 TRANSPORT_TYPE= DATASPACES read MAX time= 0.041518
test_get_run(): done
Kill Request Sent
Server received kill command. Going to shut down...
All ok.
TS= 1 TRANSPORT_TYPE= DATASPACES write MAX time= 0.000100
TS= 2 TRANSPORT_TYPE= DATASPACES write MAX time= 0.000038
test_put_run(): done
All complete
All complete
All complete
All complete
```

2. Script output

```bash
[yq47@amarel1 Milestone_H1]$ cat *.stdout
Start clients ...
Clients are running at slepner045 ...
Clients completed!
Start server ...
Server is running at slepner011 ...
Server completed!
```

3. H1_MS_main output

```bash
[yq47@amarel1 Milestone_H1]$ ./H1_MS_main.sh
Submit DataSpaces server ...
Submitted batch job 68063427
Waiting to DataSpaces server job to launch ...
DataSpaces server launched after waiting 0 sec
Submit DataSpaces clients ...
Submitted batch job 68063428
DataSpaces clients launched after waiting 12 sec
Please wait a moment and check the server.log, writer.log, and reader.log!
```



### Run on Amarel with InfiniBand configuration

Pass

1. DataSpaces output

```bash
[yq47@amarel1 Milestone_H1]$ cat *.log
TS= 1 TRANSPORT_TYPE= DATASPACES read MAX time= 0.046463
TS= 2 TRANSPORT_TYPE= DATASPACES read MAX time= 0.049301
test_get_run(): done
Kill Request Sent
'ds_boot_master()': all the server are registered.9 8
'ds_alloc()': init ok.
Server received kill command. Going to shut down...
All ok.
TS= 1 TRANSPORT_TYPE= DATASPACES write MAX time= 0.011163
TS= 2 TRANSPORT_TYPE= DATASPACES write MAX time= 0.013848
test_put_run(): done
All complete
All complete
All complete
All complete
```

2. Script output

```bash
[yq47@amarel1 Milestone_H1]$ cat *.stdout
Start clients ...
Clients are running at slepner045 ...
Clients completed!
Start server ...
Server is running at slepner011 ...
Server completed!
```

3. H1_MS_main output

```bash
[yq47@amarel1 Milestone_H1]$ ./H1_MS_main.sh
Submit DataSpaces server ...
Submitted batch job 68063424
Waiting to DataSpaces server job to launch ...
DataSpaces server launched after waiting 17 sec
Submit DataSpaces clients ...
Submitted batch job 68063425
DataSpaces clients launched after waiting 30 sec
Please wait a moment and check the server.log, writer.log, and reader.log!
```



### Result table

| System | TCP  | Infiniband |
| ------ | ---- | ---------- |
| CAPER  | Pass |            |
| Amarel | Pass | Pass       |
| Cori   |      |            |

