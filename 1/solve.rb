#!/usr/bin/env ruby

input_file = File.join(File.dirname(__FILE__), 'input.txt')
content = File.read(input_file)

floor_counter = 0
position = 1
first_time = true

content.each_char do |c|
  if c == '('
    floor_counter += 1
  elsif c == ')'
    floor_counter -= 1
  else
    puts "invalid symbol: #{c}"
  end

  if floor_counter == -1 && first_time
    puts "Position of -1 floor: #{position}"
    first_time = false
  end

  position += 1
end

puts "Final floor: #{floor_counter}"
