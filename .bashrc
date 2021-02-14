# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# uncomment for a colored prompt, if the terminal has the capability
# (pretty much any modern terminal will)
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

# Generation function that constructs the PS1 prompt format string
# without incorporating ugly conditionals into a single string.
ps1_generator() {
    local saved_ret=$?
    local Nclr='\[\e[0m\]'
    local Bgrn='\[\e[1;32m\]'
    local Bblu='\[\e[1;34m\]'
    local Bred='\[\e[1;31m\]'
    local cyan='\[\e[0;36m\]'
    if [ ! -n $color_prompt ]; then
        Nclr=''
        Bgrn=''
        Bblu=''
        Bred=''
        cyan=''
    fi

    # base part of prompt, current working directory
    local wd=$(pwd)

    # May need to replace \u with \h if you are working across multiple hosts a
    # lot
    local precolon='\u'
    local postcolon='\w'
    PS1="${Bgrn}$precolon${Nclr}:${Bblu}$postcolon${Nclr}"

    # add current git branch, if any, after this
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ $branch != "" ]]; then
        PS1+=" ${cyan}[$branch]${Nclr}"
    fi

    # add an appropriate emoticon based on the exit code of the last command
    # Experimental.
    if [ $saved_ret != 0 ]; then
        PS1+=" ${Bred}:/${Nclr}"
    else
        PS1+=" ${Bgrn}:)${Nclr}"
    fi

    # finish with the traditional $
    PS1+=" $ "
}
export PROMPT_COMMAND=ps1_generator
unset color_prompt force_color_prompt

# Utility function to tell us whether a command exists on this system
# (not for use by shell user, really, though it doesn't get undefined so they
# *can* use it - provided for this file and .bash_aliases)
cmdexists() {
  command -v $1 >/dev/null
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# Set default editor as Vim
export EDITOR=$(command -v vim)

# Add executables in .local/bin to the PATH
export PATH=$PATH:~/.local/bin

# Use vi-style command line editing
set -o vi

# stop ctrl-s from suspending the terminal
stty -ixon -ixoff

# set environment variables so source-highlight works with less
# requires source-highlight to be installed
if cmdexists src-hilite-lesspipe.sh; then
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
  export LESS=' -R '
fi

# set environment variable so that ls doesn't show garish blue-on-green-back
# for directories that are globally writable (common when mounting ext4 fs)
# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  export LS_COLORS=$LS_COLORS:'ow=:tw='
fi

# banner setup
# readlink expands ~ into the proper path
#export QUOTEFILE=$(readlink -f ~/quotes.dat)
#export BANNERPATH=$(readlink -f ~/projects/banner/banner)
#~/projects/banner/bannerquote.sh
