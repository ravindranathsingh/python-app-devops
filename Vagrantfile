Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.synced_folder ".", "/vagrant"

  vm_specs = [
    { name: "master", memory: 6144, cpus: 3, ip: "192.168.56.10" },
    { name: "worker", memory: 6144, cpus: 3, ip: "192.168.56.11" },
  ]

  vm_specs.each do |spec|
    config.vm.define spec[:name] do |machine|
      machine.vm.hostname = spec[:name]
      machine.vm.network "private_network", ip: spec[:ip]

      machine.vm.provider "virtualbox" do |vb|
        vb.name = spec[:name]
        vb.memory = spec[:memory]
        vb.cpus = spec[:cpus]
        vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
        vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
      end
      machine.vm.provision "shell", inline: "bash /vagrant/scripts/bootstrap.sh"
    end
  end
end
