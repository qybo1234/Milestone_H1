#!/bin/bash

# Absolute path to the dataspaces root directory
DIR=/home1/yq47/dataspaces

#Get server job submition timestamp
start_ts_server=$(date +%s)

# Submit DataSpaces server job
echo "Submit DataSpaces server ..."
sbatch $DIR/tests/C/H1_MS_server.sh

echo "Waiting to DataSpaces server job to launch ..."

while [ ! -f dataspaces.conf ]; do
    sleep 1s
done

end_ts_server=$(date +%s)
echo "DataSpaces server launched after waiting $((end_ts_server - start_ts_server)) sec"

# Submit DataSpaces client job
echo "Submit DataSpaces clients ..."
start_ts_client=$(date +%s)
sbatch $DIR/tests/C/H1_MS_client.sh

while [ ! -f writer.log ]; do
    sleep 1s
done
end_ts_client=$(date +%s)
echo "DataSpaces clients launched after waiting $((end_ts_client - start_ts_client)) sec"
echo "Please wait a moment and check the server.log, writer.log, and reader.log!"
