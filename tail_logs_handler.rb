require "chef/handler"

class TailLogs < Chef::Handler

  def report
    puts `whoami`
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
  end

end
