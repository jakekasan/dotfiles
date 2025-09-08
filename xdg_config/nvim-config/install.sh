if [[ -n "${XDG_CONFIG+x}" ]]; then
    CONFIG_HOME=$XDG_CONFIG
else
    CONFIG_HOME="$HOME/.config"
fi

TARGET="$CONFIG_HOME/nvim"

SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "ln -sfF $SCRIPT_PATH/nvim $TARGET"
