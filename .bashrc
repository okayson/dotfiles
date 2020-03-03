
########################################
# Enviroment
########################################

# Permission for file creation.
umask 022

# Editor
export EDITOR
EDITOR='vim'

# fzf
if type fzf >/dev/null 2>&1; then
	export FZF_DEFAULT_OPTS='--multi --layout=reverse --cycle'

	# if type tree >/dev/null 2>&1; then
	# 	export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
	# fi
fi

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

# # xclip
# alias clipin='xclip -selection c'
# alias clipout='xclip -selection c -o'

# cd
function cd_fzf_find() {
    local DIR=$(find ./ -path '*/\.*' -name .git -prune -o -type d -print 2> /dev/null | fzf --layout=reverse --height 40% --cycle)
    if [ -n "$DIR" ]; then
        cd $DIR
    fi
}
alias cdd=cd_fzf_find

