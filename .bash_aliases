#!/bin/bash
# Aliases for various command shorthands and default options

# A good rule is that all these aliases should use the longhand form of an
# option when setting it as the default, so this file is clearer to read.

# safety nets
alias rm='rm --verbose --interactive=once --preserve-root'
alias mv='mv --verbose --interactive'
alias cp='cp --verbose --interactive'
alias ln='ln --verbose --interactive'

# colors
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# ls shortcuts
alias ll='ls -l --all --classify'
alias l.='ls --directory .*'
alias la='ls --almost-all'
alias l='ls -C --classify'

# cd shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
#alias ..2='cd ../..'
#alias ..3='cd ../../..'
#alias ..4='cd ../../../..'
#alias ..5='cd ../../../../..'

# mkdir/rmdir can create/destroy directory trees and will show output
alias mkdir='mkdir --parents --verbose'
alias rmdir='rmdir --parents --verbose'

# prevent grep from showing binary files (can use -a -l to show binary files);
# turn on color; exclude anything in a .git directory from appearing in matches
alias grep='grep --color=auto --binary-files=without-match --exclude-dir=.git'

# command to show all ports
alias ports='netstat -tulanp'

# sha1
alias sha1='openssl sha1'

# xclip straight to keyboard (X Windows only)
alias xclipc="xclip -selection clipboard"

# tmux: start in 256-color-capable mode
alias tmux='tmux -2'

# avoid accidentally using vi
alias vi='vim -p'

# make is a lot more efficient if you can build multiple targets on different
# cores
# 8 is a reasonable number in 2021; if 16 core CPUs become more commonplace
# then reevaluate this.
alias make='make --jobs 8'

# Aliases guarded by a certain program being installed on the system. If that
# program isn't installed, the aliases won't exist.
# This section is used for programs that probably aren't installed on a
# standard system.

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
if cmdexists notify-send; then
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# Add Postgres commands to the PATH (modify this for whatever version is installed)
if cmdexists pg_ctl; then
  export PATH=$PATH:/usr/lib/postgresql/9.4/bin
  alias pgstart='pg_ctl start -D /var/lib/postgresql/9.4/main'
  alias pgstop='pg_ctl stop -D /var/lib/postgresql/9.4/main'
fi

# libreoffice shorthand
if cmdexists libreoffice; then
  alias lo='libreoffice'
fi

# almost never want to open feh without autoscaling and aliasing
if cmdexists feh; then
  alias feh="feh --scale-down --force-aliasing"
fi
