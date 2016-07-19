# -*- mode: ruby -*-
# vi: set ft=ruby :
# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# run this first:
# vagrant plugin install vagrant-vbguest
# vagrant plugin install vagrant-hostmanager

# Create and configure the VM(s)
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "box-cutter/ubuntu1404-desktop"

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.provider "virtualbox" do |v|
        v.name = "ubuntu"
        v.memory = "3096"
        v.cpus = 2
        v.gui = true
    end

    config.vm.define "ubuntu" do |c7d|
    end

    # Assign a friendly name to this host VM
    config.vm.hostname = "ubuntu"

    # Skip checking for an updated Vagrant box
    config.vm.box_check_update = true

    # Always use Vagrant's default insecure key
    config.ssh.insert_key = false

    config.vm.provision "shell", inline: "sudo apt-get update -y"
    #config.vm.provision "shell", inline: "sudo apt-get install -y zsh git-core vim"
    #config.vm.provision "shell", inline: "wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh"
    #config.vm.provision "shell", inline: "chsh -s `which zsh`"
    #config.vm.provision "shell", inline: "git clone https://github.com/powerline/fonts.git"
    #config.vm.provision "shell", inline: "sudo shutdown -r 0"
end
