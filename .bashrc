
########################################
# Enviroment
########################################

# エディタ
export EDITOR
EDITOR='vim'

# 新規ファイルの権限を設定
umask 022

########################################
# Alias
########################################

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -AlF'

# editor
alias vi='vim'

# clear
alias c='clear'

# file
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# global
alias gtags='gtags -v'
alias htags='htags -vsF'

# git
alias g='git'
# git - status
alias gs='git status'
# git - diff(non-stated)
alias gd='git diff'
alias gdw='git diff --color-words'
alias gds='git diff --stat'
alias gdn='git diff --name-only'
# git - diff(stated)
alias gd!='gd --cached'
alias gdw!='gdw --cached'
alias gds!='gds --cached'
alias gdn!='gdn --cached'
# git - commit
alias gc='git commit -v'
alias gc!='git commit -v --amend'
# git - log
alias gl='git log --stat --color'
alias glg='git log --graph --color'

