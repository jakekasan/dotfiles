#!/bin/bash

if [[ -n $XDG_DATA_HOME ]]
then
    data_home="$HOME/.local/share"
else
    data_home=$XDG_DATA_HOME
fi

echo "Data home set to '$data_home'"

echo "Cloning neovim..."

git clone http://github.com/neovim.neovim.git "$data_home/neovim"

cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

