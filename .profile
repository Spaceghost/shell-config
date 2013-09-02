# !/usr/bin/env $SHELL
# This is loaded on
# Shell-independent configuration belongs here.
# This is sourced by bash_profile and bashrc.
#
# TODO: Locate number of cores automagically. Subtract 1||2
MAKEFLAGS="-j8"
ARCHFLAGS="-arch x86_64"

# Local executables take precedence.
#echo $PATH
#/usr/gnu/bin:/usr/local/bin:/bin:/usr/bin:.
# PATH=/usr/local/bin:$PATH

# Chruby. Yeah, it's cool.
# TODO: Detect chruby before sourcing it.
# Suggest a means of installing it should it not be found.
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

export EDITOR=$(which vim)

if [ -f "$HOME/.damballa" ]; then
  source "$HOME/.damballa"
fi
