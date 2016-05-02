#!/bin/bash

# Include
. ~/dotfiles/etc/init/get_os.sh
DOTPATH=~/dotfiles

get_os
bash "$DOTPATH"/etc/init/"$PLATFORM"/01_install.sh