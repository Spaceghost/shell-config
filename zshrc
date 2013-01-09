#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Johnneylee Jack Rollins <Johnneylee.Rollins@gmail.com>
#

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerline"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/lib/lightdm/lightdm:/usr/games:/usr/local/games
# Customizations

# source ~/.profile
# source ~/.zshenv

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

