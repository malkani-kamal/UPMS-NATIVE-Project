# Cleaning of the server & client folders under fabric-ca folder

killall fabric-ca-server  2> /dev/null

# Remove all server artefacts
rm -rf ../server/*  2> /dev/null
# Remove all identity MSP
rm -rf ../client/*   2> /dev/null

echo "Killed Fabric CA Server & Removed identities!!!"