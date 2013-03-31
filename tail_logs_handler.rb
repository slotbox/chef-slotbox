require "chef/handler"

class TailLogs < Chef::Handler

  def report
    `sudo service openruko-apiserver start`
    `tail /var/log/openruko/*`
    `tail /var/log/fakes3.log`
    puts `ls -al /etc/init/`
  end

end
