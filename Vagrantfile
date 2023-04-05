# -*-mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
disks = [
  # ['caserver01_disks/disk1.vdi', 20480],
  ['caserver01_disks/disk2.vdi', 1024],
  ['caserver01_disks/disk3.vdi', 1024],
  ['caserver01_disks/disk4.vdi', 2048],
  ['caserver01_disks/disk5.vdi', 6144]
]

Vagrant.require_version ">=2.3.0"

Vagrant.configure("2") do |config|
  config.vm.define "cafwbackend" do |cafwbackend|
    cafwbackend.vm.box = "debian/bullseye64"
    cafwbackend.vm.network "private_network", ip: "192.168.10.1", netmask:"255.255.255.224", virtualbox__intnet: "vagrant_net"
    cafwbackend.vm.network "private_network", ip: "192.168.10.33", netmask:"255.255.255.224", virtualbox__intnet: "vagrant_net"
    cafwbackend.vbguest.auto_update = true
  end
  config.vm.define "cafwfrontend" do |cafwfrontend|
    cafwfrontend.vm.box = "debian/bullseye64"
    # No tiene nick lan / tiene NIC DMZ
    cafwfrontend.vm.network "private_network", type: "dhcp"
    cafwfrontend.vm.network "private_network", ip: "192.168.10.34", netmask:"255.255.255.224", virtualbox__intnet: "vagrant_net"
    cafwfrontend.vbguest.auto_update = true
  end
  config.vm.define "caserver01" do |caserver01|
    caserver01.vm.box = "debian/bullseye64"
    caserver01.vm.provider :virtualbox
    caserver01.vm.network "private_network", ip: "192.168.10.2", netmask:"255.255.255.224", virtualbox__intnet: "vagrant_net"
    caserver01.vbguest.auto_update = true
    disks.each do |disk|
      disk_path = disk[0]
      disk_size = disk[1]

      caserver01.vm.provider "virtualbox" do |vb|
        unless system("vboxmanage list hdds | grep -q '#{disk_path}'")
          vb.customize ['createhd', '--filename', disk_path, '--variant', 'Fixed', '--size', disk_size]
        end
          vb.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port',  disks.index(disk) + 1, '--device', 0, '--type', 'hdd', '--medium', disk_path]
        end
      end

  end
  config.vm.define "caserver02" do |caserver02|
    caserver02.vm.box = "debian/bullseye64"
    caserver02.vm.network "private_network", type: "dhcp"
   # caserver02.vm.network "private_network", ip: "192.168.10.2"
    caserver02.vbguest.auto_update = true
  end
  config.vm.define "cait" do |cait|
    cait.vm.box = "centos/7"
    cait.vm.network "private_network", type: "dhcp"
    #cait.vm.network "private_network", ip: "192.168.10.2"
    cait.vbguest.auto_update = true
  end
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provisioning/playbook.yml"
    ansible.version = "latest"
    ansible.groups = {
      "firewall" => ["cafwbackend", "cafwfrontend"],
    }

  end

end
