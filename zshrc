#!/bin/zsh

source /home/alnyan/.zsh/zsh-history-substring-search.sh
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

#### History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

#### Executables
export PATH="${PATH}:${HOME}/.local/bin"
export EDITOR=nvim
export MC_XDG_OPEN=/usr/bin/xdg-open

#### Style
export PROMPT="%n@%M %F{11}%~%f %# "
export RPROMPT="%(?..%F{9}%?%f)"

# Aliases
# General
alias ls="ls --color -lh"
alias grep="grep --color=auto"
alias l=ls
alias la="ls -a"
alias c="clear"
alias x="xclip -selection clipboard"
alias ":q"="exit"
alias ..="cd .."

# Git
alias gcm="git commit"
alias gp="git push"
alias gdn="git diff --no-index"
alias gd="git diff"
alias glog="git log"
alias gds="git describe --always --tags --dirty"
alias gst="git status"
alias gaa="git add -A"

# Rsync
alias rsync="rsync --info=progress2"

alias tmux="TERM=xterm-256color tmux"
