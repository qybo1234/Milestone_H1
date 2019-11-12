#!/bin/bash

# Absolute path to the dataspaces root directory
DIR=/home1/yq47/dataspaces

# Submit DataSpaces server job
echo "Submit DataSpaces server ..."
sbatch $DIR/tests/C/H1_MS_server.sh

echo "Waiting to submit client jobs in 5 sec ..."
sleep 5

# Submit DataSpaces client job
echo "Submit DataSpaces clients ..."
sbatch $DIR/tests/C/H1_MS_client.sh

echo "Please wait a moment and check the server.log, writer.log, and reader.log"
