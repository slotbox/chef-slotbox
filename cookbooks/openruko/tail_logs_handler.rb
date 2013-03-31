module Openruko
  class TailLogs < Chef::Handler

    def initialize
      puts "******************"
      puts "Openruko logs"
      puts "******************"
    end

    def report
      `tail /var/log/openruko/*`
      `tail /var/log/fakes3.log`
    end

  end
end