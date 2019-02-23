export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

#zmodload zsh/zprof

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="amusewes"

#eval "$(docker-machine env default)"
#eval "$(chef shell-init zsh)"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#export NVM_LAZY_LOAD=true
#export NVM_AUTO_USE=true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# # place this after nvm initialization!
# autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
# add-zsh-hook chpwd load-nvmrc
#load-nvmrc

export GOPATH="$(realpath ~/go)"
export PATH="$PATH:$GOPATH/bin"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(kubectl taskwarrior ruby rbenv docker git github gitignore git-flow colorize golang)
#disabled_plugins=(tmux python virtualenv vagrant virtualenvwrapper pip)

# User configuration

source $ZSH/oh-my-zsh.sh
eval "$(rbenv init -)"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias drd='docker rmi $(docker images -f "dangling=true" -q)'
alias dre='docker rm $(docker ps -a -f status=exited -q)'
alias drc='docker rm $(docker ps -a -f status=created -q)'
alias dps='docker ps --format '\''table {{ .ID }}\t{{ .Image }}\t{{ .Names }}\t{{ .Ports }}'\'''
alias dpsa='docker ps -a --format '\''table {{ .ID }}\t{{ .Image }}\t{{ .Names }}\t{{ .Ports }}'\'''
alias git-update-fork="git pull upstream master && git push"
alias gfu='b=$(git symbolic-ref --short HEAD); git checkout master && git pull upstream master && git push && git checkout ${b}'
alias bx='bundle exec'
alias be='bundle exec'
alias ga='git add'
alias gb='git branch'
alias gci='git commit'
alias gca='git commit -a --amend --no-edit'
alias gco='git checkout'
alias gd='git diff'
alias gh='git log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short'
alias gp='git pull'
alias gpr='git pr'
alias gpsh='git push'
alias gpu='git pull upstream master'
alias gfl='git flow'
alias grep='ggrep --color=AUTO'
alias time='/usr/bin/time'
alias timeout='gtimeout'
alias sed='gsed '
alias find='gfind'
alias gs='git status'
alias ll='ls -l '
alias ls='ls -GFh '
alias pr='pull-request'
alias vi='vim '
alias k='kubectl'
alias kc='kubecfg'
alias ku='kubectl config use-context'

# task warrior aliases
alias ty='task end.after:yesterday completed'

# Enable gpg-agent if it is not running-
# --use-standard-socket will work from version 2 upwards

AGENT_SOCK=$(gpgconf --list-dirs | grep agent-socket | cut -d : -f 2)

if [[ ! -S $AGENT_SOCK ]]; then
  gpg-agent --daemon --use-standard-socket &>/dev/null
fi
export GPG_TTY=$TTY

# Set SSH to use gpg-agent if it's enabled
GNUPGCONFIG="${GNUPGHOME:-"$HOME/.gnupg"}/gpg-agent.conf"
if [[ -r $GNUPGCONFIG ]] && command grep -q enable-ssh-support "$GNUPGCONFIG"; then
  export SSH_AUTH_SOCK="$AGENT_SOCK.ssh"
  unset SSH_AGENT_PID
fi

export PATH="$PATH:/opt/terraform"

function docker-machine-use {
  eval $(docker-machine env "$@")
}

function clear-dns-cache {
   # osx 10.5-6
   echo "trying osx 10.5-6 method..."
   sudo dscacheutil -flushcache
   # osx 10.7-9, 10.10.4+
   echo "trying osx 10.7-9 and 10.10.4+ method..."
   sudo killall -HUP mDNSResponder
   # osx 10.10.1-3
   echo "trying osx 10.10.1-3 method..."
   sudo discoveryutil mdnsflushcache
   echo "nscd?..."
   sudo /etc/init.d/nscd restart || sudo service nscd restart
   echo "dnsmasq?..."
   sudo /etc/init.d/dnsmasq restart || sudo service dnsmasq restart
   echo "dnsmasq on osx?..."
   sudo launchctl stop homebrew.mxcl.dnsmasq
   sudo launchctl start homebrew.mxcl.dnsmasq
}
alias flush-dns-cache='clear-dns-cache'

function aws_env_creds() {
  local credfile="${HOME}/.aws/credentials"
  local profile="${1:-default}"

  if ! err_msg=$(egrep -q ${profile} ${credfile} 2>&1); then
    echo "Error reading profile '${profile}' from ${credfile}" >&2
    echo ${err_msg} >&2
    return $rc
  fi

  creds=$(egrep -A2 ${profile} ${credfile} | tail -2)
  local access_key=$(echo "$creds" | head -n1)
  local secret_key=$(echo "$creds" | tail -n1)

  export AWS_ACCESS_KEY_ID=$(echo "${access_key#*=}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
  export AWS_SECRET_ACCESS_KEY=$(echo "${secret_key#*=}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
}

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

export PROJECT_ROOT="${HOME}/projects"

#export ZPLUG_HOME=/usr/local/opt/zplug
#source $ZPLUG_HOME/init.zsh

# Install plugins if there are plugins that have not been installed
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi

#zplug "b4b4r07/enhancd", use:init.sh

#zplug load

#source ~/z/z.sh

#zprof
. "/Users/wes/.acme.sh/acme.sh.env"
