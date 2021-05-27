
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

# man
color_man() {
  env MANPAGER='less -R' \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}
alias cman=color_man

fuzzy_man() {
  local manpage

  manpage=$(man -k . | awk '{print $1,$2}' | fzf -q "$1" --prompt='MAN> ' | awk '{print $1}')

  if [ -n "$manpage" ]; then
    cman $manpage
  fi
}

fuzzy_man_with_summary() {
  local manpage

  manpage=$(man -k . | fzf -q "$1" --prompt='MAN> ' | awk '{print $1}')

  if [ -n "$manpage" ]; then
    cman $manpage
  fi
}
alias fman=fuzzy_man
alias fman2=fuzzy_man_with_summary
# alias fmans=fuzzy_man_with_summary

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

fuzzy_git_select_modified_with_preview() {
  local selected

	if type unbuffer >/dev/null 2>&1; then
    selected=$(unbuffer git status --short | grep -e '??' -e '.M' | fzf --multi --ansi --preview "echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
  else
    selected=$(git status --short | grep -e '??' -e '.M' | fzf --multi --preview "echo {} | awk '{print \$2}' | xargs git diff --color" | awk '{print $2}')
  fi
  echo $selected
}

# git add
fuzzy_git_add() {
  local selected

  if [ "$1" == "-p" ]; then
    selected="$(fuzzy_git_select_modified_with_preview)"
  else
    selected="$(fuzzy_git_select_modified)"
  fi

  if [ -n "$selected" ]; then
    echo $selected
    git add $selected
  fi
}

alias ga='fuzzy_git_add'
alias gap='fuzzy_git_add -p'

# select git diff file
fuzzy_select_git_diff() {
  local selected

  selected="$(git diff --name-only $1 | fzf --multi --preview="git diff $1 --color {}")"

  if [ -n "$selected" ]; then
    echo $selected
  fi
}

fuzzy_git_difftool() {
  local selected

  selected="$(fuzzy_select_git_diff $1)"

  if [ -n "$selected" ]; then
    git difftool $1 --no-prompt $selected
  else
    git difftool $1
  fi
}
alias gdt='fuzzy_git_difftool'
alias gdt!='fuzzy_git_difftool --cached'

# grep keyword and open file by vim with line number
# vimag 100
# vimag -w 100
# vimag .
fuzzy_open_found_keyword() {
  local file
  local line

	if type unbuffer >/dev/null 2>&1; then
    read -r file line <<<"$(unbuffer ag --nobreak --noheading $@ | fzf -0 -1 --ansi | awk -F: '{print $1, $2}')"
  else
    read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"
  fi

  if [[ -n $file && "$line" =~ ^[0-9]+$ ]]; then
     vim $file +$line
  fi
}
alias viag=fuzzy_open_found_keyword

# clipboard on WSL
if uname -a| grep -i 'linux.*microsoft' >/dev/null 2>&1; then
	if type win32yank.exe >/dev/null 2>&1; then
		# output clipboard
		alias cout='win32yank.exe -o'
		# input to clipboard(eg. echo "hello" | cin)
		alias cin='win32yank.exe -i'
	fi
fi

