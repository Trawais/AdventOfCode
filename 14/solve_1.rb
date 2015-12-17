#!/usr/bin/env ruby
fail 'Script needs two parametes: <input_file> <time_limit>' if ARGV.length != 2
lines = File.readlines(ARGV[0]).map(&:strip)
total_seconds = ARGV[1].to_i

def count_distance(speed, time, rest_time, total_seconds)
  distance = 0
  while total_seconds >= 0
    if time < total_seconds
      distance += (speed * time)
    else
      distance += (speed * total_seconds)
    end
    total_seconds -= (time + rest_time)
  end
  distance
end

longest_distance = 0
lines.each do |line|
  line =~ /fly (?<speed>\d+) .*for (?<run>\d+) .*for (?<rest>\d+)/
  speed = Regexp.last_match[:speed].to_i
  running_time = Regexp.last_match[:run].to_i
  resting_time = Regexp.last_match[:rest].to_i
  distance = count_distance(speed, running_time, resting_time, total_seconds)
  longest_distance = distance if distance > longest_distance
end

puts longest_distance
