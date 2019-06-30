# Used for generation of he genesis block and the airline channel tx file
export FABRIC_CFG_PATH=../../config

# Genesis block generation
configtxgen -profile TransportOrdererGenesis -outputBlock ../../artefacts/transport-genesis.block -channelID ordererchannel

# Airline channel creation
configtxgen -profile TransportChannel -outputCreateChannelTx ../../artefacts/transport-channel.tx -channelID transportchannel

