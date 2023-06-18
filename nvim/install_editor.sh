#!/bin/bash

is_mac=$(uname | grep Darwin)

if [[ -n "$is_mac:-" ]]
then
    brew install neovim
else
    echo "Only macOS..."
    exit
fi

