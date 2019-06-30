export FABRIC_LOGGING_SPEC=INFO

# Location of the orderer.yaml file
export FABRIC_CFG_PATH=$PWD/..

# This is the location where orderer writes
export ORDERER_FILELEDGER_LOCATION=$HOME/orderer/ledger

#### You may override other runtime parameters defined in orderer.yaml ###

orderer  2> ../orderer.log

