# -*- mode: ruby -*-
# vi: set ft=ruby :
# Specify Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

unless Vagrant.has_plugin?('vagrant-vbguest')
  system('vagrant plugin install vagrant-vbguest') || exit!
  exit system('vagrant', *ARGV)
end

unless Vagrant.has_plugin?('vagrant-hostmanager')
  system('vagrant plugin install vagrant-hostmanager') || exit!
  exit system('vagrant', *ARGV)
end

# Create and configure the VM(s)
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "wesm/ubuntu1404-desktop"

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true

    config.vm.provider "virtualbox" do |v|
        v.name = "ubuntu"
        v.memory = "4096"
        v.cpus = 2
        v.gui = true
    end

    config.vm.network "private_network", ip: "172.170.1.10"

    config.vm.define "ubuntu" do |c7d|
    end

    # Assign a friendly name to this host VM
    config.vm.hostname = "ubuntu"

    # Skip checking for an updated Vagrant box
    config.vm.box_check_update = true

    # Always use Vagrant's default insecure key
    config.ssh.insert_key = false

#sudo apt-get update -y &&\
#sudo apt-get upgrade -y &&\
#sudo apt-get install -y zsh git-core vim terminator &&\
#wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh &&\
#git clone https://github.com/powerline/fonts.git &&\
#./fonts/install.sh &&\
#chsh -s `which zsh` &&\
#sudo apt-get clean &&\
#sudo apt-get autoclean &&\
#sudo apt-get autoremove
#curl -fsSL https://get.docker.com/ | sh

end
