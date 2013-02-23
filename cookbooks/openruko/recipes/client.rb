script "install-slotbox-cli" do
  interpreter "bash"

  code <<-EOF
    sudo su - #{node['user']} -c 'gem install slotbox --no-rdoc --no-ri --version #{node["versions"]["client"]}'
  EOF

  not_if "gem which slotbox"
end
