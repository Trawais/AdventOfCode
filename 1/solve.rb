#!/usr/bin/env ruby

content = File.read('./input.txt')

floor_counter = 0
position = 1
first_time = true

content.split("").each do |e|
  if e == '('
    floor_counter += 1
  elsif e == ')'
    floor_counter -= 1
  else
    puts "invalid symbol: #{e}"
  end
  
  if floor_counter == -1 && first_time
    puts "Position of -1 floor: #{position}"
    first_time = false
  end
  
  position += 1
end

puts "Final floor: #{floor_counter}"