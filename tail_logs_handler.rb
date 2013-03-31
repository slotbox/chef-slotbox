require "chef/handler"

class TailLogs < Chef::Handler

  def report
    puts `cat /etc/init/openruko-apiserver.conf`
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
  end

end
