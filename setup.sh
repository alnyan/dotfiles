#!/bin/env bash

deps="zsh nvim polybar i3 xsecurelock dmenu escrotum xbacklight amixer feh i3-msg"
pairs="./i3/config:.config/i3/config ./i3/i3rc.sh:.config/i3/i3rc.sh ./i3/polybar.sh:.config/i3/polybar.sh ./i3/workspace-1.json:.config/i3/workspace-1.json ./zshrc:.zshrc ./Xresources:.Xresources ./polybar/config:.config/polybar/config ./nvim/init.vim:.config/nvim/init.vim"

dep_fail() {
    echo "MISSING"
    exit 1
}

file_install() {
    k=$(echo ${p} | cut -d: -f1 | xargs readlink -f);
    v="${HOME}/$(echo ${p} | cut -d: -f2)";
    vd=$(dirname ${v});
    mkdir -p ${vd};
    if [[ ${2} == "hard" ]]; then
        echo "-- COPY \"${k}\" to \"${v}\"";
        if [[ ! -f "${v}" ]]; then
            cp ${k} ${v} || exit 1;
        else
            echo "  Already exists";
        fi
    else
        echo "-- LINK \"${v}\" to \"${k}\"";
        if [[ ! -f "${v}" ]]; then
            ln -s ${k} ${v} || exit 1;
        else
            echo "  Already exists";
        fi;
    fi;
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

# Install dotfiles

for p in ${pairs}; do
    file_install ${p} ${1};
done
