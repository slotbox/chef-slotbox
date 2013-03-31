require "chef/handler"

class TailLogs < Chef::Handler

  def initialize
    Chef::Log.info "******************"
    Chef::Log.info "Openruko logs"
    Chef::Log.info "******************"
  end

  def report
    `sudo /sbin/start openruko-apiserver`
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
    `cat /home/ubuntu/src/github.com/slotbox/chef-slotbox/chef-stacktrace.out`
  end

end
