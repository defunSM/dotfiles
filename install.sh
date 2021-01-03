#!/usr/bin/env bash
set -euo pipefail

# Install paru

$ZSH_CUSTOM = "~/.oh-my-zsh"

function install_paru {
    pacman -S --needed base-devel sudo
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
}

function install_dependencies {
    paru -S emacs alacritty bspwm picom polybar sxhkd nvim stow zsh chromium
}

function setup_doom_emacs {
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}

function setup_oh_my_zsh {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
}

install_paru
install_dependencies
setup_doom_emacs
setup_oh_my_zsh
