#!/bin/bash

PATH=/usr/bin:/bin:/usr/sbin:/sbin

# Platform-specific setups
unamestr=$(uname)
case $unamestr in
  'Darwin')        # OSX
    PATH=$PATH:/usr/X11/bin

    # Give precedence to user/local/bin because that's where Homebrew installs their stuff
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH

    # Python stuff
    export PATH=/usr/local/share/python:$PATH

   # Give precedence to homebrew's version of the GNU utils
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

    # I can set alias ls=ls_osx if I don't have gnu coreutils installed
    # alias ls_osx="ls -p -F -G -h"
    # Colorize ls
    # export LSCOLORS=hxdxDxGxbxfxFxBxBxHxHx

    # Attempt at fixing OSX tomfoolery
    export ARCHFLAGS="-arch x86_64"

    # Tell compiler to use multiple cores
    export MAKEFLAGS="-j `sysctl hw.ncpu | cut -d ' ' -f 2`"

    # set vim as pager for manual
    #export MANPAGER='col -bx | vim -c ":set ft=man nonu nolist" -R -'

    # if [ -f `brew --prefix`/etc/bash-completion ]; then
    #   source `brew --prefix`/etc/bash-completion
    # fi

    # Add homebrew bash completion file
    # if [ -f `brew --prefix`/Library/Contributions/brew_bash_completion.sh ]; then
    #   source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
    # fi

    ;;

  'Linux')
    if [[ -n `command -v keychain` ]]; then
      keychain id_rsa
      . ~/.keychain/`uname -n`-sh
    fi

    #export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    #  vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    #  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    #  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
esac

export EDITOR=vim

# Handle potential pagers
if [[ -n `command -v vimpager` ]]; then
  export PAGER=vimpager
else
  if [[ -n `command -v vimless` ]]; then
    export PAGER=vimless
  fi
  if [[ -n `command -v vimman` ]]; then
    export MANPAGER=vimman
  fi
fi

# enable vi command line editing mode
#set -o vi

# add path to all my useful script and binary directories
export PATH=$HOME/bin::$PATH

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# enable programmable completion features
# if [ -f $HOME/.bash_completion ] && ! shopt -oq posix; then
#   . $HOME/.bash_completion
# fi


# makes sure bash knows it's dealing with a color terminal-emulator and sets the colors for ls
# LSCOLORS is BSD/OSX format, LS_COLORS is linux format
export CLICOLOR=1

# bash history shit, removes dups, increases size, and saves on shell exit
# export HISTCONTROL=erasedups
# export HISTSIZE=10000
# shopt -s histappend

# Load RVM if available - some aliases can cause this to fail on some systems so we load it before them
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# load up aliases and functions
source ~/.bash_aliases
