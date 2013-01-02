git "/home/rukosan/openruko/apiserver" do
  user "rukosan"
  group "rukosan"
  repository "https://github.com/openruko/apiserver.git"
  action :checkout
end

bash "setup-apiserver" do
  user  "rukosan"
  cwd   "/home/rukosan/openruko/apiserver"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  set -e
  make init
  echo -e '\n\n\n\n\n\n\n\n' | make certs
  echo -e '\ny' | ssh-keygen -t rsa -N ''
  EOF
end

bash "setup-postgres" do
  code <<-EOF
  sudo -u postgres psql <<< "CREATE ROLE rukosan PASSWORD 'md5d59d27ea95747738c8b9e5cfd0882e60' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;"
  EOF
end

bash "setup" do
  user "rukosan"
  cwd "/home/rukosan/openruko/apiserver/postgres"
  environment Hash['HOME' => '/home/rukosan']

  code <<-EOF
  echo -e "openruko\nrukosan\nopenruko@openruko.com\nrukosan" | ./setup
  EOF
end

template "/etc/init/openruko-apiserver.conf" do
  source "upstart-openruko-apiserver.conf.erb"
  owner "root"
  group "root"
  mode 0644
end
