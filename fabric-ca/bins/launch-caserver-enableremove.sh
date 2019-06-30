# Launches the CA server
export FABRIC_CA_SERVER_HOME=$PWD/../server

fabric-ca-server start -n ca.server.com  --cfg.identities.allowremove

