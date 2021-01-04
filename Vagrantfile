# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: true  #

  config.vm.provider :libvirt do |libvirt|
    libvirt.storage_pool_name="Downloads"
    libvirt.driver="kvm"
    libvirt.uri="qemu:///system"
    libvirt.cpus = 24
    libvirt.cputopology :sockets => '1', :cores => '12', :threads => '2'
    libvirt.memory = 12000
    libvirt.cpu_mode = 'host-passthrough'
  end

  config.vm.define :test_vm do |test_vm|
    test_vm.vm.box = "archlinux/archlinux"
  end

  config.vm.provision "shell", path: "bootstrap.sh"
end
