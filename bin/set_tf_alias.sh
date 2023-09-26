#!/usr/bin/env bash

# Define the alias
alias_to_add='alias tf="terraform"'

# Check if .bash_profile exists
bash_profile="$HOME/.bash_profile"

if [ -f "$bash_profile" ]; then
  # Check if the alias already exists in .bash_profile
  if grep -q "$alias_to_add" "$bash_profile"; then
    echo "The alias 'tf=\"terraform\"' already exists in $bash_profile."
  else
    # Add the alias to .bash_profile
    echo "$alias_to_add" >> "$bash_profile"
    source "$bash_profile"  # Activate the alias in the current shell
    echo "Alias 'tf=\"terraform\"' added to $bash_profile. You can now use 'tf' as an alias for 'terraform'."
  fi
else
  echo "$bash_profile does not exist. Please create it and add the alias manually."
fi
