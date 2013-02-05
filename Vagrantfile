# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Allow access to the VM's IP from host
  config.vm.network :bridged

  # Run chef manually to allow recipes to be used by Vagrant and remote VPSs over `ssh -c'
  config.vm.share_folder "chef", "~/chef", "."
  config.vm.provision :shell, :inline => "cd chef && source bootstrap.sh"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'

    chef.add_recipe 'apt'
    chef.add_recipe 'build-essential'
    chef.add_recipe 'openssl'
    chef.add_recipe 'postgresql::client'
    chef.add_recipe 'postgresql::server'
    chef.add_recipe 'git'
    chef.add_recipe 'nodejs::install_from_package'
    chef.add_recipe 'python'
    chef.add_recipe 'fakes3'
    chef.add_recipe 'openruko'
    chef.add_recipe 'heroku-toolbelt'

    chef.json = {
      :postgresql => {
        :version  => "9.1",
        :listen_addresses => "*",
        :hba => [
          { :method => "trust", :address => "0.0.0.0/0" },
          { :method => "trust", :address => "::1/0" },
        ],
        :password => {
          :postgres => "password"
        }
      },
      :apiserver_key => "ec1a8eb9-18a6-42c2-81ec-c0f0f615280c",
      :s3 => {
        :s3_key => ENV['S3_KEY'] || '123',
        :s3_secret => ENV['S3_SECRET'] || '123',
        :s3_bucket => ENV['S3_BUCKET'] || 'openruko',
        :s3_hostname => 'mymachine.me',
        :s3_port => 4567
      }
    }
  end
end

# If you want to do some funky custom stuff to your box, but don't want those things tracked by git,
# add a Vagrantfile.local and it will be included. For example you could mount your dev version of
# openruko with;
# config.vm.share_folder "openruko", "/home/rukosan/openruko_mount", "~/Software/openruko"
# Then symlink the various repos you're hacking on to see changes straight away on the live box.
load "./Vagrantfile.local" if File.exists? "Vagrantfile.local"
