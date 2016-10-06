# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# webwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/trusty64"

    web.vm.provision :shell, :path => "bootstrap.sh"

    web.vm.network "private_network", ip: "192.168.100.3"
    web.vm.network "forwarded_port", guest: 8983, host: 8983
    web.vm.network "forwarded_port", guest: 80, host: 8080
    web.vm.network "public_network"
    web.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end
  end
end
