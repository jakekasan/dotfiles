
if [[ -n "$XDG_CONFIG_HOME:-" ]] 
then
    config_dir="$HOME/.config"
else
    config_dir=$XDG_CONFIG_HOME
fi


if [[ -n "$XDG_DATA_HOME:-" ]] 
then
    data_dir="$HOME/.local/share"
else
    data_dir=$XDG_DATA_HOME
fi

echo "Data dir set to: '$data_dir'"

echo "Installing packer..."

packer_home="$data_dir/nvim/site/pack/packer"

if [ -d $packer_home ]
then
    echo "Packer already exists at '$packer_home', deleting..."
else
    echo "Packer doesn't exist at '$packer_home'"
fi

echo "Cloning packer.nvim"
git clone --depth 1 "https://github.com/wbthomson/packer.nvim" "$data_dir/nvim/site/pack/packer/start/packer.nvim"

echo "Installing packages"
nvim --noplugin \
    -c "edit $config_dir/nvim/lua/jake/packer.lua" \
    -c "so %" \
    -c "PackerSync"


