fail 'Two arguments are required: <input_file> <litres>' unless ARGV.length == 2
containers = File.open(ARGV[0], 'r').each_line.map(&:strip).map(&:to_i).sort.reverse

part_1_counter = 0
part_2_result = 0
containers.each_index do |index|
  containers.combination(index + 1).to_a.each do |comb|
    part_1_counter +=1 if comb.inject(:+) == ARGV[1].to_i
  end
  part_2_result = part_1_counter if part_2_result == 0 && part_1_counter != 0
end

puts part_1_counter
puts part_2_result
