#!/usr/bin/env ruby

class Line
  attr_reader :command, :x1, :y1, :x2, :y2
  
  def initialize(line)
    line[/^([[[:alpha:]] ]+) (\d+),(\d+) through (\d+),(\d+)/]
    @command = $1
    @x1 = $2.to_i
    @y1 = $3.to_i
    @x2 = $4.to_i
    @y2 = $5.to_i
  end
end

class Borde
  attr_reader :size
  
  def initialize(size_x = 10, size_y = 10, def_value = 0)
    #@matrix = Array.new(size_x, Array.new(size_y, def_value))
    @matrix = Array.new(size_x) { Array.new(size_y, def_value) }
    @size = size_x * size_y
  end
  
  def execute_line(line)
    case line.command
    when 'turn on'
      turn_on(line)
    when 'turn off'
      turn_off(line)
    when 'toggle'
      toggle(line)
    else
      puts "invalid command #{line.command}"
    end
  end
  
  def print_matrix
    @matrix.each do |row|
      print '['
      row.each do |item|
        print "[#{item}], "
      end
      puts '],'
    end
  end
  
  def count_ones
    sum = 0
    @matrix.each do |row|
      row.each do |col|
        sum += col
      end
    end
    sum
  end
  
  private
  
  def set_lights(line)
    for row in (line.x1)..(line.x2) 
      for col in (line.y1)..(line.y2)
        #puts "row: #{row}, col: #{col}"
        @matrix[row][col] = yield @matrix[row][col]
      end
    end
  end
  
  def turn_on(line)
    set_lights(line) {|i| i + 1 }
  end
  
  def turn_off(line)
    set_lights(line) {|i| (i-1) > 0 ? (i-1) : 0 }
  end
  
  def toggle(line)
    set_lights(line) {|i| i + 2 }
  end
end

borde = Borde.new(1000, 1000, 0)

File.readlines(ARGV[0]).each do |line|
  l = Line.new(line)
  borde.execute_line(l)
end

borde.print_matrix if borde.size <= 100
puts borde.count_ones
