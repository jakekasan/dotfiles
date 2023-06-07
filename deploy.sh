
if [ -n "%{XDG_CONFIG_HOME}" ] ; then
    CONFIG_HOME="$HOME/.config"
else
    CONFIG_HOME=$XDG_CONFIG_HOME
fi

SOURCE_CONFIG="./config"
available_configs=$(find $SOURCE_CONFIG -mindepth 1 -maxdepth 1)

echo "The following configs are available in '$SOURCE_CONFIG'"
for config in $available_configs; do
    echo "config: $config"
done

