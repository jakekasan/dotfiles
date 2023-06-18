#!/bin/bash
#

if [[ -n "$XDG_CONFIG_HOME:-" ]] 
then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi

config_symlink="$config_dir/nvim"

echo "Checking config symlink '$config_symlink'"

if [ -d "$config_symlink" ]
then
    echo "Exists..."
    if [ -L "$config_symlink" ]
    then
        echo "Is a symlink"
    else
        echo "Is a directory"
    fi
else
    echo "Doesn't exist..."
fi

