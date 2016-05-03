# PATH
export PATH=/usr/local:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export LANG=en_EN.UTF-8
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
export ANSIBLE_CONFIG="~/.ansible.cfg"
export EDITOR=vim

# Setting
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

## History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Option
setopt no_beep
setopt print_eight_bit
setopt auto_cd
setopt interactive_comments
setopt share_history
setopt extended_glob
setopt print_eight_bit
setopt interactive_comments
setopt ignore_eof
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extended_glob

bindkey '^R' history-incremental-pattern-search-backward

# Color
autoload -Uz colors
colors
PROMPT="%{${fg[green]}%}[%n]%{${reset_color}%} %~%# "

# Alias
alias vim="env LANG=ja_JP.UTF-8 $EDITOR -u $HOME/.vimrc"
alias vi=vim
alias view='vim -R'

alias l="ls -alt"  
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# alias ls='gls --color=auto'

# Anyenv
if [ -d ${HOME}/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    for D in 'ls $HOME/.anyenv/envs'
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done

fi

#
# tmux
#

function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
