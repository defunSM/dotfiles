#!/usr/bin/env bash
set -euo pipefail

# Install paru


function install_paru {
    pacman -S --needed base-devel sudo
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

function install_dependencies {
    paru -S emacs alacritty bspwm picom polybar vagrant sxhkd nvim stow zsh chromium vagrant qemu ebtables dnsmasq bridge-utils virt-manager libvirt
}

function setup_doom_emacs {
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

function setup_oh_my_zsh {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function setup_development_env {
    vagrant plugin install vagrant-vbguest vagrant-libvirt
    systemctl start libvirtd
    systemctl enable libvirtd
}

install_paru
install_dependencies
setup_doom_emacs
setup_oh_my_zsh
