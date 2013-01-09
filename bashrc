PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# Platform-specific setups
unamestr=$(uname)
case $unamestr in
'Darwin')        # OSX
  if [ -f ~/.osx_profile ]; then
    source ~/.osx_profile
  else
    echo "No OSX profile present"
  fi
;;

'Linux')
  if [ -f ~/.linux_profile ]; then
    source ~/.linux_profile
  else
    echo "No Linux profile present"
  fi
;;
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
export PATH=$HOME/opt/bin:$PATH
# makes sure bash knows it's dealing with a color terminal-emulator and sets the colors for ls
# LSCOLORS is BSD/OSX format, LS_COLORS is linux format
export CLICOLOR=1

# bash history shit, removes dups, increases size, and saves on shell exit
export HISTCONTROL=erasedups
export HISTSIZE=100000
shopt -s histappend

# Load RVM if available - some aliases can cause this to fail on some systems so we load it before them
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# load up aliases and functions
# source ~/.aliases

