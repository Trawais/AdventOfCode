#!/usr/bin/env ruby
def parse_line_part_1(line)
  cloned_line = line.clone
  cloned_line.sub!(/^"(.*)"$/, '\1')          # remove starting and ending double-quotes
  cloned_line.gsub!(/\\\\/, 'B')              # replace \\ -> \ (1 char insted of 2)
  cloned_line.gsub!(/\\"/, 'D')               # replace \" -> " (1 char insted of 2)
  cloned_line.gsub!(/\\x[0-9abcdef]{2}/, 'H') # Hexadecimal numbers (1 char insted of 4)
  cloned_line
end

def parse_line_part_2(line)
  cloned_line = line.clone
  cloned_line.gsub!(/^(.*)$/, 'A\1Z')             # Add starting and ending double-quotes
  cloned_line.gsub!(/\\x[0-9abcdef]{2}/, 'Hexad') # Hexadecimal numbers (5 chars insted of 4)
  cloned_line.gsub!(/"/, 'Dq')                    # replace " -> \" (2 chars insted of 1)
  cloned_line.gsub!(/\\/, 'Ba')                   # replace \ -> \\ (2 chars insted of 1)
  cloned_line
end

sum_part_1 = 0
sum_part_2 = 0
File.readlines(ARGV[0]).each do |line|
  line.strip!
  sum_part_1 += line.length - parse_line_part_1(line).length
  sum_part_2 += parse_line_part_2(line).length - line.length
end

puts sum_part_1
puts sum_part_2
