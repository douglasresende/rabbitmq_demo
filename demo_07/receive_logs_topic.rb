#!/usr/bin/env ruby
# encoding: utf-8

#
# THIS FILE NEED KEEP RUNNING TO WORK
#
# TO RUN THIS FILE:
# ruby receive_logs_topic.rb "#"

# OTHER EXAMPLES TO USER THIS FILE
# TO RECEIVE ALL THE LOGS:
# $ ruby -rubygems receive_logs_topic.rb "#"

# TO RECEIVE ALL LOGS FROM THE FACILITY "kern":
# $ ruby -rubygems receive_logs_topic.rb "kern.*"

# OR IF YOU WANT TO HEAR ONLY ABOUT "critical" LOGS:
# $ ruby -rubygems receive_logs_topic.rb "*.critical"

# YOU CAN CREATE MULTIPLE BINDINGS:
# $ ruby -rubygems receive_logs_topic.rb "kern.*" "*.critical"

require "bunny"

if ARGV.empty?
  abort "Usage: #{$0} [binding key]"
end

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.topic("topic_logs")
q   = ch.queue("", :exclusive => true)

ARGV.each do |severity|
  q.bind(x, :routing_key => severity)
end

puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
