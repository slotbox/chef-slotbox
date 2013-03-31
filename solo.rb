root = File.absolute_path(File.dirname(__FILE__))

# Tail logs on build failure
require root + "/tail_logs_handler"
exception_handlers << TailLogs.new

file_cache_path root
cookbook_path root + '/cookbooks'