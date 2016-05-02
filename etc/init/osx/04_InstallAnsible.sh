#!/bin/bash

###########################################################
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi
###########################################################

if ! which ansible > /dev/null; then
	echo "Not found ansible!"
    echo "Install ansible"
	brew install ansible
else
	echo "ansible: already installed"
	exit
fi