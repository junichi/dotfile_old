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


#############################################################
										
