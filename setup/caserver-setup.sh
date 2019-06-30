# setting up go the Fabric CA Binaries
if [ -z $SUDO_USER ]
then
    echo "===== Script need to be executed with after sudo -s ===="
    echo "Change directory to 'setup'"
    echo "Usage: sudo ./caserver.sh"
    exit 0
fi

echo "=======Installing up go======"
sudo apt-get update
sudo apt-get -y install golang-1.10-go

# Setup the Gopath & Path
mkdir -p $PWD/../misc/gopath
export GOPATH=$PWD/../misc/gopath
export PATH=$PATH:/usr/lib/go-1.10/bin

# Get the Fabric CA binaries
# Check install section in below mentioned URL.
# https://hyperledger-fabric-ca.readthedocs.io/en/latest/users-guide.html

echo "The following installs both the fabric-ca-server and fabric-ca-client binaries in GOPATH/bin."
go get -u github.com/hyperledger/fabric-ca/cmd/...

# Move the binaries
echo "Arranging Fabric CA Binaries for the project"
sudo rm /usr/local/fabric-ca-*  2> /dev/null
sudo cp $GOPATH/bin/* $PWD/../bin
sudo mv $GOPATH/bin/*    /usr/local/bin

echo "Done."
echo "Validate by running>>   fabric-ca-server   version"


