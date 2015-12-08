#!/usr/bin/env ruby

class Line
  def initialize(line)
    line[/^([[[:alpha:]] ]+) (\d+),(\d+) through (\d+),(\d+)/]
    @command = $1
    @s_x = $2
    @s_y = $3
    @f_x = $4
    @f_y = $5
  end
  
  def command
    return @command
  end
  
  def starting_coordinates
    return @s_x, @s_y
  end
  
  def ending_coordinates
    return @f_x, @f_y
  end
end

class Borde
  def initialize(size_x = 10, size_y = 10, def_value = 0)
    @matrix = Array.new(size_x, Array.new(size_y, def_value))
  end
  
  def execute_line(line)
    case line.command
    when 'turn on'
      turn_on(line)
    when 'turn off'
      turn_off(line)
    when 'toggle'
      toggle(line)
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
  
  private
  
  def turn_on(line)
    puts 'turn on'
  end
  
  def turn_off(line)
    puts 'turn off'
  end
  
  def toggle(line)
    puts 'toggle'
  end
end

borde = Borde.new(10, 10, 0)

File.readlines(ARGV[0]).each do |line|
  l = Line.new(line)
  borde.execute_line(l)
end

borde.print_matrix
