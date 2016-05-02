#!/bin/bash

# Include
. ~/dotfiles/etc/init/get_os.sh
get_os

echo zsh.sh

if ! which zsh > /dev/null; then
	# Install zsh
    case "$PLATFORM" in
        # Case of OS X
        osx)
            if which brew > /dev/null; then
                echo "Install zsh with Homebrew"
                brew install zsh
            elif which port > /dev/null; then
                echo "Install zsh with MacPorts"
                sudo port install zsh-devel
            else
                echo "error: require: Homebrew or MacPorts"
                exit 1
            fi
            ;;

        # Case of Linux
        linux)
            if which yum > /dev/null; then
                echo "Install zsh with Yellowdog Updater Modified"
                sudo yum -y install zsh
            elif which brew apt-get > /dev/null; then
                echo "Install zsh with Advanced Packaging Tool"
                sudo apt-get -y install zsh
            else
                echo "error: require: YUM or APT"
                exit 1
            fi
            ;;

        # Other platforms such as BSD are supported
        *)
            echo "error: this script is only supported osx and linux"
            exit 1
            ;;
    esac
fi

# Run the forced termination with a last exit code
exit $?

# Assign zsh as a login shell
if ! contains "${SHELL:-}" "zsh"; then
    zsh_path="$(which zsh)"

    # Check /etc/shells
    if ! grep -xq "${zsh_path:=/bin/zsh}" /etc/shells; then
        echo "oh, you should append '$zsh_path' to /etc/shells"
        exit 1
    fi

    if [ -x "$zsh_path" ]; then
        # Changing for a general user
        if chsh -s "$zsh_path" "${USER:-root}"; then
            echo "Change shell to $zsh_path for ${USER:-root} successfully"
        else
            echo "cannot set '$path' as \$SHELL"
            echo "Is '$path' described in /etc/shells?"
            echo "you should run 'chsh -l' now"
            exit 1
        fi

        # For root user
        if [ ${EUID:-${UID}} = 0 ]; then
            if chsh -s "$zsh_path" && :; then
                echo "[root] change shell to $zsh_path successfully"
            fi
        fi
    else
        echo "$zsh_path: invalid path"
        exit 1
    fi
fi