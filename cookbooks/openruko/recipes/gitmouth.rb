git "#{node['openruko']['home']}/gitmouth" do
  user node['user']
  group node['group']
  repository "https://github.com/openruko/gitmouth.git"
  action :checkout
  revision node["versions"]["gitmouth"]
end

bash "setup-gitmouth" do
  user node['user']
  group node['group']
  cwd   "#{node['openruko']['home']}/gitmouth"
  environment Hash['HOME' => node['home']]

  code <<-EOF
  set -e
  if [ ! -f ./bin/activate ]; then
	make init
  fi
  EOF
end

bash "setup-gitmouth-certs" do
  user node['user']
  group node['group']
  cwd   "#{node['openruko']['home']}/gitmouth"

  code <<-EOF
  rm -fr certs
  echo "\n\n" | make certs
  EOF
end

template "/etc/init/openruko-gitmouth.conf" do
  source "upstart-openruko-gitmouth.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
