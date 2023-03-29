#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTCONTROL=ignoreboth:erasedups           # no duplicate entries
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTIGNORE="ls:[bf]g:exit:pwd:clear:alias"
export HISTTIMEFORMAT="%F %T "

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob # enables the matching of hidden files in globbing operation
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control
shopt -s globstar # pattern "**" used in a pathname expansion

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

### SET VI MODE ###
# Comment this line out to enable default emacs-like bindings
set -o vi # vi mode
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set prompt
export BASIC_PROMPT="\033[0m\033[1;32m\u@\h\033[0m:\033[1;34m\w\033[0m \$ "
export DEFAULT_PROMPT="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"
export RIGHT_PROMPT_ADJUST=37

rightprompt()
{
    str=${*}
    printf "%*s" $(expr $((COLUMNS)) + $RIGHT_PROMPT_ADJUST) "${*}"
}


prompt_timer_start () {
    PROMPT_TIMER=${PROMPT_TIMER:-$(date +%s.%3N)}
    echo -ne "\033]0;${*}\007"
}

function prompt_timer_stop {
    local EXIT="$?" # MUST come first
    local NOW=$(date +%s.%3N) # should be high up, for accurate measurement
    echo -ne "\033]0;$USER@$HOSTNAME: $PWD\007"

    local ELAPSED=$(bc <<< "$NOW - $PROMPT_TIMER")
    unset PROMPT_TIMER

    local T=${ELAPSED%.*}
    local AFTER_COMMA=${ELAPSED##*.}
    local D=$((T/60/60/24))
    local H=$((T/60/60%24))
    local M=$((T/60%60))
    local S=$((T%60))

    local TIMER_SHOW=
    [[ $D -gt 0 ]] && TIMER_SHOW=${TIMER_SHOW}$(printf '%dd ' $D)
    [[ $H -gt 0 ]] && TIMER_SHOW=${TIMER_SHOW}$(printf '%dh ' $H)
    [[ $M -gt 0 ]] && TIMER_SHOW=${TIMER_SHOW}$(printf '%dm ' $M)
    TIMER_SHOW=${TIMER_SHOW}$(printf "%d.${AFTER_COMMA}s" $S)

    RPS1="\e[0;93;100m ${TIMER_SHOW} " # runtime of last command
    RPS1+="\e[37m [$(date +%H:%M)] " # date, e.g. 17:00
    if [ $EXIT != 0 ]; then
        RPS1+="\e[1;37;41m ${EXIT} ✘" # red x with error status
    else
        RPS1+="\e[1;37;42m ✔" # green tick
    fi
    RPS1+="\e[0m"
    PS1="\e[0m$(tput sc; rightprompt ${RPS1}; tput rc)" # begin with a newline

    local PSCHAR="\$"
    PS1+="\e[0;1;32m\u@\h\e[0m:" # non-root: green hostname
    PS1+="\e[1;94m\w \e[0m>" # working directory

    GIT_PS1_SHOWDIRTYSTATE=true # * unstaged, + staged
    GIT_PS1_SHOWSTASHSTATE=true # $ stashed
    GIT_PS1_SHOWUNTRACKEDFILES=true # % untracked
    GIT_PS1_SHOWCOLORHINTS=true
    # < behind, > ahead, <> diverged, = same as upstream
    GIT_PS1_SHOWUPSTREAM="auto"
    # git with 2 arguments *sets* PS1 (and uses color coding)
    __git_ps1 "${PS1}\e[0m" "\e[0m"

    PS1+="\e[0m\n${PSCHAR} " # prompt in new line
}

trap 'prompt_timer_start "$BASH_COMMAND (`date +%H:%M:%S`)"' DEBUG
PROMPT_COMMAND=prompt_timer_stop

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
