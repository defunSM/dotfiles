#!/usr/bin/env bash

pacman -Syu <<< 'Y'
pacman -S git <<< 'Y'
sudo -u vagrant git clone https://github.com/defunSM/dotfiles.git

#sudo sh /home/vagrant/dotfiles/install.sh
