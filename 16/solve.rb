#!/usr/bin/env ruby
fail "Two parameters are required: <ticker_tape.txt> <input.txt>" unless ARGV.length == 2
ticker_tape = {}
File.open(ARGV[0], 'r').each_line do |line|
  key, value = line.split(': ')
  ticker_tape[key] = value.to_i
end

aunt_number_part_1 = ""
counter_part_2 = 0
File.open(ARGV[1], 'r').each_line.map(&:strip).each do |line|
  aunt_number, things = line.split(':', 2)
  result = true
  result_part_2 = true
  things.split(',').map(&:strip).each do |thing|
    key, value = thing.split(': ')
    result = result && (value.to_i == ticker_tape[key])
    # part 2
    if ['cats', 'trees'].include?(key)
      result_part_2 = result_part_2 && (value.to_i > ticker_tape[key])
    elsif ['pomeranians', 'goldfish'].include?(key)
      result_part_2 = result_part_2 && (value.to_i < ticker_tape[key])
    else
      result_part_2 = result_part_2 && (value.to_i == ticker_tape[key])
    end
    # puts "#{key} -> #{value}, part result: #{result_part_2}"
  end
  aunt_number_part_1 = aunt_number if result
  counter_part_2 += 1 if result_part_2
  # puts  if result_part_2
end

puts "part 1: #{aunt_number_part_1}"
puts "part 2: #{counter_part_2}"
