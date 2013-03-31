require "chef/handler"

class TailLogs < Chef::Handler

  def initialize
    Chef::Log.info "******************"
    Chef::Log.info "Openruko logs"
    Chef::Log.info "******************"
  end

  def report
    `sudo service openruko-apiserver start`
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
    `ls -al /etc/init/`
  end

end
