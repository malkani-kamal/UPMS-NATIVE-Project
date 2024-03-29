# Sets up the identities to be used by the multi-org setup
# Same identities may be used for the single-org setup
#
# PS:
# Execution of this script overwrites the crypto generated
# in the earlier runs. All precviously generated network config 
# artifacts will become invalid.


# Init the CA Sever
echo  "Starting Fabric CA Initialization"
./init-fabric-ca.sh


# Start the CA server
echo  "Starting CA Server - Sleeping for 3 sec"
./start-caserver.sh  &


# Wait for the server to start
sleep  3s

# Set up the admin identities
echo  "Creating the Admin identites for the orgs"
./gen-admin-identities.sh

# Set up the ORG MSP
echo  "Setting up the organization MSP(s)"
./create-org-msp.sh

# Setup the Orderer identity
echo  "Creating the Orderer Identity"
./gen-orderer-identity.sh

# Setup the peer identites
echo  "Creating the 3 Peer Identities"
./gen-peer-identity.sh upm upm-peer1
./gen-peer-identity.sh upm upm-peer2
./gen-peer-identity.sh dhl dhl-peer1

# Kill the CA Server process as it is not needed
# Comment the next line if you would like to keep it running
killall fabric-ca-server  &> /dev/null

# Done
echo  "DONE. Start CA Server using ./start-caserver.sh"
echo  "PS: Ignore the termination message, its expected as we are killing the process :)"