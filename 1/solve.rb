#!/usr/bin/env ruby

content = File.read('./input.txt')

move_up   = content.count "("
move_down = content.count ")"

floor_counter = move_up - move_down

puts "Final floor: #{floor_counter}"
