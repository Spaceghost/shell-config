#!/usr/bin/env bash
# This file is executed when logging out of login shells.

if [[ -f "$HOME/.logout" ]]; then
  source "$HOME/.logout"
fi
