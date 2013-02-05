git "#{node['openruko']['home']}/client" do
  user node['user']
  group node['group']
  repository "https://github.com/openruko/client.git"
  action :checkout
  revision node["versions"]["client"]
end

template "/home/rukosan/.ssh/config" do
  source "ssh-config.erb"
  owner "root"
  group "root"
  mode 0644
end
