#!/bin/bash

###########################################################
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi
###########################################################

OSX_HOME=$(cd $(dirname $0) && pwd)

bash "$OSX_HOME"/*InstallXcode.sh
bash "$OSX_HOME"/*InstallBrew.sh
bash "$OSX_HOME"/*InstallAnsible.sh
bash "$OSX_HOME"/*PlayAnsible.sh
bash "$OSX_HOME"/*zsh.sh
bash "$OSX_HOME"/*defaults.sh

osascript -e 'display notification "Successfull please restart or re-login" with title "osx-provisioning"'
