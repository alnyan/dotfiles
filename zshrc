# alnyan's zsh config
# based on zephyx86's zsh config
# (which in turn was based on oh-my-zsh and arch-anywhere)

HISTFILE=${HOME}/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
WORDCHARS=${WORDCHARS/\//}
HOSTNAME="$(hostname)"

source "${HOME}/.zsh/zsh-history-substring-search.zsh"

setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY

unsetopt BG_NICE

setopt EXTENDED_HISTORY
setopt ALL_EXPORT

setopt notify globdots pushdtohome autolist #cdablevars
setopt autocd pushdsilent noautopushd extendedglob
unsetopt bgnice

autoload -U history-search-cmd
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

autoload colors zsh/terminfo

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
# bindkey "^[[P" delete-char
bindkey "^[[3~" delete-char

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

autoload -Uz compinit
compinit
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*::::' completer _expand _complete _ignored

# Aliases
alias ls="ls --color -lh --group-directories-first"
alias ll=ls
alias l=ls
alias la="ls -a"
alias x="xclip -selection clipboard"
alias ":q"=exit
alias grep="grep --color"

# Git aliases
alias gcm="git commit"
alias gp="git push"
alias gup="git pull --rebase"
alias gd="git diff"
alias glog="git log"
alias gds="git describe --always --tags --dirty"
alias gst="git status"
alias gaa="git add -A"
alias mutt="date +%s>~/.mutt_check; mutt"
alias rsync="rsync --info=progress2"
alias pjs="python -m json.tool"
alias sarge="sudo emerge -a --quiet-build"

alias mpmp="pidof mpd || mpd && ncmpcpp"

export KEYTIMEOUT=1
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PROMPT="%F{13}%n%f@%F{14}%M%f %F{11}%~%f %# "

export PATH=$HOME/.local/bin:$PATH

source ~/.cargo/env
