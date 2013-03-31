module Openruko
  class TailLogs < Chef::Handler

    def report
      puts "******************"
      puts "Openruko logs"
      puts "******************"
      `tail /var/log/openruko/*`
      `tail /var/log/fakes3.log`
    end

  end
end