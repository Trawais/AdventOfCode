#!/usr/bin/env ruby
require 'digest/md5'

input_string = ARGV[0]
result = 0

loop do
  md5 = Digest::MD5.new
  md5.update("#{input_string}#{result}")
  break if md5.hexdigest.start_with?('000000')
  result += 1
end

puts result
