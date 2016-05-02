#!/bin/bash

OSX_HOME=$(cd $(dirname $0) && pwd)

bash "$OSX_HOME"/InstallXcode.sh
bash "$OSX_HOME"/InstallBrew.sh
bash "$OSX_HOME"/InstallAnsible.sh
bash "$OSX_HOME"/PlayAnsible.sh
bash "$OSX_HOME"/zsh.sh


osascript -e 'display notification "Successfull please restart or re-login" with title "osx-provisioning"'
