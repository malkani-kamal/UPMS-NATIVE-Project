# Gives a clean start to 3 peers
# Execute orderer/bins/clean-start-orderer.sh before this script

# Clean peers
echo "++++++ Cleaning the previous run"
./clean.sh

# As Upm admin create the channel by submitting the transaction
echo "+++++ Creating the application channel = airlinechannel"
. set-env.sh  upm  7050   admin
./create-channel.sh

# Give some time for the transaction to go through
echo "++++ Sleeping for 3 seconds"
sleep 3s

# Start the upm-peer1
echo "+++ upm-peer1 Starting & Joining airlinechannel - will sleep for 3 seconds"
. set-env.sh  upm  7050   admin
./start-peer.sh upm  7050   upm-peer1
sleep 3s
./join-channel.sh

# Start the upm-peer2
echo "++ upm-peer2 Starting & Joining airlinechannel - will sleep for 3 seconds"
. set-env.sh  upm  8050   upm
./start-peer.sh upm  8050   upm-peer2
sleep 3s
./join-channel.sh

# Start the dhl-peer1
echo "+ dhl-peer1 Starting & Joining airlinechannel - will sleep for 3 seconds"
. set-env.sh  dhl  9050   admin
./start-peer.sh dhl  9050   dhl-peer1
sleep 3s
./join-channel.sh

echo "Done. All 3 peers started in background. Please check peer logs at /peers"
