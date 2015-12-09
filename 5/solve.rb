#!/usr/bin/env ruby
full_file_path = File.join(File.dirname('__FILE__'), ARGV[0])

def is_nice_part1?(line)
  return false if line.scan(/[aeiou]/).count < 3
  return false unless line.match(/(\w)\1/)
  return false if line.match(/(ab)|(cd)|(pq)|(xy)/)
  
  return true
end

def is_nice_part2?(line)
  return false unless line.match(/(\w\w).*\1/)
  return false unless line.match(/(\w).\1/)
  
  return true
end

nice_strings_part1 = 0
nice_strings_part2 = 0

File.readlines(full_file_path).each do |line|
  nice_strings_part1 += 1 if is_nice_part1?(line)
  nice_strings_part2 += 1 if is_nice_part2?(line)
end

puts "A solution: #{nice_strings_part1}"
puts "B solution: #{nice_strings_part2}"
