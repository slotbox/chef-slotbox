package "expect"
package "curl"
package "wget"
package "socat"
package "postgresql-server-dev-9.1"
package "postgresql-contrib-9.1"
package "uuid-dev"
package "libssl0.9.8"
# For some reason LXC won't install via chef, it seems to be this particular command
# `apt-get -q -y install lxc=0.7.5-3ubuntu67' that fails, this could be a temporary issue,
# but for now let's just install with straight up bash isntead.
#package "lxc"
bash "setup mymachine.me domain" do
  user "root"
  code <<-EOF
  apt-get install lxc
  EOF
end


directory node['openruko']['home'] do
  user node['user']
  group node['group']
  mode 0755
end

bash "setup mymachine.me domain" do
  user "root"
  code <<-EOF
  echo "127.0.0.1 mymachine.me" >> /etc/hosts
  echo "127.0.0.1 openruko.mymachine.me" >> /etc/hosts
  echo "127.0.0.1 hello-world.mymachine.me" >> /etc/hosts
  echo "127.0.0.1 keepgreen.mymachine.me" >> /etc/hosts
  EOF

  not_if "grep 'mymachine.me' /etc/hosts"
end

template "/etc/profile.d/openruko.sh" do
  source "profile-openruko.erb"
  owner "root"
  group "root"
  mode 0755
end

template "/etc/init/openruko.conf" do
  source "upstart-openruko.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

include_recipe "openruko::apiserver"
include_recipe "openruko::httprouting"
include_recipe "openruko::dynohost"
include_recipe "openruko::logplex"
include_recipe "openruko::rukorun"
include_recipe "openruko::codonhooks"
include_recipe "openruko::gitmouth"
include_recipe "openruko::client"
include_recipe "openruko::integration-tests"

service "openruko" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
  action [:enable, :start]
end
