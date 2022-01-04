# General #############################{{{

# Permission for file creation.
umask 022

# Editor
export EDITOR
EDITOR='vim'

# Check command is executable or not.
# param $1 : command which is checked.
executable() {
  type "$1" >/dev/null 2>&1
}
#}}}

# Prompt ##############################{{{
# PS1="\$(
# 	echo -ne "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ "
# )"
#
PS1=$(echo -ne "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ ")

prompt_post_message() {
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
#}}}

# General Utilities ###################{{{

# clear
alias c='clear'

# ls
alias ls='ls --color=auto'
alias la='ls -A'
alias ll='ls -lF'
alias lla='ls -AlF'

# file operation
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#}}}

# global ##############################{{{
alias gtags='gtags -v'
alias htags='htags -vsF'
#}}}

# unbuffer ############################{{{
# unbuffer
if executable unbuffer; then
# if type unbuffer >/dev/null 2>&1; then
  UNBUFFER=unbuffer
fi
#}}}

# fd ##################################{{{
# https://github.com/sharkdp/fd

FD_COMMAND=''
# Checking fd existance.
if executable fd; then
  FD_COMMAND='fd'
elif executable fdfind; then
  # Rename 'fdfind' to 'fd'.
  alias fd='fdfind'
  FD_COMMAND='fdfind'
fi
#}}}

# fzf #################################{{{
# https://github.com/junegunn/fzf

export FZF_DEFAULT_OPTS='--multi --layout=reverse --cycle'

if executable ${FD_COMMAND}; then

  export FZF_DEFAULT_COMMAND="${FD_COMMAND} --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  _fzf_compgen_path() {
    ${FD_COMMAND} --hidden --follow --exclude ".git" . "$1"
  }
  _fzf_compgen_dir() {
    ${FD_COMMAND} --type d --hidden --follow --exclude ".git" . "$1"
  }
fi
#}}}

# cd ##################################{{{
# enhancd
export ENHANCD_DISABLE_DOT=1

# cd - change directory to children directly
fuzzy_cd_children() {
  local dir_=$(find ./ -path '*/\.*' -name .git -prune -o -type d -print 2> /dev/null | \
    fzf --layout=reverse --height 40% --cycle)

  if [ -n "$dir_" ]; then
    cd "$dir_"
  fi
}

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdd='fuzzy_cd_children'

#}}}

# man ################################{{{
# man - show man page with color
man_color() {
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

# man - Finding keyword from man page.
# $ fuzzy_man
# $ fuzzy_man a-part-of-word
fuzzy_man() {
  local manpage=$(man -k . | fzf -q "$1" --nth 1 --prompt='MAN> ' | awk '{print $1}')

  if [ -n "$manpage" ]; then
    man_color $manpage
  fi
}

# man - Finding keyword or summary from man page.
# $ fuzzy_man_including_summary
# $ fuzzy_man_including_summary a-part-of-word
fuzzy_man_including_summary() {
  local manpage=$(man -k . | fzf -q "$1" --prompt='MAN> ' | awk '{print $1}')

  if [ -n "$manpage" ]; then
    man_color $manpage
  fi
}

alias man='man_color'
alias fman='fuzzy_man'
alias fman2='fuzzy_man_including_summary'
#}}}

# Git #################################{{{

# git - select modified git files
fuzzy_git_select_modified() {
  local selected="$($UNBUFFER git status --short | \
    grep -e '??' -e '.M' | \
    fzf --multi --ansi | \
    awk '{print $2}')"
  echo $selected
}
fuzzy_git_select_modified_preview() {
  local selected=$($UNBUFFER git status --short | \
    grep -e '??' -e '.M' | \
    fzf --multi --ansi --preview "echo {} | awk '{print \$2}' | xargs git diff --color" | \
    awk '{print $2}')
  echo $selected
}

# git - git add
fuzzy_git_add() {
  local selected

  if [ "$1" == "-p" ]; then
    selected="$(fuzzy_git_select_modified_preview)"
  else
    selected="$(fuzzy_git_select_modified)"
  fi

  if [ -n "$selected" ]; then
    echo $selected
    git add $selected
  fi
}

# fuzzy_git_select_branch() {
#
# }

# git - checkout git branch
fuzzy_git_checkout() {
  local branches branch

  branches=$($UNBUFFER git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf --no-multi --ansi) &&
  git checkout $(echo "$branch" | sed "s/^\*//" | awk '{print $1}' | sed "s/.* //")
}

# git - checkout git branch (including remote branches)
fuzzy_git_checkout_including_remote() {
  local branches branch

  branches=$($UNBUFFER git --no-pager branch --all -vv | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf --no-multi --ansi) &&
  git checkout $(echo "$branch" | sed "s/^\*//" | awk '{print $1}' | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# git - select git commmit sha
# example usage:
# $ git rebase -i $(fuzzy_git_select_hash)
# $ git checkout $(fuzzy_git_select_hash)
fuzzy_git_select_hash() {
  local commit sha
  local preview_window

  if [ "$1" == "-pv" ]; then
    # show vertical fzf preview window.
    preview_window=right
  elif [ "$1" == "-ph" ]; then
    # show horizonal fzf preview window.
    preview_window=down
  else
    # don't show fzf preview window.
    preview_window=hidden
  fi

  commit=$(
      git log --graph --color=always --abbrev-commit --date=short \
        --format="%C(auto)%h%d %C(black)%C(bold)%ad %an %C(auto)%s" |
      fzf --ansi --multi --no-sort --reverse --print-query \
        --preview "echo {} | sed 's/^[^a-z0-9]*//;/^$/d' | awk '{print \$1}' | xargs git show --color=always" \
        --preview-window $preview_window) &&
  sha=$(sed 's/^[^a-z0-9]*//;/^$/d' <<< "$commit" | awk '{print $1}')
  echo $sha
}

# git - select git diff file
# Parameter are passed to the 'git diff'.
# example usage:
# $ fuzzy_select_git_diff --cached
fuzzy_select_git_diff() {
  local selected

  selected="$(git diff --name-only $@ | fzf --multi --preview="git diff $@ --color {}")"

  if [ -n "$selected" ]; then
    echo $selected
  fi
}

# git - launch git-difftool
# If selected file, launch difftool for selected files.
# Otherwise, launch difftool for all of shown files.
# Parameter are passed to the 'fuzzy_select_git_diff'.
fuzzy_git_difftool() {
  local selected

  selected="$(fuzzy_select_git_diff $@)"

  if [ -n "$selected" ]; then
    git difftool $@ --no-prompt $selected
  else
    git difftool $@
  fi
}

# git --- primitive commands
# git - status
alias gs='git status'
# git - branch
alias gb='git branch'
# git - diff(non-stated)
alias gd='git diff'
alias gdw='git diff --color-words'
alias gdf='git diff --stat'
alias gdn='git diff --name-only'
# git - diff(stated)
alias gd!='gd --cached'
alias gdw!='gdw --cached'
alias gdf!='gdf --cached'
alias gdn!='gdn --cached'
# git - commit
alias gc='git commit -v'
alias gc!='git commit -v --amend'
# git - log
alias gl='git log --stat --color'
alias glg='git log --graph --color'

# git --- fuzzy commands
# fuzzy git - add
alias git-add='fuzzy_git_add'
alias git-add-preview='fuzzy_git_add -p'
alias ga='fuzzy_git_add'
alias gap='fuzzy_git_add -p'
# fuzzy git - checkout
alias git-checkout='fuzzy_git_checkout'
alias git-checkout-remote='fuzzy_git_checkout_including_remote'
alias gco='fuzzy_git_checkout'
alias gcor='fuzzy_git_checkout_including_remote'
# fuzzy git - get hash
alias git-hash='fuzzy_git_select_hash'
alias ghash='fuzzy_git_select_hash'
# fuzzy git - difftool
alias git-difftool='fuzzy_git_difftool'
alias gdt='fuzzy_git_difftool'
alias gdt!='fuzzy_git_difftool --cached'

#}}}

# vim #################################{{{

# vim - find keyword and open file by vim with line number
# example usage:
# $ fuzzy_open_found_keyword <keyword>
# $ fuzzy_open_found_keyword 100
# $ fuzzy_open_found_keyword -w 100
# $ fuzzy_open_found_keyword .
fuzzy_open_found_keyword() {
  local file line

  read -r file line <<<"$($UNBUFFER ag --nobreak --noheading $@ | \
    fzf -0 -1 --ansi | \
    awk -F: '{print $1, $2}')"

  if [[ -n $file && "$line" =~ ^[0-9]+$ ]]; then
     vim $file +$line
  fi
}

alias vi='vim'
alias viag='fuzzy_open_found_keyword'

#}}}

# For WSL #############################{{{
if uname -a| grep -i 'linux.*microsoft' >/dev/null 2>&1; then

  # clipboard on WSL

  if executable win32yank.exe; then
    # output clipboard
    alias cout='win32yank.exe -o'
    # input to clipboard(eg. echo "hello" | cin)
    alias cin='win32yank.exe -i'
  fi

  # explorer
  alias exp='explorer.exe . | echo "explorer open ... $(pwd)"'

fi
#}}}

# vim: ft=sh fdm=marker sw=2 sts=2 ts=2 et
