#!/usr/bin/env ruby
lines = File.readlines(ARGV[0])

def is_nice?(input_string)
  return false if input_string.scan(/[aeiou]/).count < 3
  return false unless input_string.match(/(\w)\1/)
  return false if input_string.match(/ab/)
  return false if input_string.match(/cd/)
  return false if input_string.match(/pq/)
  return false if input_string.match(/xy/)
  
  return true
end

def is_nice_2?(input_string)
  return false unless input_string.match(/(\w\w).*\1/)
  return false unless input_string.match(/(\w).\1/)
  
  return true
end

nice_strings = 0
nice_strings_2 = 0

lines.each do |line|
  if is_nice?(line)
    nice_strings += 1
  end
  
  if is_nice_2?(line)
    nice_strings_2 += 1
  end
end

puts nice_strings
puts is_nice?('ahoj')
puts is_nice?('jaksemas')
puts is_nice?('xxxx')
puts is_nice?('xaxexixx')
puts is_nice?('aaa')
puts is_nice?('ugknbfddgicrmopn')

puts nice_strings_2
puts is_nice_2?('qjhvhtzxzqqjkmpb') #true
puts is_nice_2?('xxyxx') #true
puts is_nice_2?('uurcxstgmygtbstg') #false
puts is_nice_2?('ieodomkazucvgmuy') #false
