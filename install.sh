#!/usr/bin/env bash
#set -euo pipefail

ask() {
    # from https://djm.me/ask
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
        echo -n "$1 [$prompt] "
        read reply </dev/tty

        if [ -z "$reply" ]; then
            reply=$default
        fi

        case "$reply" in
			[Yy]*) return 0  ;;
            [Nn]*) return  1 ;;
        esac

    done
}

function linkDir {
	rm -rf $2;
	mkdir -p "${2%/*}"
	ln -sf $1 $2
}

function fileToList {
    echo $(cat $1 | sed ':a;N;$!ba;s/\n/ /g')
}

function copyToDir {
	echo $2 | sed 's%/[^/]*$%/%' | xargs mkdir -p
	cp $1 $2
}

function install_yay {
    git clone https://aur.archlinux.org/yay.git
    pushd yay
    makepkg -si
    popd
    sudo rm -dRf yay/
}

function initialize {
    sudo pacman -Syu
    sudo pacman -S wget git base-devel net-tools gnome xorg emacs htop zsh networkmanager networkmanager-openvpn
}

function install_emacs {
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

function install_config {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo ln -sf "$PWD"/etc/pacman.conf /etc/pacman.conf
    sudo ln -sf "$PWD"/xinitrc/.xinitrc ~/.xinitrc
    ln -sf "$PWD"/zshrc/.zshrc ~/.zshrc
    ln -sf "$PWD"/.doom.d/config.el ~/.doom.d/config.el
    ln -sf "$PWD"/.doom.d/init.el ~/.doom.d/init.el
    ln -sf "$PWD"/.doom.d/packages.el ~/.doom.d/packages.el
    sudo linkDir -sf "$PWD"/zsh /usr/share/zsh
}

function install_extra {
    yay -S virt-manager hddtemp glxinfo hardinfo lm-sensors vlc hddtemp glxinfo hardinfo vlc stacer
}

initialize
install_yay
install_emacs
install_config
install_extra
