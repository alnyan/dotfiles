
### Global config
HISTFILE=${HOME}/.zsh_history
HISTSIZE=3000
SAVEHIST=3000
WORDCHARS=${WORDCHARS/\//}
HOSTNAME="$(hostname)"

setopt INC_APPEND_HISTORY SHARE_HISTORY APPEND_HISTORY EXTENDED_HISTORY ALL_EXPORT
setopt hist_expire_dups_first hist_ignore_dups hist_verify
setopt notify globdots pushdtohome autolist pushdsilent noautopushd extendedglob
unsetopt BG_NICE bgnice

### Plugin/script management
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

### Plugins
zinit snippet OMZL::async_prompt.zsh
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-syntax-highlighting

### ZSH completion
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi

### Key binds
autoload colors zsh/terminfo
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[cuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey "${terminfo[cud1]}" history-substring-search-down

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

### Paths
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

### Aliases
# Common
alias l="ls -lh"
alias la="ls -alh"
alias grep="grep --color"
alias rsync="rsync --info=progress2"
alias mc="mc -u"
# Git
alias gst="git status"
alias gcm="git commit"
alias gd="git diff"
alias gdt="git difftool"
alias gup="git pull --rebase"
alias gp="git push"
alias gaa="git add -A"
alias glog="git log"
alias tkdiff="nvim -d"

export KEYTIMEOUT=1
export EDITOR=nvim
export VISUAL=nvim

export PROMPT="%F{13}%n%f@%F{14}%M%f %F{11}%~%f %# "
