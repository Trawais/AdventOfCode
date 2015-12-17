#!/usr/bin/env ruby
lines = File.readlines(ARGV[0]).map(&:strip)
total_seconds = 2503

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

def parse_line(line)
  line.match(/fly (\d+) .*for (\d+) .*for (\d+)/)
end

longest_distance = -1
lines.each do |line|
  match = parse_line(line)
  distance = count_distance(match[1].to_i, match[2].to_i, match[3].to_i, total_seconds)
  longest_distance = distance if distance > longest_distance
end

puts longest_distance
