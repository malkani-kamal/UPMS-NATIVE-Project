# Restarts orderer in background in clean state in one go

echo "+++Cleaning the previous run"
./clean.sh

echo "++Generating the network configuration"
./gen-config.sh

echo "+Starting orderer in the background"
./start-orderer.sh &

echo "Done. Orderer started in a clean state. Check logs at orderer/orderer.log"