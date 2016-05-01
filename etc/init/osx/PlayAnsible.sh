#!/bin/bash

PROVISIONING_HOME=$(cd $(dirname $0) && pwd)
ANSIBLE_VERSION_MAJOR=$(echo $(ansible --version) | sed -E "s/.*[^0-9]([0-9]+\.[0-9]+\.[0-9]+).*/\1/g" | cut -d"." -f1)

cd ${PROVISIONING_HOME}/ansible > /dev/null 2>&1

# Ansible playbook
ansible-playbook playbook.yml -i hosts

# Ansible playbook_defaults 
if [ $ANSIBLE_VERSION_MAJOR -eq 1 ]; then
	DEFAULTS_PLAYBOOK=playbook_defaults_v1.yml
else
	DEFAULTS_PLAYBOOK=playbook_defaults.yml
fi

echo "Doing playbook is ${DEFAULTS_PLAYBOOK}, which is depending ansible version"
# ansible-playbook ${DEFAULTS_PLAYBOOK} -i hosts

osascript -e 'display notification "Successfull prease restart or re-login" with title "osx-provisioning"'
