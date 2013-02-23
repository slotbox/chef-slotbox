git "#{node['openruko']['home']}/integration-tests" do
  user node['user']
  group node['group']
  repository "git://github.com/slotbox/integration-tests.git"
  action :checkout
  revision node["versions"]["integration-tests"]
end
