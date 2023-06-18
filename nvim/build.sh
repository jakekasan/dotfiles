#!/bin/bash

if [[ -n $XDG_DATA_HOME ]]
then
    data_home=$XDG_DATA_HOME
else
    data_home="$HOME/.local/share"
fi

echo "Data home set to '$data_home'"

nvim_source="$data_home/nvim"

echo "Cloning neovim into '$nvim_source'..."

git clone http://github.com/neovim/neovim.git $nvim_source

cd $nvim_source && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

