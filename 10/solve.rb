#!/usr/bin/env ruby
input_string = "3113322113"

def look_and_say(input_string)
  new_string = ''
  previous_char = input_string[0]
  count = 0
  input_string.each_char do |char|
    if char == previous_char
      count += 1
    else
      new_string << "#{count}#{previous_char}"
      previous_char = char
      count = 1
    end
  end
  new_string << "#{count}#{previous_char}"
end

50.times do
  input_string = look_and_say(input_string)
end

puts input_string.length
