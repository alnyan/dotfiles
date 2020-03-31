# alnyan's zsh config
# based on zephyx86's zsh config
# (which in turn was based on oh-my-zsh and arch-anywhere)

source "${HOME}/.zsh/zsh-history-substring-search.zsh"
source "${HOME}/.zsh/zsh-vim-mode.plugin.zsh"

setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY

unsetopt BG_NICE

setopt EXTENDED_HISTORY
setopt ALL_EXPORT

setopt notify globdots pushdtohome cdablevars autolist
setopt autocd pushdsilent noautopushd extendedglob
unsetopt bgnice

autoload -U history-search-cmd
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

HISTFILE=${HOME}/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
HOSTNAME="$(hostname)"

autoload colors zsh/terminfo

# plugins=(git)

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[P" delete-char

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

autoload -U compinit
compinit
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

export PROMPT="%F{13}%n%f@%F{14}%M%f %F{11}%~%f %# "

## pyenv configs
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_HOME="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff steady underline"
MODE_INDICATOR_VIINS='%F{8}<%F{8}INSERT<%f'
MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'
export KEYTIMEOUT=1

interactive_mode_hook() {
    time_now=$(date +%s)
    if [ -f ${HOME}/.mutt_check ]; then
        last_time=$(<${HOME}/.mutt_check)
        time_delta=$((time_now - last_time))

        if (( ${time_delta} > 43200 )); then
            printf "\033[31;7m!!! Time to check mail !!!\033[0m\n"
        fi
    else;
        last_time=time_now
        echo ${time_now} >${HOME}/.mutt_check
    fi
}

sedr() {
    find -type f -exec sed -i $@ {} \;
}

alias dotoo="nvim ~/Documents/alnyan.dotoo"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

case $- in
    *i*) interactive_mode_hook;;
esac

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# opam configuration
test -r /home/alnyan/.opam/opam-init/init.zsh && . /home/alnyan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
