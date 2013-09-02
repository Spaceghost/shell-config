#!/usr/bin/env bash
# This is sourced for non-login interactive shells.
# For example, opening a new terminal window in your
# graphical desktop.

# I need to find some better way of determining the preferred shell.
# OS X uses active directory, GNU/Linux uses /etc/passwd. finger is the lowest
# common denominator I know of to find this information. Should I juse use a
# case statement?
PREFERRED_SHELL=$(finger $USER | grep "Shell" | cut -d ':' -f 3 | sed -e 's/^[[:space:]]*//')
if [[ "$0" != "$PREFERRED_SHELL" ]]; then
  exec $PREFERRED_SHELL
fi
SHELL=$PREFERRED_SHELL

echo "I'm excited to be working with you again, $USER."

# Source our shell-independent .profile script.
if [ -f "$HOME/.profile" ]; then
  source "$HOME/.profile"
fi
