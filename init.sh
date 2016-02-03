#!/bin/sh 
DEMO="OpenShift Origin Demo"
AUTHORS="Eric D. Schabell"
PROJECT="git@github.com:eschabell/openshift-origin-demo.git"
PRODUCT="OpenShift Origin Image"
ORIGIN_HOME=./target
SRC_DIR=./installs
SUPPORT_DIR=./support
PRJ_DIR=./projects
ORIGIN_IMAGE=openshift3-1.1.1.box
VAGRANT_FILE=Vagrantfile
OC_LINUX=openshift-origin-client-tools-v1.1.1-e1d9873-linux-64bit.tar.gz
OC_MAC=openshift-origin-client-tools-v1.1.1-e1d9873-mac.zip
VERSION=1.1.1

# wipe screen.
clear 

echo
echo "###############################################################"
echo "##                                                           ##"   
echo "##  Setting up the ${DEMO}                     ##"
echo "##                                                           ##"   
echo "##                                                           ##"   
echo "##    ###  ####  ##### #   #  #### #   # ##### ##### #####   ##"
echo "##   #   # #   # #     ##  # #     #   #   #   #       #     ##"
echo "##   #   # ####  ###   # # #  ###  #####   #   ###     #     ##"
echo "##   #   # #     #     #  ##     # #   #   #   #       #     ##"
echo "##    ###  #     ####  #   # ####  #   # ##### #       #     ##"
echo "##                                                           ##"   
echo "##                                                           ##"   
echo "##  brought to you by, ${AUTHORS}                      ##"
echo "##                                                           ##"   
echo "##  ${PROJECT}       ##"
echo "##                                                           ##"   
echo "###############################################################"
echo

command -v vagrant -v >/dev/null 2>&1 || { echo >&2 "Vagrant is required but not installed yet... download here: https://www.vagrantup.com/downloads.html"; exit 1; }
echo "Vagrant is installed..."
echo 

command -v VirtualBox -h >/dev/null 2>&1 || { echo >&2 "VirtualBox is required but not installed yet... downlaod here: https://www.virtualbox.org/wiki/Downloads"; exit 1; }
echo "VirtualBox is installed..."
echo

# make some checks first before proceeding.	
if [ -r $SRC_DIR/$ORIGIN_IMAGE ] || [ -L $SRC_DIR/$ORIGIN_IMAGE ]; then
	echo Product image is present...
	echo
else
	echo Need to download $ORIGIN_IMAGE package from the OpenShift Origin 
	echo site at:
	echo
	echo       https://www.openshift.org/vm
	echo
	echo and place it in the $SRC_DIR directory 
	echo
	exit
fi

# Remove the old insallation, if it exists.
if [ -x $ORIGIN_HOME ]; then
	echo "  - removing existing installation..."
	echo
	rm -rf $ORIGIN_HOME
fi

# Run installation.
echo "Setting up installation now..."
echo
mkdir $ORIGIN_HOME

echo "Install source image (be patient, big file!) now..."
echo
echo "  ...be patient, it's a big file to copy!"
echo
cp $SRC_DIR/$ORIGIN_IMAGE $ORIGIN_HOME

echo "Install vagrant file now..."
echo
cp $SUPPORT_DIR/$VAGRANT_FILE $ORIGIN_HOME

echo "Setting up OpenShift commandline tools..."
mkdir $ORIGIN_HOME/bin

if [[ `uname` == 'Darwin' ]]; then
	unzip -q $SUPPORT_DIR/$OC_MAC -d $ORIGIN_HOME/bin
else 
  tar -zvf $SUPPORT_DIR/$OC_LINUX -d $ORIGN_HOME/bin
fi

echo
echo "Start image from $ORIGIN_HOME with: "
echo
echo "  $ vagrant up"
echo
echo "Login to OpenShift setup at: "
echo
echo "   http://localhost:8443"
echo
echo "$DEMO Setup Complete."
echo

