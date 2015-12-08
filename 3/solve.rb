#!/usr/bin/env ruby

class Santa
  def initialize
    @houses = Hash.new(0)
    @x = 0
    @y = 0
    @houses["#{@x}#{@y}"] += 1
  end

  def make_move(move)
    case move
    when '^'
      @y += 1
    when 'v'
      @y -= 1
    when '>'
      @x += 1
    when '<'
      @x -= 1
    end
    @houses["#{@x}#{@y}"] += 1
  end
  
  def visited_houses
    @houses.count
  end
  
  def get_keys
    @houses.keys
  end
end

counter = 0
santa = Santa.new
robo_santa = Santa.new
content = File.read(ARGV[0])
content.split('').each do |e|
  if counter.even?
    santa.make_move(e)
  else
    robo_santa.make_move(e)
  end
  
  counter += 1
end

puts (santa.get_keys + robo_santa.get_keys).uniq.count
