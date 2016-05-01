#!/bin/bash

# Include
DOTPATH=~/dotfiles
. ~/dotfiles/etc/init/get_os.sh

get_os

bash "$DOTPATH"/etc/init/"$PLATFORM"/install.sh