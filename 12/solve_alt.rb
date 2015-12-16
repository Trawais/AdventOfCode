require 'json'

def count_numbers(data)
  case data
    when Numeric
      return data
    when Array
      return data.inject(0) { |sum, value| sum += count_numbers(value) }
    when Hash
      return 0 if data.values.include?("red") # Only PART 2
      return data.inject(0) { |sum, (_k, value)| sum += count_numbers(value)}
    else
      0
  end
end

json = JSON.parse(File.open(ARGV[0], 'r').read)

p json.inject(0) { |sum, value| sum += count_numbers(value) }
