#!/usr/bin/env ruby
unless ARGV.length == 3
  raise 'Three arguments are required: <input_file> <steps> <part_number>'
end

def create_matrix(size, def_value = 0)
  Array.new(size) { Array.new(size, def_value) }
end

def sum_upper_row(matrix, row, col)
  sum = 0
  if row > 0
    sum += matrix[row - 1][col - 1] if col > 0
    sum += matrix[row - 1][col]
    sum += matrix[row - 1][col + 1] if col < (matrix.length - 1)
  end
  sum
end

def sum_middle_row(matrix, row, col)
  sum = 0
  sum += matrix[row][col - 1] if col > 0
  sum += matrix[row][col + 1] if col < (matrix.length - 1)
  sum
end

def sum_lower_row(matrix, row, col)
  sum = 0
  if row < (matrix.length - 1)
    sum += matrix[row + 1][col - 1] if col > 0
    sum += matrix[row + 1][col]
    sum += matrix[row + 1][col + 1] if col < (matrix.length - 1)
  end
  sum
end

def sum_neighbors(matrix, row, col)
  sum = 0
  sum += sum_upper_row(matrix, row, col)
  sum += sum_middle_row(matrix, row, col)
  sum += sum_lower_row(matrix, row, col)
  sum
end

def light_on_corners!(matrix)
  last_index = matrix.length - 1
  matrix[0][0] = 1
  matrix[0][last_index] = 1
  matrix[last_index][0] = 1
  matrix[last_index][last_index] = 1
end

# MAIN
lines = File.readlines(ARGV[0]).map(&:strip)
size = lines.length
lights_matrix = create_matrix(size)
lines.each_with_index do |line, row|
  line.each_char.with_index do |chr, col|
    lights_matrix[row][col] = 1 if chr == '#'
  end
end
# light on corners as part of initialization of matrix
light_on_corners!(lights_matrix) if ARGV[2].to_i == 2

ARGV[1].to_i.times do
  temp_matrix = create_matrix(size)
  lights_matrix.each_with_index do |line, row|
    line.each_with_index do |light, col|
      neighborhood = sum_neighbors(lights_matrix, row, col)
      if light == 1 # light is on
        temp_matrix[row][col] = neighborhood.between?(2, 3) ? 1 : 0
      else # light is off
        temp_matrix[row][col] = neighborhood == 3 ? 1 : 0
      end
    end
  end
  lights_matrix = temp_matrix
  # must be done at the end of every iteration
  light_on_corners!(lights_matrix) if ARGV[2].to_i == 2
end

# DEBUG output for small matrix
lights_matrix.each { |line| p line } if size < 10
# result output
puts lights_matrix.inject(0) { |a, e| a + e.inject(:+) }
