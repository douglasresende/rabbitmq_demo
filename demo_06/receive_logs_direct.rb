#!/usr/bin/env ruby
# encoding: utf-8

#
# THIS FILE NEED KEEP RUNNING TO WORK
#
# TO RUN THIS FILE:
# ruby receive_logs_direct.rb warning error

require "bunny"

if ARGV.empty?
  abort "Usage: #{$0} [info] [warning] [error]"
end

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.direct("direct_logs")
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
