# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'trusty'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  # forward nginx port
  config.vm.network "forwarded_port", guest: 80, host: 8080

  script = <<SCRIPT
apt-get update
apt-get install -y nginx
ln -s /vagrant/phaser/horse /usr/share/nginx/html/horse
SCRIPT

  # install nginx, symlink to code
  config.vm.provision :shell, inline: script
  end
