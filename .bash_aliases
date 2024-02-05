#!/usr/bin/sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias of directories
alias ll='ls -alF'
alias l='ls -lF'
alias la='l -a'
alias l.='ls -lad .[!.]* ..?*'
alias ..='cd ..'
alias ...='cd ../..'
alias br='cd -'
alias hm='cd ~'
alias dsize='du -sh'                         # Summary human-readable sizes of the folder
alias lsize='sudo du -h --max-depth=1 | sort -hr'

# General alias
alias weather='curl wttr.in'

# SUDO allias
alias sa='sudo !!'
alias takeIt="sudo chown -R $USER"

# History tool
alias historian='history | grep'

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
#alias vifm='~/.config/vifm/scripts/vifmrun'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# git
alias addup='git add -u'
alias addall='git add .'
alias branch='git branch'
alias checkout='git checkout'
alias clone='git clone'
if [ ! -f "$HOME/.local/bin/commit" ]; then
  alias commit='git commit -m'
fi
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias stat='git status'  # 'status' is protected name so using 'stat' instead
alias tag='git tag'
alias newtag='git tag -a'
alias gtf='git ls-tree --full-tree --name-only -r HEAD'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# docker
if which docker > /dev/null 2>&1 ; then
    alias dk='docker'
    alias dkla='docker ps -a'
    alias dkls='docker ps --format "table {{.ID}}\t{{.Status}}\t{{.Names}}"'
    alias dkic='docker rmi $(docker images -f "dangling=true" -q)'
    alias docker-compose='docker compose'
    alias dkc='docker compose'
    alias dkis='docker image ls --format "{{.Size}} {{.ID}} {{.Repository}}:{{.Tag}}" | LANG=en_US sort -hr | column -t'
fi

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

# Add tool scripts
if [ -d ~/.local/tools ] ; then
  for file in ~/.local/tools/*; do
    if [ -f "$file" ] && [ -r "$file" ]; then
      # Source the file if it is a readable regular file
      . "${file}"
    fi
  done
fi
