#!/usr/bin/env ruby

paper = 0
ribbon = 0

File.readlines('./input.txt').each do |line|
  a = line.split('x').map {|e| e.to_i}
  a.sort!
  
  paper += 2*a[0]*a[1] + 2*a[1]*a[2] + 2*a[0]*a[2]
  paper += a[0]*a[1] #slack of paper
  
  ribbon += 2*a[0] + 2*a[1]
  ribbon += a[0]*a[1]*a[2] #bow
end

puts paper
puts ribbon
