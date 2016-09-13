#!/usr/bin/env ruby
# encoding: utf-8

#
# FIRST RUN receive_logs_direct.rb
#
# TO RUN THIS FILE:
# ruby emit_log_topic.rb "Testinggg"

# TO EMIT A LOG WITH A ROUTING KEY "kern.critical" TYPE:
# $ ruby -rubygems emit_log_topic.rb "kern.critical" "A critical kernel error"

require "bunny"

conn = Bunny.new
conn.start

ch       = conn.create_channel
x        = ch.topic("topic_logs")
severity = ARGV.shift || "anonymous.info"
msg      = ARGV.empty? ? "Hello World!" : ARGV.join(" ")

x.publish(msg, :routing_key => severity)
puts " [x] Sent #{severity}:#{msg}"

conn.close
