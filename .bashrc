# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source the standard profile for non-login shells
[[ -r /etc/profile ]] && source /etc/profile 2>/dev/null

# import keybindings for history search
[[ -r ~/.inputrc ]] && bind -f ~/.inputrc

# enviroment variables
[[ -r /etc/os-release ]] && /etc/os-release
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:$PATH"
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
EDITOR=vim
PAGER=less
LESS='-Misc'
EXINIT='set number'
OSREL=`uname -s`

# export the variables to the os
export PATH HISTCONTROL HISTSIZE HISTFILESIZE
export EDITOR PAGER LESS EXINIT
export FTP_PASSIVE_MODE=true
case $OSREL in
  FreeBSD)
    export LANG='en_US.UTF-8'
    export EDITOR=vi
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    ;;
  Linux)
    export LANG='en_US.utf8'
    [[ -x /usr/bin/dircolors ]] && /usr/bin/dircolors >/dev/null
    [[ -x ~/.dircolors ]] && ~/.dircolors >/dev/null
    [[ -d /usr/src/kernels/$(uname -r) ]] && export KERN_DIR=/usr/src/kernels/$(uname -r)
    ;;
  *);;
esac

# file creation mask is 664
umask 002

# Disable terminal flow control, may cause tumx to "freeze" with CTRL-s
stty -ixon

# turn on interactive line editing
set -o emacs

# don't exit shell with ^D
set -o ignoreeof

# append to the history file, don't overwrite it
shopt -s histappend 2>/dev/null

# check the window size after each command
shopt -s checkwinsize 2>/dev/null

#check for background jobs before exiting a shell
shopt -s checkjobs 2>/dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

function branch {
  [[ `git status 2>/dev/null` ]] && echo -n "{$(git status|head -n1|sed 's/.*branch \(.*\)/\1/')}"
  [[ `hg branch 2>/dev/null` ]] && echo -n "{$(hg branch)}"
}

# Set the terminal title with `title name`
function title { printf "\033k$1\033\\"; }
title $(hostname -s)

# show last exit code, time, user, hostname, directory, git branch, prompt
# color prompt for xterm
case $TERM in
xterm*|screen*)
# save and load the history on every prompt
  PS1="$(history -a)$(history -n)[\[\033[0;33m\]\$?\[\033[m\]](\t)\[\033[01;34m\]\u@\h\[\033[m\]:\[\033[0;32m\]\w/\[\033[m\]\[\033[0;36m\]\$(branch)\[\033[m\]\\$>"
#  PS1="[\[\033[0;33m\]\$?\[\033[m\]](\t)\[\033[01;34m\]\u@\h\[\033[m\]:\[\033[0;32m\]\w/\[\033[m\]\[\033[0;36m\]\$(branch)\[\033[m\]\\$>"
  ;;
*)
  PS1="$(history -a)$(history -n)[\$?](\t)\u@\h:\w\\$>"
  ;;
esac

#Color grep output
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias less='less -NMisc'
alias sudo='sudo '

# OS dependent aliases
case $OSREL in
  FreeBSD)
    alias ls='ls -ACFG'
    alias ll='ls -AlhFG -D"%F %T"'
    alias pp='ps axo user,pid,pcpu,pmem,stat,ni,time,command'
    alias netstat='netstat -anf inet'
  ;;
  Linux)
    alias ls='ls -ACF --color=auto'
    alias ll='ls -AlhF --color=auto --time-style=long-iso'
    alias pp='ps axo user,pid,pcpu,pmem,stat,ni,bsdtime,command'
    alias netstat='netstat -ant'
  ;;
  *)
    alias ls='ls -ACF'
    alias ll='ls -AlhF'
    alias pp='ps aux'
    alias netstat='netstat -an'
  ;;
esac

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#####################
## Start SSH Agent if not already started
# https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

## END SSH Agent bits
#####################

#############
# Some defaults from original .bashrc

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
