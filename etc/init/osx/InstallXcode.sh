#!/bin/bash

# Include
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi

# Install xcode
if which xcode-select > /dev/null; then
	echo "xcode: already installed"
	exit
else
	xcode-select --install
fi