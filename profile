#!/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# Platform-specific setups
unamestr=$(uname)
case $unamestr in
  'Darwin')        # OSX
    PATH=$PATH:/usr/X11/bin
    _prefix=`brew --prefix`
    # Give precedence to user/local/bin because that's where Homebrew installs their stuff
    export PATH=$_prefix/bin:$PATH
    export PATH=$_prefix/sbin:$PATH

    # Python stuff
    if [ -d $_prefix/share/python ]; then
      export PATH=$_prefix/share/python:$PATH
    fi

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

    # Shell completion
    shellstr=$(echo $0 | sed -e 's/-//')
    case $shellstr in
    'bash')
      if [ -f $_prefix/etc/bash-completion ]; then
        source $_prefix/etc/bash-completion
      fi

      # Add homebrew bash completion file
      if [ -f $_prefix/Library/Contributions/brew_bash_completion.sh ]; then
        source $_prefix/Library/Contributions/brew_bash_completion.sh
      fi
      ;;
    esac

    ;;

  'Linux')
    if [[ -n `command -v keychain` ]]; then
      keychain id_rsa
      . ~/.keychain/`uname -n`-sh
    fi

    # enable programmable completion features
    shellstr=$(echo $0 | sed -e 's/-//')
    case $shellstr in
      'bash')
        if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
          . /etc/bash_completion
        fi

        if [ -f $HOME/.bash_completion ] && ! shopt -oq posix; then
          . $HOME/.bash_completion
        fi
        ;;
    esac


    #export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    #  vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    #  -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    #  -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
esac

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
export PATH=$HOME/bin:$PATH

# makes sure bash knows it's dealing with a color terminal-emulator and sets the colors for ls
# LSCOLORS is BSD/OSX format, LS_COLORS is linux format
export CLICOLOR=1

# bash history shit, removes dups, increases size, and saves on shell exit
# export HISTCONTROL=erasedups
# export HISTSIZE=10000
# shopt -s histappend

# Load RVM if available - some aliases can cause this to fail on some systems so we load it before them
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# load up aliases and functions
source ~/.bash_aliases
