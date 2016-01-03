# class for parsing line into usable structures
class Line
  attr_reader :command, :x1, :y1, :x2, :y2

  def initialize(line)
    line[/^([[[:alpha:]] ]+) (\d+),(\d+) through (\d+),(\d+)/]
    assign_varibles(Regexp.last_match)
  end

  private

  def assign_varibles(matches)
    @command = matches[1]
    @x1 = matches[2].to_i
    @y1 = matches[3].to_i
    @x2 = matches[4].to_i
    @y2 = matches[5].to_i
  end
end

# base class for both boards
class Board
  attr_reader :size

  def initialize(size_x = 10, size_y = 10, def_value = 0)
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

  def toggle_lights(line)
    ((line.x1)..(line.x2)).each do |row|
      ((line.y1)..(line.y2)).each do |col|
        @matrix[row][col] = yield @matrix[row][col]
      end
    end
  end
end

# class for part 1
class BoardPart1 < Board
  private

  def turn_on(line)
    toggle_lights(line) { 1 }
  end

  def turn_off(line)
    toggle_lights(line) { 0 }
  end

  def toggle(line)
    toggle_lights(line) { |i| (i + 1) % 2 }
  end
end

# class for part 2
class BoardPart2 < Board
  private

  def turn_on(line)
    toggle_lights(line) { |i| i + 1 }
  end

  def turn_off(line)
    toggle_lights(line) { |i| (i - 1) > 0 ? (i - 1) : 0 }
  end

  def toggle(line)
    toggle_lights(line) { |i| i + 2 }
  end
end

board_1 = BoardPart1.new(1000, 1000, 0)
board_2 = BoardPart2.new(1000, 1000, 0)

File.readlines(ARGV[0]).each do |line|
  l = Line.new(line)
  board_1.execute_line(l)
  board_2.execute_line(l)
end

# board_1.print_matrix if board.size <= 100
puts "Part 1: #{board_1.count_ones}"
puts "Part 2: #{board_2.count_ones}"
