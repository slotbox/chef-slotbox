require "chef/handler"

class TailLogs < Chef::Handler

  def report
    `service openruko-apiserver start`
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
  end

end
