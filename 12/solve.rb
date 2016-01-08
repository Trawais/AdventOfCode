require 'json'

def count_numbers(data, part_2 = false)
  case data
  when Numeric
    return data
  when Array
    return data.inject(0) { |a, e| a + count_numbers(e, part_2) }
  when Hash
    return 0 if part_2 && data.values.include?('red') # Only PART 2
    return data.inject(0) { |a, (_k, value)| a + count_numbers(value, part_2) }
  else
    0
  end
end

json = JSON.parse(File.open(ARGV[0], 'r').read)

part_1 = json.inject(0) { |a, e| a + count_numbers(e) }
part_2 = json.inject(0) { |a, e| a + count_numbers(e, true) }

puts "Part 1 #{part_1}"
puts "Part 2 #{part_2}"
