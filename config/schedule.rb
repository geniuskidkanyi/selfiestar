env :PATH, ENV['PATH']
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "log/cron_log.log"
#
 every 1.day, :at => '9:30 am'  do
#   command "/usr/bin/some_great_command"
  #  runner "Winner.create"
  rake "winner:create_winner"
 end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
