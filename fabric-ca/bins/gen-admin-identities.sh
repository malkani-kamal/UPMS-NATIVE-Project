# CA Registrar is already registered & enrolled
# Registers the 3 Org admins for upm Case Study
# upm-admin, dhl-admin, orderer-admin

# Registers the admins
function registerAdmins {
    # 1. Set the CA Server Admin as FABRIC_CA_CLIENT_HOME
    #    This the Registrar identity
    source set-client-home.sh   caserver   admin

    # 2. Register orderer-admin
    echo "Registering: orderer-admin"
    ATTRIBUTES='"hf.Registrar.Roles=orderer,user,client"'
    fabric-ca-client register --id.type client --id.name orderer-admin --id.secret pw --id.affiliation orderer --id.attrs $ATTRIBUTES
    
    # 3. Register upm-admin
    echo "Registering: upm-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    fabric-ca-client register --id.type client --id.name upm-admin --id.secret pw --id.affiliation upm --id.attrs $ATTRIBUTES

    # 4. Register dhl-admin
    echo "Registering: dhl-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    fabric-ca-client register --id.type client --id.name dhl-admin --id.secret pw --id.affiliation dhl --id.attrs $ATTRIBUTES
    
    ### Additional Organizations may be added here ###
}

# Setup MSP
function setupMSP {
    mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts

    echo "====> $FABRIC_CA_CLIENT_HOME/msp/admincerts"
    cp $FABRIC_CA_CLIENT_HOME/../../caserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts
}

# Enroll admin
function enrollAdmins {

    # 1. orderer-admin
    echo "Enrolling: orderer-admin"

    export ORG_NAME="orderer"
    source set-client-home.sh   $ORG_NAME   admin
    # Enroll the admin identity
    fabric-ca-client enroll -u http://orderer-admin:pw@localhost:7054
    # Setup the MSP for the orderer
    setupMSP


    # 2. upm-admin
    echo "Enrolling: upm-admin"

    export ORG_NAME="upm"
    source set-client-home.sh   $ORG_NAME   admin
    # Enroll the admin identity
    fabric-ca-client enroll -u http://upm-admin:pw@localhost:7054
    # Setup the MSP for upm
    setupMSP

    # 3. dhl-admin
    echo "Enrolling: dhl-admin"

    export ORG_NAME="dhl"
    source set-client-home.sh   $ORG_NAME   admin
    # Enroll the admin identity
    fabric-ca-client enroll -u http://dhl-admin:pw@localhost:7054
    # Setup the MSP for dhl
    setupMSP

    ### Additional Organizations may be added here ###

}

echo "========= Registering ==============="
#1. CA Registrar will register the Org Admins
registerAdmins

echo "========= Enrolling ==============="
#2. Each Org Admin will then enroll & get the certs
enrollAdmins

echo "==================================="