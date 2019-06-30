# The fabric-ca-server must have launched with removal enabled
export FABRIC_CA_CLIENT_HOME=$PWD/../client/orderer/admin

# Execute the identity remove command
fabric-ca-client identity remove orderer