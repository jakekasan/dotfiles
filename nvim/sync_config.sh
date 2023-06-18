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
        rm "$config_dir"
    else
        echo "Is a directory"
        rm -rf "$config_dir"
    fi
else
    echo "Doesn't exist..."
fi

echo "Symlinking to config directory..."
ln -s ./config/nvim "$config_symlink" 

