#!/bin/bash

# Include
. ~/dotfiles/etc/init/get_os.sh

# This script is only supported with osx
if ! [[ "$PLATFORM" == "osx" ]]; then
    echo "error: this script is only supported with osx"
    exit 1
fi

###########################################################

PROVISIONING_HOME=$(cd $(dirname $0) && pwd)

cd ${PROVISIONING_HOME}/ansible > /dev/null 2>&1

# Ansible playbook
ansible-playbook playbook.yml -i hosts