git "#{node['openruko']['home']}/codonhooks" do
  user node['user']
  group node['group']
  repository "https://github.com/slotbox/codonhooks.git"
  action :checkout
  revision "v" + node["versions"]["codonhooks"]
end
