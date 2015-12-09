#!/usr/bin/env ruby

input_file = File.join(File.dirname(__FILE__), 'input.txt')
content = File.read(input_file)

floor_counter = 0
position = 1
found_cellar = false

content.each_char do |c|
  case c
  when '('
    floor_counter += 1
  when ')'
    floor_counter -= 1
  else
    puts "invalid symbol: #{c}"
  end
  
  unless found_cellar
    if floor_counter == -1
      found_cellar = true
    else
      position += 1
    end
  end
end

puts "Final floor: #{floor_counter}"
puts "Cellar reached after: #{position}"
