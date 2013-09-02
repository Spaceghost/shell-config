#!/usr/bin/env bash
# This file is typically sourced when logging into a system.
# But some terminals are pretentious and make every shell an
# interactive login shell. Things to put in here might
# include a greeting. As a note: If this file exists,
# .bash_login and .profile aren't read and executed.
# For example: Logging in via ssh or `bash -l`
#
# Source the .login script if the session is an
# interactive session. .login should only be read in a
# login shell.
#
# We test stdin(0) and the /dev/stdin socket to know
# whether this is an interactive shell or not.
# We already know it's a login shell
if [[ -t "0" || -p /dev/stdin ]]; then
  if [[ -f "$HOME/.login" ]]; then
    source "$HOME/.login"
  fi
fi

# Bash-specific login shell configuration.
# May or may not be interactive.

# Source our shell-independent .profile script.
# If .bash_profile exists, it won't try to read and execute
# the .profile script, but we will. Login shells only.
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi

