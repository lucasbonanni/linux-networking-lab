# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "cafwbackend" do |cafwbackend|
    cafwbackend.vm.box = "debian/bullseye64"
    cafwbackend.vm.network "private_network", ip: "192.168.10.1"
    cafwbackend.vbguest.auto_update = true
  end
  config.vm.define "cafwfrontend" do |cafwfrontend|
    cafwfrontend.vm.box = "debian/bullseye64"
    # No tiene nick lan / tiene NIC DMZ
    # cafwbackend.vm.network "private_network", ip: "192.168.10.1"
    cafwfrontend.vbguest.auto_update = true
  end
  config.vm.define "caserver01" do |caserver01|
    caserver01.vm.box = "debian/bullseye64"
    caserver01.vm.network "private_network", ip: "192.168.10.2"
    caserver01.vbguest.auto_update = true
  end
  config.vm.define "caserver02" do |caserver02|
    caserver02.vm.box = "debian/bullseye64"
   # caserver02.vm.network "private_network", ip: "192.168.10.2"
    caserver02.vbguest.auto_update = true
  end
  config.vm.define "cait" do |cait|
    cait.vm.box = "centos/7"
    #cait.vm.network "private_network", ip: "192.168.10.2"
    cait.vbguest.auto_update = true
  end


end
