# -*- mode: ruby -*-
# vi: set ft=ruby :
root      = File.expand_path("..", __FILE__)
solo_json = File.join(root, "solo.json")

Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Allow access to the VM's IP from host
  config.vm.network :bridged

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'

    chef.json = JSON.parse(File.open(solo_json, &:read))

    # Override solo.json to use vagrant user
    chef.json["user"] = "vagrant"
    chef.json["group"] = "vagrant"
    chef.json["home"] = "/home/vagrant"
    chef.json["openruko"]["home"] = "/home/vagrant/openruko"
    chef.json["openruko"]["password"] = "vagrant"
    chef.json["fakes3"]["user"] = "vagrant"
    chef.json["fakes3"]["group"] = "vagrant"
    chef.json["postgresql"]["password"]["vagrant"] = "vagrant"
    chef.json["proxy"]["http_proxy"] = ENV['HTTP_PROXY']
    chef.json["proxy"]["https_proxy"] = ENV['HTTPS_PROXY']
    chef.json["proxy"]["no_proxy"] = "mymachine.me," + (ENV['NO_PROXY'] || '')

    chef.json["run_list"].each do |recipe_name|
      chef.add_recipe recipe_name
    end
  end

  config.vm.provision :shell, :inline => "source /etc/profile; cd openruko/integration-tests && sudo -u vagrant -E env HOME=/home/vagrant bash run.sh"
end

# If you want to do some funky custom stuff to your box, but don't want those things tracked by git,
# add a Vagrantfile.local and it will be included. For example you could mount your dev version of
# openruko with;
# config.vm.share_folder "openruko", "/home/rukosan/openruko_mount", "~/Software/openruko"
# Then symlink the various repos you're hacking on to see changes straight away on the live box.
load "./Vagrantfile.local" if File.exists? "Vagrantfile.local"
