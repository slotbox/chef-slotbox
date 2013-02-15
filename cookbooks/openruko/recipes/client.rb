script "install-slotbox-cli" do
  interpreter "bash"

  code <<-EOF
    GEM_HOME=/home/rukosan/.gem/ruby/1.9.1 gem install slotbox --no-rdoc --no-ri --version #{node["versions"]["client"]}
  EOF

  not_if "gem which slotbox"
end
