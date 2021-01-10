Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 2
  end
  config.vm.provision "shell", path: "provision.sh"
  config.vm.network "forwarded_port", guest: 5900, host: 5900
end
