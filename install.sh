#!/usr/bin/env bash
#set -euo pipefail

# Install paru


function install_paru {
    printf '\nY\n1\n' | pacman -S --needed base-devel
    sudo -u vagrant git clone https://aur.archlinux.org/paru.git
    cd paru
    printf '1\nY\nY\nY\nY\n' | sudo -u vagrant makepkg -si
}

function install_dependencies {
    sudo pacman -S base-devel emacs ly alacritty bspwm picom polybar vagrant sxhkd python-pynvim stow zsh chromium vagrant qemu ebtables dnsmasq bridge-utils virt-manager libvirt
}

function setup_doom_emacs {
    sudo -u vagrant git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    sudo -u vagrant ~/.emacs.d/bin/doom install
}

function setup_oh_my_zsh {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function setup_development_env {
    sudo -u vagrant vagrant plugin install vagrant-vbguest vagrant-libvirt
    systemctl start libvirtd
    systemctl enable libvirtd
}

install_paru && install_dependencies && setup_doom_emacs && setup_oh_my_zsh
