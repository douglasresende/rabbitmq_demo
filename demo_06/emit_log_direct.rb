#!/usr/bin/env ruby
# encoding: utf-8

#
# FIRST RUN receive_logs_direct.rb
#
# TO RUN THIS FILE:
# ruby emit_log_direct.rb "Testinggg" warning

require "bunny"

conn = Bunny.new
conn.start

ch       = conn.create_channel
x        = ch.direct("direct_logs")
severity = ARGV.shift || "info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

(1..1000).each do |y|
  x.publish(msg, :routing_key => severity)
  puts " [x] Sent #{y}: '#{msg}'"
end

conn.close
