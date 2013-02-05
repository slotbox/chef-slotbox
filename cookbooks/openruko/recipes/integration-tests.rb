git "#{node['openruko']['home']}/integration-tests" do
  user node['user']
  group node['group']
  repository "git://github.com/openruko/integration-tests.git"
  action :checkout
  revision node["versions"]["integration-tests"]
end
