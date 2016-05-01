#!/bin/bash

# Include
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi

# Checking brew
if which brew > /dev/null; then
	echo "brew: already installed"
	exit
fi

# Checking ruby
if ! which ruby > /dev/null; then
	echo "error: Not found "ruby""
	exit 1
fi

# Install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Checking brew
if which brew > /dev/null; then
	brew doctor
else
	echo "error: failed to install brew"
	exit 1
fi

echo "brew: installed successfully"
