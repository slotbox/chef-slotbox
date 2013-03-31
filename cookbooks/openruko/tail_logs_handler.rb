require "chef/handler"

class TailLogs < Chef::Handler

  def initialize
    Chef::Log.info "******************"
    Chef::Log.info "Openruko logs"
    Chef::Log.info "******************"
  end

  def report
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
  end

end
