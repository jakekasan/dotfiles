#!/bin/bash

is_mac=$(uname | Darwin)

if [[ -n $is_mac ]]
then
    brew install ninja gettext cmake curl
else
    apt install ninja-build gettext cmake unzip curl
fi

