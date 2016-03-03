# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :sandstorm do |sandstorm|

    sandstorm.vm.box = "debian/jessie64"

    sandstorm.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--usb", "off"]
      vb.customize ["modifyvm", :id, "--usbehci", "off"]
    end

    sandstorm.vm.hostname = 'sandstorm.172.19.22.22.xip.io'
    sandstorm.vm.network "private_network", ip: "172.19.22.22"

    # Setup a loop device so we can test debops.cryptsetup in Vagrant
    sandstorm.vm.provision "shell", inline: <<-EOF
      if [ ! -f "/tmp/loop0-file" ]; then
        dd if=/dev/zero of=/tmp/loop0-file bs=1M count=1000
      fi
      if [ ! -e "/dev/loop0" ]; then
        losetup /dev/loop0 /tmp/loop0-file
      fi
    EOF

    sandstorm.vm.provision :ansible do |ansible|
      ansible.playbook = "test.yml"
      # ansible.verbose = "vvvv"
      ansible.tags = "filebeat"
      ansible.skip_tags = "ssh"
    end
  end
end
