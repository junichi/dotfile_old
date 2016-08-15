#!/bin/bash

###########################################################
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi
###########################################################

git clone https://github.com/riywo/anyenv ~/.anyenv