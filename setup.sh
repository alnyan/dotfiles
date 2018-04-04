#!/bin/env bash

deps="zsh nvim polybar i3 xsecurelock dmenu escrotum xbacklight amixer feh i3-msg"

dep_fail() {
    echo "MISSING"
    exit 1
}

# Check dependencies
echo "Checking dependencies:"
for ent in ${deps}; do
    echo -n "-- ${ent}: "
    which ${ent} >/dev/null 2>&1 || dep_fail
    echo "OK"
done

# Install oh-my-zsh
echo "Installing oh-my-zsh:"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install vim-plug
echo "Installing vim-plug:"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
