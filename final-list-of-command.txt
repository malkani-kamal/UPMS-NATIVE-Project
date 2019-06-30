./bin/cryptogen generate --config=./crypto-config.yaml
mkdir channel-artifacts


export FABRIC_CFG_PATH=$PWD
./bin/configtxgen -profile UPMOrgOrdererGenesis -outputBlock ./channel-artifacts/genesis.block

export CHANNEL_NAME=UPMOrgChannel
./bin/configtxgen -profile UPMOrgChannel -outputCreateChannelTx ./channel-artifacts/upmorgschannel.tx -channelID $CHANNEL_NAME
./bin/configtxgen -profile UPMOrgChannel -outputAnchorPeersUpdate ./channel-artifacts/upmmspanchors.tx -channelID $CHANNEL_NAME -asOrg upmmsp
./bin/configtxgen -profile UPMOrgChannel -outputAnchorPeersUpdate ./channel-artifacts/dhlmspanchors.tx -channelID $CHANNEL_NAME -asOrg dhlmsp
./bin/configtxgen -profile UPMOrgChannel -outputAnchorPeersUpdate ./channel-artifacts/finportmspanchors.tx -channelID $CHANNEL_NAME -asOrg finportmsp

mv crypto-config channel-artifacts/
OR

cp -r crypto-config ./channel-artifacts/

export home_directory=/home/malkakam/hyperledger/UPMS/

cp /etc/hosts $home_directory/channel-artifacts/

cp /etc/resolv.conf $home_directory/channel-artifacts/

 



docker-compose up -d
docker ps -a

---------------
docker kill $(docker ps -q)
docker rm $(docker ps -a -q)



docker exec -it cli bash



CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/crypto-config/peerOrganizations/upm.tietonetworks.com/users/Admin@upm.tietonetworks.com/msp
CORE_PEER_LOCALMSPID="upmmsp"
CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/crypto-config/peerOrganizations/upm.tietonetworks.com/tlsca/ca.crt
CORE_PEER_TLS_ENABLED=false
CORE_PEER_ADDRESS=peer0.upm.tietonetworks.com:7051
CORE_PEER_CHAINCODELISTENADDRESS=peer0.upm.tietonetworks.com:7052

export CHANNEL_NAME=UPMOrgChannel
export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/crypto-config/ordererOrganizations/tietonetworks.com/orderers/orderer.tietonetworks.com/msp/tlscacerts/tlsca.tietonetworks.com-cert.pem


peer channel create -c $CHANNEL_NAME -f ./channel-artifacts/upmorgschannel.tx -o orderer.tietonetworks.com:7050 --cafile $ORDERER_CA


**********************trafigura joining publicchannel*****************

peer channel join -b $CHANNEL_NAME.block

peer chaincode install -n sample1 -v 2 -p chaincodedev/chaincode/letterofcredit/letterofcredit

cd chaincodedev/chaincode/letterofcredit/letterofcredit

peer chaincode instantiate -o orderer.tietonetworks.com:7050 --cafile $ORDERER_CA -C upmorgschannel -n sample1 -v 2 -c '{"Args":[]}'

peer chaincode invoke -C upmorgschannel -n sample1 -c '{"Args":["createconsignment","1","U01","C01","new","Mumbai","10","Iran"]}'

peer chaincode instantiate -o orderer.tietonetworks.com:7050 --cafile $ORDERER_CA -C upmorgschannel -n sample1 -v 2 -c '{"Args":["1","U01","C01","new","Mumbai","10","Iran"]}'

CORE_PEER_ADDRESS=peer0:7051 peer chaincode instantiate -C upmorgschannel -n sample1 -p chaincodedev/chaincode/letterofcredit/letterofcredit -v 2 -c '{"Args":["1","U01","C01","new","Mumbai","10","Iran"]}'

CORE_PEER_ADDRESS=peer0:7051 peer chaincode instantiate -C upmorgschannel -n sample1 -v 2 -c '{"Args":["1","U01","C01","new","Mumbai","10","Iran"]}'

CORE_PEER_ADDRESS=peer0:7051 peer chaincode instantiate -C upmorgschannel -n sample1 -v 2 -c '{"Args":[]}'



curl -s -X POST \
  http://localhost:4000/fabric/chaincodes/invoke/createconsignment \
-H "content-type: application/json" \
  -d '{
"channelName":"upmorgschannel","peerKey":"peer0","chaincodeVersion":"2","peerOrgId":"upm","chaincodeName":"sample1","initFuncArgs":["1","U01","C01","new","Mumbai","10","Iran"]
}'
 
https://chainhero.io/2018/03/tutorial-build-blockchain-app-2/

https://books.google.co.in/books?id=wKdhDwAAQBAJ&pg=PA175&lpg=PA175&dq=how+to+call+hyperledger+go+chaincode+function+using+curl&source=bl&ots=5hGjE5jms0&sig=38kipX1GmgIgSaI5LR6UFVKyb3Q&hl=en&sa=X&ved=2ahUKEwiz7JiL0OXcAhUbXSsKHbHpBDo4ChDoATAHegQIAxAB#v=onepage&q=how%20to%20call%20hyperledger%20go%20chaincode%20function%20using%20curl&f=false


 
curl -s -X POST \
  http://localhost:4000/fabric/chaincodes/invoke/query \
-H "content-type: application/json" \
  -d '{
"channelName":"publicchannel","peerKey":"peer1","chaincodeVersion":"v1","peerOrgId":"upm","chaincodeName":"sample1","initFuncArgs":["b"]
}'




https://www.youtube.com/watch?v=SXTAVFM2liU
https://www.youtube.com/watch?v=itn2Ps8sarE
https://www.youtube.com/watch?v=76WIJjKNekY&index=2&list=PLz3iwtnWFin-yUUgn-zP7KJp0iW0IFas9

https://openblockchain.readthedocs.io/en/latest/Setup/NodeSDK-setup/#getting-started

peer chaincode instantiate -o orderer.example.com:7050 --cafile $ORDERER_CA -C publicchannel -n sample1 -v 1.0 -c '{"Args":[]}'

docker network create --attachable=true --driver=overlay tieto-networks




**********************trafigura joined publicchannel*****************


curl -s -X POST \
  http://localhost:4000/fabric/chaincodes/invoke/move \
-H "content-type: application/json" \
  -d '{
"channelName":"upmorgschannel","peerKey":"peer1","chaincodeVersion":"v1","peerOrgId":"upm","chaincodeName":"sample1","initFuncArgs":["a","b","10"]
}'

















export CHANNEL_NAME=upmorgschannel

CHANNEL_NAME=$CHANNEL_NAME TIMEOUT=10000 docker-compose -f docker-compose.yaml up -d

docker exec -it 2a28fb0f781c bash

export CHANNEL_NAME=UPMOrgsChannel

export CHANNEL_NAME=UPMOrgsChannel


export FABRIC_CFG_PATH=/opt/gopath/src/github.com/hyperledger/fabric/

peer channel create -o orderer.tietonetworks.com:7050 -c UPMOrgsChannel -f ./channel-artifacts/UPMOrgsChannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/crypto-config/ordererOrganizations/tietonetworks.com/msp/tlscacerts/tlsca.tietonetworks.com-cert.pem

./bin/configtxgen -profile publicchannel -outputCreateChannelTx ./channel-artifacts/publicchannel.tx -channelID $CHANNEL_NAME   



opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/tietonetworks.com/msp/tlscacerts/tlsca.tietonetworks.com-cert.pem

peer channel create -o Orderer.tietonetworks.com:7050 -c UPMOrgsChannel -f ./channel-artifacts/UPMOrgsChannel.tx --tls --cafile opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/crypto-config/ordererOrganizations/tietonetworks.com/msp/tlscacerts/tlsca.tietonetworks.com-cert.pem


CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/upm.example.com/users/Admin@upm.example.com/msp

CORE_PEER_LOCALMSPID="upmMSP"

CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/upm.example.com/peers/peer0.upm.example.com/tls/ca.crt

CORE_PEER_TLS_ENABLED=false

CORE_PEER_ADDRESS=peer0.upm.example.com:7051

export CHANNEL_NAME=publicchannel

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel create -c $CHANNEL_NAME -f ./channel-artifacts/publicchannel.tx -o orderer.example.com:7050 --cafile $ORDERER_CA




https://www.sslshopper.com/certificate-decoder.html

https://medium.com/swlh/hyperledger-chapter-8-what-is-hyperledger-fabric-chaincode-a74778dff2ae

https://fabric-sdk-node.github.io/tutorial-network-config.html


 che
peer-chaincodedev=true