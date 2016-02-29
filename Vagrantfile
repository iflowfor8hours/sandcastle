# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "debian/jessie64"

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--usbehci", "off"]
  end

  config.vm.hostname = 'sandstorm.172.19.22.22.xip.io'
  config.vm.network "private_network", ip: "172.19.22.22"

  # Setup a loop device so we can test debops.cryptsetup in Vagrant
  config.vm.provision "shell", inline: <<-EOF
    if [ ! -f "/tmp/loop0-file" ]; then
      dd if=/dev/zero of=/tmp/loop0-file bs=1M count=1000
    fi
    if [ ! -e "/dev/loop0" ]; then
      losetup /dev/loop0 /tmp/loop0-file
    fi
  EOF

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "test.yml"
    # ansible.verbose = "vvvv"
    # ansible.tags = ""
  end

end
