#!/bin/bash

OSX_HOME=$(cd $(dirname $0) && pwd)

echo $OSX_HOME
bash "$OSX_HOME"/InstallXcode.sh
bash "$OSX_HOME"/InstallBrew.sh
bash "$OSX_HOME"/InstallAnsible.sh
bash "$OSX_HOME"/PlayAnsible.sh