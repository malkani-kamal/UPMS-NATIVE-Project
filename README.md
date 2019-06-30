Project created by kamal malkani for the bigenners.
This project is running after native installation of docker, CA and peers on the ubuntu machine.
--------------------------------------------------------------------------------------------- 
Setting up
1. ./setup/caserver-setup.sh
2. ./setup/docker-setup.sh
3. ./setup/go-setup.sh

There are bin subfolder in fabric-ca, orderer, peers folders.  There is a file run-<peers/orderer/ca>-1-go.sh which should be run in below sequence.

1.run-caserver-1-go
2.run-orderer-1-go
3.run-peer-1-go

