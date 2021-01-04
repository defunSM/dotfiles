# dotfiles
Quick install for linux development environment (arch linux)
This will set up dependencies on arch linux, doom emacs, oh my zsh and other dot files.

<code>
    
    sh install.sh
 
</code>

## Purpose

This repo holds files that helps jumpstart my personal arch linux configurations. 
Both on baremetal and also using QEMU/KVM to automate creating a developmental arch linux development VM.

## Usage

#### Setting up a test vm with arch linux

Installs vagrant on arch linux

Note: DO not plugin install vagrant-share BUG (https://github.com/hashicorp/vagrant/issues/10022)

#### Setting up QEMU/KVM and libvirt

Arch linux Wiki for setting it up -> https://wiki.archlinux.org/index.php/QEMU

#### Setting up vagrant on arch linux host

<code>
    
    pacman -S fmt libvirt virt-manager base-devel qemu
    vagrant init archlinux/archlinux
    vagrant plugin install vagrant-vbguest vagrant-mutat vagrant-libvirt
    
</code>

#### Cloning repo to get vagrantfile and bootstrap.sh (Can delete the dotfiles on host)
<code>
    
    cd arch-vagrant-vm
    git clone https://github.com/defunSM/dotfiles.git

</code>

#### Define a storage pool using virsh
I called my pool storage Downloads if you name it something else make sure to change it in Vagrantfile as well.

<code>
    
    sudo virsh pool-define-as Downloads
    sudo virsh pool-build Downloads
    sudo virsh pool-start Downloads
    sudo virsh pool-autostart Downloads
    
</code>

### Start up vagrant
<code>
    
    vagrant up

</code>

Vagrant crash Course: https://www.youtube.com/watch?v=vBreXjkizgo

