
########################################
# Enviroment
########################################

# Permission for file creation.
umask 022

# Editor
export EDITOR
EDITOR='vim'

# fzf
export FZF_DEFAULT_OPTS='--multi --layout=reverse --cycle'

# enhancd
export ENHANCD_DISABLE_DOT=1

########################################
# Prompt
########################################
# PS1="\$(
# 	echo -ne "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "
# )"
#
PS1=$(echo -ne "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ ")

function prompt_post_message {
	local command_result=$?
	if [[ ! $prompt_post_message ]] ; then
		prompt_post_message=1
		return
	fi
	if [[ $command_result -eq 0 ]] ; then
		# echo -ne "\e[0;37m[ Success ]\e[00m\n"
		:
	else
		echo -ne "\e[0;31m[ Failure (code=$command_result) ]\e[00m\n"
	fi
}

PROMPT_COMMAND="prompt_post_message; ${PROMPT_COMMAND//prompt_post_message;/}"

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
alias gdf='git diff --stat'
alias gdn='git diff --name-only'
alias gdd='git difftool'
# git - diff(stated)
alias gd!='gd --cached'
alias gdw!='gdw --cached'
alias gdf!='gdf --cached'
alias gdn!='gdn --cached'
alias gdd!='git difftool --cached'
# git - commit
alias gc='git commit -v'
alias gc!='git commit -v --amend'
# git - log
alias gl='git log --stat --color'
alias glg='git log --graph --color'

# cd to children directly
fuzzy_cd_children() {
    local DIR=$(find ./ -path '*/\.*' -name .git -prune -o -type d -print 2> /dev/null | fzf --layout=reverse --height 40% --cycle)
    if [ -n "$DIR" ]; then
        cd $DIR
    fi
}
alias cdd=fuzzy_cd_children

# select modified git files
fuzzy_git_select_modified() {
  local selected

	if type unbuffer >/dev/null 2>&1; then
    selected="$(unbuffer git status --short | grep -e '??' -e '.M' | fzf --multi --ansi | awk '{print $2}')"
  else
    selected="$(git status --short | grep -e '??' -e '.M' | fzf --multi | awk '{print $2}')"
  fi
  echo $selected
}

# git add
fuzzy_git_add() {
  local selected

  selected="$(fuzzy_git_select_modified)"

  if [ -n "$selected" ]; then
    echo $selected
    git add $selected
  fi
}

alias ga=fuzzy_git_add

# select git diff file
fuzzy_select_git_diff() {
  local selected

  selected=$(git diff --name-only | fzf --multi --preview="git diff --color {}")

  if [ -n "$selected" ]; then
    echo $selected
  fi
}

# usage:
# $ git add $(gds)
# $ gdd $(gds)
alias gds=fuzzy_select_git_diff

# clipboard on WSL
if uname -a| grep -i 'linux.*microsoft' >/dev/null 2>&1; then
	if type win32yank.exe >/dev/null 2>&1; then
		# output clipboard
		alias cout='win32yank.exe -o'
		# input to clipboard(eg. echo "hello" | cin)
		alias cin='win32yank.exe -i'
	fi
fi

