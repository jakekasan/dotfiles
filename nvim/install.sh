#!/bin/bash


if [[ -n "$XDG_CONFIG_HOME:-" ]] 
then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi
is_mac=$(uname | grep Linux)

if [[ -n "$is_mac:-" ]]
then
    echo "On Mac"
    brew install neovim
else
    echo "On Linux"
    apt install -y neovim
fi

